//===- DependencyScanningWorker.cpp - clang-scan-deps worker --------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "clang/Tooling/DependencyScanning/DependencyScanningWorker.h"
#include "clang/CodeGen/ObjectFilePCHContainerOperations.h"
#include "clang/Frontend/CompilerInstance.h"
#include "clang/Frontend/CompilerInvocation.h"
#include "clang/Frontend/FrontendActions.h"
#include "clang/Frontend/TextDiagnosticPrinter.h"
#include "clang/Frontend/Utils.h"
#include "clang/Lex/PreprocessorOptions.h"
#include "clang/Tooling/DependencyScanning/DependencyScanningService.h"
#include "clang/Tooling/DependencyScanning/ModuleDepCollector.h"
#include "clang/Tooling/Tooling.h"

using namespace clang;
using namespace tooling;
using namespace dependencies;

namespace {

/// Forwards the gatherered dependencies to the consumer.
class DependencyConsumerForwarder : public DependencyFileGenerator {
public:
  DependencyConsumerForwarder(std::unique_ptr<DependencyOutputOptions> Opts,
                              DependencyConsumer &C)
      : DependencyFileGenerator(*Opts), Opts(std::move(Opts)), C(C) {}

  void finishedMainFile(DiagnosticsEngine &Diags) override {
    C.handleDependencyOutputOpts(*Opts);
    llvm::SmallString<256> CanonPath;
    for (const auto &File : getDependencies()) {
      CanonPath = File;
      llvm::sys::path::remove_dots(CanonPath, /*remove_dot_dot=*/true);
      C.handleFileDependency(CanonPath);
    }
  }

private:
  std::unique_ptr<DependencyOutputOptions> Opts;
  DependencyConsumer &C;
};

/// A listener that collects the names and paths to imported modules.
class ImportCollectingListener : public ASTReaderListener {
  using PrebuiltModuleFilesT =
      decltype(HeaderSearchOptions::PrebuiltModuleFiles);

public:
  ImportCollectingListener(PrebuiltModuleFilesT &PrebuiltModuleFiles)
      : PrebuiltModuleFiles(PrebuiltModuleFiles) {}

  bool needsImportVisitation() const override { return true; }

  void visitImport(StringRef ModuleName, StringRef Filename) override {
    PrebuiltModuleFiles[std::string(ModuleName)] = std::string(Filename);
  }

private:
  PrebuiltModuleFilesT &PrebuiltModuleFiles;
};

/// Transform arbitrary file name into an object-like file name.
static std::string makeObjFileName(StringRef FileName) {
  SmallString<128> ObjFileName(FileName);
  llvm::sys::path::replace_extension(ObjFileName, "o");
  return std::string(ObjFileName.str());
}

/// Deduce the dependency target based on the output file and input files.
static std::string
deduceDepTarget(const std::string &OutputFile,
                const SmallVectorImpl<FrontendInputFile> &InputFiles) {
  if (OutputFile != "-")
    return OutputFile;

  if (InputFiles.empty() || !InputFiles.front().isFile())
    return "clang-scan-deps\\ dependency";

  return makeObjFileName(InputFiles.front().getFile());
}

/// A clang tool that runs the preprocessor in a mode that's optimized for
/// dependency scanning for the given compiler invocation.
class DependencyScanningAction : public tooling::ToolAction {
public:
  DependencyScanningAction(
      StringRef WorkingDirectory, DependencyConsumer &Consumer,
      llvm::IntrusiveRefCntPtr<DependencyScanningWorkerFilesystem> DepFS,
      ExcludedPreprocessorDirectiveSkipMapping *PPSkipMappings,
      ScanningOutputFormat Format)
      : WorkingDirectory(WorkingDirectory), Consumer(Consumer),
        DepFS(std::move(DepFS)), PPSkipMappings(PPSkipMappings),
        Format(Format) {}

  bool runInvocation(std::shared_ptr<CompilerInvocation> Invocation,
                     FileManager *FileMgr,
                     std::shared_ptr<PCHContainerOperations> PCHContainerOps,
                     DiagnosticConsumer *DiagConsumer) override {
    // Make a deep copy of the original Clang invocation.
    CompilerInvocation OriginalInvocation(*Invocation);

    // Create a compiler instance to handle the actual work.
    CompilerInstance Compiler(std::move(PCHContainerOps));
    Compiler.setInvocation(std::move(Invocation));

    // Don't print 'X warnings and Y errors generated'.
    Compiler.getDiagnosticOpts().ShowCarets = false;
    // Don't write out diagnostic file.
    Compiler.getDiagnosticOpts().DiagnosticSerializationFile.clear();
    // Don't treat warnings as errors.
    Compiler.getDiagnosticOpts().Warnings.push_back("no-error");
    // Create the compiler's actual diagnostics engine.
    Compiler.createDiagnostics(DiagConsumer, /*ShouldOwnClient=*/false);
    if (!Compiler.hasDiagnostics())
      return false;

    Compiler.getPreprocessorOpts().AllowPCHWithDifferentModulesCachePath = true;

    // Use the dependency scanning optimized file system if we can.
    if (DepFS) {
      const CompilerInvocation &CI = Compiler.getInvocation();
      // Add any filenames that were explicity passed in the build settings and
      // that might be opened, as we want to ensure we don't run source
      // minimization on them.
      DepFS->IgnoredFiles.clear();
      for (const auto &Entry : CI.getHeaderSearchOpts().UserEntries)
        DepFS->IgnoredFiles.insert(Entry.Path);
      for (const auto &Entry : CI.getHeaderSearchOpts().VFSOverlayFiles)
        DepFS->IgnoredFiles.insert(Entry);

      // Support for virtual file system overlays on top of the caching
      // filesystem.
      FileMgr->setVirtualFileSystem(createVFSFromCompilerInvocation(
          CI, Compiler.getDiagnostics(), DepFS));

      // Pass the skip mappings which should speed up excluded conditional block
      // skipping in the preprocessor.
      if (PPSkipMappings)
        Compiler.getPreprocessorOpts()
            .ExcludedConditionalDirectiveSkipMappings = PPSkipMappings;
    }

    FileMgr->getFileSystemOpts().WorkingDir = std::string(WorkingDirectory);
    Compiler.setFileManager(FileMgr);
    Compiler.createSourceManager(*FileMgr);

    if (!Compiler.getPreprocessorOpts().ImplicitPCHInclude.empty()) {
      // Collect the modules that were prebuilt as part of the PCH and pass them
      // to the compiler. This will prevent the implicit build to create
      // duplicate modules and force reuse of existing prebuilt module files
      // instead.
      ImportCollectingListener Listener(
          Compiler.getHeaderSearchOpts().PrebuiltModuleFiles);
      ASTReader::readASTFileControlBlock(
          Compiler.getPreprocessorOpts().ImplicitPCHInclude,
          Compiler.getFileManager(), Compiler.getPCHContainerReader(),
          /*FindModuleFileExtensions=*/false, Listener,
          /*ValidateDiagnosticOptions=*/false);
    }

    // Create the dependency collector that will collect the produced
    // dependencies.
    //
    // This also moves the existing dependency output options from the
    // invocation to the collector. The options in the invocation are reset,
    // which ensures that the compiler won't create new dependency collectors,
    // and thus won't write out the extra '.d' files to disk.
    auto Opts = std::make_unique<DependencyOutputOptions>();
    std::swap(*Opts, Compiler.getInvocation().getDependencyOutputOpts());
    // We need at least one -MT equivalent for the generator of make dependency
    // files to work.
    if (Opts->Targets.empty())
      Opts->Targets = {deduceDepTarget(Compiler.getFrontendOpts().OutputFile,
                                       Compiler.getFrontendOpts().Inputs)};
    Opts->IncludeSystemHeaders = true;

    switch (Format) {
    case ScanningOutputFormat::Make:
      Compiler.addDependencyCollector(
          std::make_shared<DependencyConsumerForwarder>(std::move(Opts),
                                                        Consumer));
      break;
    case ScanningOutputFormat::Full:
      Compiler.addDependencyCollector(std::make_shared<ModuleDepCollector>(
          std::move(Opts), Compiler, Consumer, std::move(OriginalInvocation)));
      break;
    }

    // Consider different header search and diagnostic options to create
    // different modules. This avoids the unsound aliasing of module PCMs.
    //
    // TODO: Implement diagnostic bucketing and header search pruning to reduce
    // the impact of strict context hashing.
    Compiler.getHeaderSearchOpts().ModulesStrictContextHash = true;

    auto Action = std::make_unique<ReadPCHAndPreprocessAction>();
    const bool Result = Compiler.ExecuteAction(*Action);
    if (!DepFS)
      FileMgr->clearStatCache();
    return Result;
  }

private:
  StringRef WorkingDirectory;
  DependencyConsumer &Consumer;
  llvm::IntrusiveRefCntPtr<DependencyScanningWorkerFilesystem> DepFS;
  ExcludedPreprocessorDirectiveSkipMapping *PPSkipMappings;
  ScanningOutputFormat Format;
};

} // end anonymous namespace

DependencyScanningWorker::DependencyScanningWorker(
    DependencyScanningService &Service)
    : Format(Service.getFormat()) {
  DiagOpts = new DiagnosticOptions();

  PCHContainerOps = std::make_shared<PCHContainerOperations>();
  PCHContainerOps->registerReader(
      std::make_unique<ObjectFilePCHContainerReader>());
  // We don't need to write object files, but the current PCH implementation
  // requires the writer to be registered as well.
  PCHContainerOps->registerWriter(
      std::make_unique<ObjectFilePCHContainerWriter>());

  RealFS = llvm::vfs::createPhysicalFileSystem();
  if (Service.canSkipExcludedPPRanges())
    PPSkipMappings =
        std::make_unique<ExcludedPreprocessorDirectiveSkipMapping>();
  if (Service.getMode() == ScanningMode::MinimizedSourcePreprocessing)
    DepFS = new DependencyScanningWorkerFilesystem(
        Service.getSharedCache(), RealFS, PPSkipMappings.get());
  if (Service.canReuseFileManager())
    Files = new FileManager(FileSystemOptions(), RealFS);
}

static llvm::Error runWithDiags(
    DiagnosticOptions *DiagOpts,
    llvm::function_ref<bool(DiagnosticConsumer &DC)> BodyShouldSucceed) {
  // Capture the emitted diagnostics and report them to the client
  // in the case of a failure.
  std::string DiagnosticOutput;
  llvm::raw_string_ostream DiagnosticsOS(DiagnosticOutput);
  TextDiagnosticPrinter DiagPrinter(DiagnosticsOS, DiagOpts);

  if (BodyShouldSucceed(DiagPrinter))
    return llvm::Error::success();
  return llvm::make_error<llvm::StringError>(DiagnosticsOS.str(),
                                             llvm::inconvertibleErrorCode());
}

llvm::Error DependencyScanningWorker::computeDependencies(
    const std::string &Input, StringRef WorkingDirectory,
    const CompilationDatabase &CDB, DependencyConsumer &Consumer) {
  RealFS->setCurrentWorkingDirectory(WorkingDirectory);
  return runWithDiags(DiagOpts.get(), [&](DiagnosticConsumer &DC) {
    /// Create the tool that uses the underlying file system to ensure that any
    /// file system requests that are made by the driver do not go through the
    /// dependency scanning filesystem.
    tooling::ClangTool Tool(CDB, Input, PCHContainerOps, RealFS, Files);
    Tool.clearArgumentsAdjusters();
    Tool.setRestoreWorkingDir(false);
    Tool.setPrintErrorMessage(false);
    Tool.setDiagnosticConsumer(&DC);
    DependencyScanningAction Action(WorkingDirectory, Consumer, DepFS,
                                    PPSkipMappings.get(), Format);
    return !Tool.run(&Action);
  });
}

llvm::Error DependencyScanningWorker::computeDependenciesForClangInvocation(
    StringRef WorkingDirectory, ArrayRef<std::string> Arguments,
    DependencyConsumer &Consumer) {
  RealFS->setCurrentWorkingDirectory(WorkingDirectory);
  return runWithDiags(DiagOpts.get(), [&](DiagnosticConsumer &DC) {
    IntrusiveRefCntPtr<DiagnosticIDs> DiagID = new DiagnosticIDs();
    IntrusiveRefCntPtr<DiagnosticOptions> DiagOpts = new DiagnosticOptions();
    DiagnosticsEngine Diags(DiagID, &*DiagOpts, &DC, /*ShouldOwnClient=*/false);

    llvm::opt::ArgStringList CC1Args;
    for (const auto &Arg : Arguments)
      CC1Args.push_back(Arg.c_str());
    std::unique_ptr<CompilerInvocation> Invocation(
        newInvocation(&Diags, CC1Args, /*BinaryName=*/nullptr));

    DependencyScanningAction Action(WorkingDirectory, Consumer, DepFS,
                                    PPSkipMappings.get(), Format);

    llvm::IntrusiveRefCntPtr<FileManager> FM = Files;
    if (!FM)
      FM = new FileManager(FileSystemOptions(), RealFS);
    return Action.runInvocation(std::move(Invocation), FM.get(),
                                PCHContainerOps, &DC);
  });
}
