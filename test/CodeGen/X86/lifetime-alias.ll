; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu  | FileCheck %s -check-prefix=CHECK

source_filename = "test_case.cc"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.std::__3::basic_string" = type { %"class.std::__3::__compressed_pair" }
%"class.std::__3::__compressed_pair" = type { %"struct.std::__3::__compressed_pair_elem" }
%"struct.std::__3::__compressed_pair_elem" = type { %"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__rep" }
%"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__rep" = type { %union.anon }
%union.anon = type { %"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__long" }
%"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__long" = type { i8*, i64, i64 }
%struct.Agg = type { %"class.std::__3::basic_string", %"class.std::__3::basic_string" }
%"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__short" = type { [23 x i8], %struct.anon }
%struct.anon = type { i8 }

@do_not_optimize = dso_local global i8* null, align 8
@.str = private unnamed_addr constant [12 x i8] c"The Culture\00", align 1
@.str.1 = private unnamed_addr constant [22 x i8] c"FunnyItWorkedLastTime\00", align 1
@.str.2 = private unnamed_addr constant [19 x i8] c"agg.a2_[16] == 't'\00", align 1
@.str.3 = private unnamed_addr constant [13 x i8] c"test_case.cc\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1

; Function Attrs: norecurse uwtable
define i8 @main() local_unnamed_addr #0 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
; CHECK-LABEL: main:
; CHECK:       # %bb.0: # %_ZNSt3__312basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED2Ev.exit50
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    movaps {{.*#+}} xmm0 = [97,97,97,97,97,97,97,97,97,97,97,97,97,97,97,97]
; CHECK-NEXT:    movaps %xmm0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movabsq $7016996765293437281, %rax # imm = 0x6161616161616161
; CHECK-NEXT:    movq %rax, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $5632, {{[0-9]+}}(%rsp) # imm = 0x1600
; CHECK-NEXT:    xorps %xmm0, %xmm0
; CHECK-NEXT:    movaps %xmm0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $11, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movabsq $8389209137051166804, %rax # imm = 0x746C754320656854
; CHECK-NEXT:    movq %rax, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movl $1701999988, -{{[0-9]+}}(%rsp) # imm = 0x65727574
; CHECK-NEXT:    movb $0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movaps %xmm0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $21, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movabsq $7308613581744070988, %rax # imm = 0x656D69547473614C
; CHECK-NEXT:    movq %rax, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movups .L.str.1(%rip), %xmm1
; CHECK-NEXT:    movaps %xmm1, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq -{{[0-9]+}}(%rsp), %rax
; CHECK-NEXT:    movq %rax, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq -{{[0-9]+}}(%rsp), %rax
; CHECK-NEXT:    movq %rax, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movzwl -{{[0-9]+}}(%rsp), %eax
; CHECK-NEXT:    movw %ax, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; CHECK-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb -{{[0-9]+}}(%rsp), %al
; CHECK-NEXT:    movb %al, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movl -{{[0-9]+}}(%rsp), %eax
; CHECK-NEXT:    movl %eax, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movaps %xmm0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq -{{[0-9]+}}(%rsp), %rax
; CHECK-NEXT:    movq %rax, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movaps -{{[0-9]+}}(%rsp), %xmm1
; CHECK-NEXT:    movups %xmm1, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movaps %xmm0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    movq $0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    leaq -{{[0-9]+}}(%rsp), %rax
; CHECK-NEXT:    movq %rax, do_not_optimize(%rip)
; CHECK-NEXT:    leaq -{{[0-9]+}}(%rsp), %rax
; CHECK-NEXT:    movq %rax, do_not_optimize(%rip)
; CHECK-NEXT:    cmpb $0, -{{[0-9]+}}(%rsp)
; CHECK-NEXT:    jns .LBB0_1
; CHECK-NEXT:  # %bb.2: # %_ZNSt3__312basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED2Ev.exit50
; CHECK-NEXT:    movq -{{[0-9]+}}(%rsp), %rax
; CHECK-NEXT:    jmp .LBB0_3
; CHECK-NEXT:  .LBB0_1:
; CHECK-NEXT:    leaq -{{[0-9]+}}(%rsp), %rax
; CHECK-NEXT:  .LBB0_3: # %_ZNSt3__312basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED2Ev.exit50
; CHECK-NEXT:    movb 16(%rax), %al
; CHECK-NEXT:    popq %rcx
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
_ZNSt3__312basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED2Ev.exit50:
  %padding = alloca %"class.std::__3::basic_string", align 8
  %agg = alloca %struct.Agg, align 8
  %agg.tmp = alloca %"class.std::__3::basic_string", align 8
  %agg.tmp1 = alloca %"class.std::__3::basic_string", align 8
  %0 = bitcast %"class.std::__3::basic_string"* %padding to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %0) #4
  %__s2.i.i.i = bitcast %"class.std::__3::basic_string"* %padding to %"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__short"*
  %__size_.i23.i.i = getelementptr inbounds %"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__short", %"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__short"* %__s2.i.i.i, i64 0, i32 1, i32 0
  store i8 22, i8* %__size_.i23.i.i, align 1, !tbaa !2
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %0, i8 97, i64 22, i1 false) #4
  %arrayidx.i.i = getelementptr inbounds i8, i8* %0, i64 22
  store i8 0, i8* %arrayidx.i.i, align 2, !tbaa !2
  %1 = bitcast %struct.Agg* %agg to i8*
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %1) #4
  %2 = bitcast %"class.std::__3::basic_string"* %agg.tmp to i8*
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %2, i8 0, i64 24, i1 false) #4
  %__s2.i.i.i10 = bitcast %"class.std::__3::basic_string"* %agg.tmp to %"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__short"*
  %__size_.i23.i.i11 = getelementptr inbounds %"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__short", %"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__short"* %__s2.i.i.i10, i64 0, i32 1, i32 0
  store i8 11, i8* %__size_.i23.i.i11, align 1, !tbaa !2
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 %2, i8* align 1 getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i64 0, i64 0), i64 11, i1 false) #4
  %arrayidx.i.i12 = getelementptr inbounds i8, i8* %2, i64 11
  store i8 0, i8* %arrayidx.i.i12, align 1, !tbaa !2
  %3 = bitcast %"class.std::__3::basic_string"* %agg.tmp1 to i8*
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %3, i8 0, i64 24, i1 false) #4
  %__s2.i.i.i27 = bitcast %"class.std::__3::basic_string"* %agg.tmp1 to %"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__short"*
  %__size_.i23.i.i28 = getelementptr inbounds %"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__short", %"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__short"* %__s2.i.i.i27, i64 0, i32 1, i32 0
  store i8 21, i8* %__size_.i23.i.i28, align 1, !tbaa !2
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 %3, i8* align 1 getelementptr inbounds ([22 x i8], [22 x i8]* @.str.1, i64 0, i64 0), i64 21, i1 false) #4
  %arrayidx.i.i34 = getelementptr inbounds i8, i8* %3, i64 21
  store i8 0, i8* %arrayidx.i.i34, align 1, !tbaa !2
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 %1, i8* nonnull align 8 %2, i64 24, i1 false) #4
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %2, i8 0, i64 24, i1 false) #4
  %a2_.i = getelementptr inbounds %struct.Agg, %struct.Agg* %agg, i64 0, i32 1
  %4 = bitcast %"class.std::__3::basic_string"* %a2_.i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 8 %4, i8* nonnull align 8 %3, i64 24, i1 false) #4
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %3, i8 0, i64 24, i1 false) #4
  store volatile i8* %0, i8** @do_not_optimize, align 8, !tbaa !5
  store volatile i8* %1, i8** @do_not_optimize, align 8, !tbaa !5
  %__s.i.i.i = bitcast %"class.std::__3::basic_string"* %a2_.i to %"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__short"*
  %__size_.i.i.i51 = getelementptr inbounds %"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__short", %"struct.std::__3::basic_string<char, std::__3::char_traits<char>, std::__3::allocator<char> >::__short"* %__s.i.i.i, i64 0, i32 1, i32 0
  %5 = load i8, i8* %__size_.i.i.i51, align 1, !tbaa !2
  %tobool.i.i.i = icmp slt i8 %5, 0
  %__data_.i.i.i52 = getelementptr inbounds %"class.std::__3::basic_string", %"class.std::__3::basic_string"* %a2_.i, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %6 = load i8*, i8** %__data_.i.i.i52, align 8
  %cond.i.i = select i1 %tobool.i.i.i, i8* %6, i8* %4
  %add.ptr.i = getelementptr inbounds i8, i8* %cond.i.i, i64 16
  %7 = load i8, i8* %add.ptr.i, align 1, !tbaa !2
  ret i8 %7
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

declare dso_local i32 @__gxx_personality_v0(...)

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #1

attributes #0 = { norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "frame-pointer"="none" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "frame-pointer"="none" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nobuiltin nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "frame-pointer"="none" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { noreturn nounwind }
attributes #6 = { builtin nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 9.0.0 (https://git.llvm.org/git/clang.git 6bb42abb270b5879a3acd289ca42341115a3cb46) (https://git.llvm.org/git/llvm.git ab39cf6afa9acdc108d16e7194a0d82619b044d6)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C++ TBAA"}
!5 = !{!6, !6, i64 0}
!6 = !{!"any pointer", !3, i64 0}
