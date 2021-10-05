; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown       | FileCheck %s
; RUN: llc < %s -mtriple=x86_64--windows-msvc | FileCheck %s -check-prefix=CHECK-WIN

; The Windows runtime doesn't have these.
; CHECK-WIN-NOT: __ashlti3
; CHECK-WIN-NOT: __ashrti3
; CHECK-WIN-NOT: __lshrti3

define i64 @f0(i64 %val, i64 %amt) minsize optsize {
; CHECK-LABEL: f0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq %rsi, %rcx
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    # kill: def $cl killed $cl killed $rcx
; CHECK-NEXT:    shlq %cl, %rax
; CHECK-NEXT:    retq
;
; CHECK-WIN-LABEL: f0:
; CHECK-WIN:       # %bb.0:
; CHECK-WIN-NEXT:    movq %rcx, %rax
; CHECK-WIN-NEXT:    movl %edx, %ecx
; CHECK-WIN-NEXT:    shlq %cl, %rax
; CHECK-WIN-NEXT:    retq
  %res = shl i64 %val, %amt
  ret i64 %res
}

define i32 @f1(i64 %x, i64 %y) minsize optsize {
; CHECK-LABEL: f1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq %rsi, %rcx
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    # kill: def $cl killed $cl killed $rcx
; CHECK-NEXT:    shlq %cl, %rax
; CHECK-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK-NEXT:    retq
;
; CHECK-WIN-LABEL: f1:
; CHECK-WIN:       # %bb.0:
; CHECK-WIN-NEXT:    movq %rcx, %rax
; CHECK-WIN-NEXT:    movl %edx, %ecx
; CHECK-WIN-NEXT:    shlq %cl, %rax
; CHECK-WIN-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK-WIN-NEXT:    retq
	%a = shl i64 %x, %y
	%b = trunc i64 %a to i32
	ret i32 %b
}

define i32 @f2(i64 %x, i64 %y) minsize optsize {
; CHECK-LABEL: f2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq %rsi, %rcx
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    # kill: def $cl killed $cl killed $rcx
; CHECK-NEXT:    sarq %cl, %rax
; CHECK-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK-NEXT:    retq
;
; CHECK-WIN-LABEL: f2:
; CHECK-WIN:       # %bb.0:
; CHECK-WIN-NEXT:    movq %rcx, %rax
; CHECK-WIN-NEXT:    movl %edx, %ecx
; CHECK-WIN-NEXT:    sarq %cl, %rax
; CHECK-WIN-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK-WIN-NEXT:    retq
	%a = ashr i64 %x, %y
	%b = trunc i64 %a to i32
	ret i32 %b
}

define i32 @f3(i64 %x, i64 %y) minsize optsize {
; CHECK-LABEL: f3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movq %rsi, %rcx
; CHECK-NEXT:    movq %rdi, %rax
; CHECK-NEXT:    # kill: def $cl killed $cl killed $rcx
; CHECK-NEXT:    shrq %cl, %rax
; CHECK-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK-NEXT:    retq
;
; CHECK-WIN-LABEL: f3:
; CHECK-WIN:       # %bb.0:
; CHECK-WIN-NEXT:    movq %rcx, %rax
; CHECK-WIN-NEXT:    movl %edx, %ecx
; CHECK-WIN-NEXT:    shrq %cl, %rax
; CHECK-WIN-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK-WIN-NEXT:    retq
	%a = lshr i64 %x, %y
	%b = trunc i64 %a to i32
	ret i32 %b
}

define dso_local { i64, i64 } @shl128(i64 %x.coerce0, i64 %x.coerce1, i8 signext %y) minsize optsize {
; CHECK-LABEL: shl128:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    movzbl %dl, %edx
; CHECK-NEXT:    callq __ashlti3@PLT
; CHECK-NEXT:    popq %rcx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
;
; CHECK-WIN-LABEL: shl128:
; CHECK-WIN:       # %bb.0: # %entry
; CHECK-WIN-NEXT:    movq %rcx, %r9
; CHECK-WIN-NEXT:    movl %r8d, %ecx
; CHECK-WIN-NEXT:    shldq %cl, %r9, %rdx
; CHECK-WIN-NEXT:    shlq %cl, %r9
; CHECK-WIN-NEXT:    xorl %eax, %eax
; CHECK-WIN-NEXT:    testb $64, %r8b
; CHECK-WIN-NEXT:    cmovneq %r9, %rdx
; CHECK-WIN-NEXT:    cmoveq %r9, %rax
; CHECK-WIN-NEXT:    retq
entry:
  %x.sroa.2.0.insert.ext = zext i64 %x.coerce1 to i128
  %x.sroa.2.0.insert.shift = shl nuw i128 %x.sroa.2.0.insert.ext, 64
  %x.sroa.0.0.insert.ext = zext i64 %x.coerce0 to i128
  %x.sroa.0.0.insert.insert = or i128 %x.sroa.2.0.insert.shift, %x.sroa.0.0.insert.ext
  %conv = sext i8 %y to i32
  %sh_prom = zext i32 %conv to i128
  %shl = shl i128 %x.sroa.0.0.insert.insert, %sh_prom
  %retval.sroa.0.0.extract.trunc = trunc i128 %shl to i64
  %retval.sroa.2.0.extract.shift = lshr i128 %shl, 64
  %retval.sroa.2.0.extract.trunc = trunc i128 %retval.sroa.2.0.extract.shift to i64
  %.fca.0.insert = insertvalue { i64, i64 } undef, i64 %retval.sroa.0.0.extract.trunc, 0
  %.fca.1.insert = insertvalue { i64, i64 } %.fca.0.insert, i64 %retval.sroa.2.0.extract.trunc, 1
  ret { i64, i64 } %.fca.1.insert
}

define dso_local { i64, i64 } @ashr128(i64 %x.coerce0, i64 %x.coerce1, i8 signext %y) minsize optsize {
; CHECK-LABEL: ashr128:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    callq __ashrti3@PLT
; CHECK-NEXT:    popq %rcx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
;
; CHECK-WIN-LABEL: ashr128:
; CHECK-WIN:       # %bb.0: # %entry
; CHECK-WIN-NEXT:    movq %rcx, %rax
; CHECK-WIN-NEXT:    movl %r8d, %ecx
; CHECK-WIN-NEXT:    shrdq %cl, %rdx, %rax
; CHECK-WIN-NEXT:    movq %rdx, %r9
; CHECK-WIN-NEXT:    sarq %cl, %r9
; CHECK-WIN-NEXT:    sarq $63, %rdx
; CHECK-WIN-NEXT:    testb $64, %r8b
; CHECK-WIN-NEXT:    cmovneq %r9, %rax
; CHECK-WIN-NEXT:    cmoveq %r9, %rdx
; CHECK-WIN-NEXT:    retq
entry:
  %x.sroa.2.0.insert.ext = zext i64 %x.coerce1 to i128
  %x.sroa.2.0.insert.shift = shl nuw i128 %x.sroa.2.0.insert.ext, 64
  %x.sroa.0.0.insert.ext = zext i64 %x.coerce0 to i128
  %x.sroa.0.0.insert.insert = or i128 %x.sroa.2.0.insert.shift, %x.sroa.0.0.insert.ext
  %conv = sext i8 %y to i32
  %sh_prom = zext i32 %conv to i128
  %shr = ashr i128 %x.sroa.0.0.insert.insert, %sh_prom
  %retval.sroa.0.0.extract.trunc = trunc i128 %shr to i64
  %retval.sroa.2.0.extract.shift = lshr i128 %shr, 64
  %retval.sroa.2.0.extract.trunc = trunc i128 %retval.sroa.2.0.extract.shift to i64
  %.fca.0.insert = insertvalue { i64, i64 } undef, i64 %retval.sroa.0.0.extract.trunc, 0
  %.fca.1.insert = insertvalue { i64, i64 } %.fca.0.insert, i64 %retval.sroa.2.0.extract.trunc, 1
  ret { i64, i64 } %.fca.1.insert
}

define dso_local { i64, i64 } @lshr128(i64 %x.coerce0, i64 %x.coerce1, i8 signext %y) minsize optsize {
; CHECK-LABEL: lshr128:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    movzbl %dl, %edx
; CHECK-NEXT:    callq __lshrti3@PLT
; CHECK-NEXT:    popq %rcx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
;
; CHECK-WIN-LABEL: lshr128:
; CHECK-WIN:       # %bb.0: # %entry
; CHECK-WIN-NEXT:    movq %rcx, %rax
; CHECK-WIN-NEXT:    movl %r8d, %ecx
; CHECK-WIN-NEXT:    shrdq %cl, %rdx, %rax
; CHECK-WIN-NEXT:    shrq %cl, %rdx
; CHECK-WIN-NEXT:    xorl %ecx, %ecx
; CHECK-WIN-NEXT:    testb $64, %r8b
; CHECK-WIN-NEXT:    cmovneq %rdx, %rax
; CHECK-WIN-NEXT:    cmovneq %rcx, %rdx
; CHECK-WIN-NEXT:    retq
entry:
  %x.sroa.2.0.insert.ext = zext i64 %x.coerce1 to i128
  %x.sroa.2.0.insert.shift = shl nuw i128 %x.sroa.2.0.insert.ext, 64
  %x.sroa.0.0.insert.ext = zext i64 %x.coerce0 to i128
  %x.sroa.0.0.insert.insert = or i128 %x.sroa.2.0.insert.shift, %x.sroa.0.0.insert.ext
  %conv = sext i8 %y to i32
  %sh_prom = zext i32 %conv to i128
  %shr = lshr i128 %x.sroa.0.0.insert.insert, %sh_prom
  %retval.sroa.0.0.extract.trunc = trunc i128 %shr to i64
  %retval.sroa.2.0.extract.shift = lshr i128 %shr, 64
  %retval.sroa.2.0.extract.trunc = trunc i128 %retval.sroa.2.0.extract.shift to i64
  %.fca.0.insert = insertvalue { i64, i64 } undef, i64 %retval.sroa.0.0.extract.trunc, 0
  %.fca.1.insert = insertvalue { i64, i64 } %.fca.0.insert, i64 %retval.sroa.2.0.extract.trunc, 1
  ret { i64, i64 } %.fca.1.insert
}

