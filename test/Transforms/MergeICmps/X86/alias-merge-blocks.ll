; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown-unknown -mergeicmps -verify-dom-info -S | FileCheck %s --check-prefix=X86

%S = type { i32, i32, i32, i32 }

define zeroext i1 @opeq1(
; X86-LABEL: @opeq1(
; X86-NEXT:  "entry+land.rhs.i+land.rhs.i.2+land.rhs.i.3":
; X86-NEXT:    [[PTR:%.*]] = alloca i32, align 4
; X86-NEXT:    store i32 42, i32* [[PTR]], align 4
; X86-NEXT:    [[TMP0:%.*]] = getelementptr inbounds [[S:%.*]], %S* [[A:%.*]], i64 0, i32 0
; X86-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [[S]], %S* [[B:%.*]], i64 0, i32 0
; X86-NEXT:    [[CSTR:%.*]] = bitcast i32* [[TMP0]] to i8*
; X86-NEXT:    [[CSTR1:%.*]] = bitcast i32* [[TMP1]] to i8*
; X86-NEXT:    [[MEMCMP:%.*]] = call i32 @memcmp(i8* [[CSTR]], i8* [[CSTR1]], i64 16)
; X86-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[MEMCMP]], 0
; X86-NEXT:    br label [[OPEQ1_EXIT:%.*]]
; X86:       opeq1.exit:
; X86-NEXT:    ret i1 [[TMP2]]
;
  %S* nocapture readonly dereferenceable(16) %a,
  %S* nocapture readonly dereferenceable(16) %b) local_unnamed_addr #0 {

entry:
  %ptr = alloca i32
  %first.i = getelementptr inbounds %S, %S* %a, i64 0, i32 0
  %0 = load i32, i32* %first.i, align 4
  %first1.i = getelementptr inbounds %S, %S* %b, i64 0, i32 0
  %1 = load i32, i32* %first1.i, align 4
  ; Does other work, has no interference, merge block
  store i32 42, i32* %ptr
  %cmp.i = icmp eq i32 %0, %1
  br i1 %cmp.i, label %land.rhs.i, label %opeq1.exit

land.rhs.i:
  %second.i = getelementptr inbounds %S, %S* %a, i64 0, i32 1
  %2 = load i32, i32* %second.i, align 4
  %second2.i = getelementptr inbounds %S, %S* %b, i64 0, i32 1
  %3 = load i32, i32* %second2.i, align 4
  %cmp2.i = icmp eq i32 %2, %3
  br i1 %cmp2.i, label %land.rhs.i.2, label %opeq1.exit

land.rhs.i.2:
  %third.i = getelementptr inbounds %S, %S* %a, i64 0, i32 2
  %4 = load i32, i32* %third.i, align 4
  %third2.i = getelementptr inbounds %S, %S* %b, i64 0, i32 2
  %5 = load i32, i32* %third2.i, align 4
  %cmp3.i = icmp eq i32 %4, %5
  br i1 %cmp3.i, label %land.rhs.i.3, label %opeq1.exit

land.rhs.i.3:
  %fourth.i = getelementptr inbounds %S, %S* %a, i64 0, i32 3
  %6 = load i32, i32* %fourth.i, align 4
  %fourth2.i = getelementptr inbounds %S, %S* %b, i64 0, i32 3
  %7 = load i32, i32* %fourth2.i, align 4
  %cmp4.i = icmp eq i32 %6, %7
  br label %opeq1.exit

opeq1.exit:
  %8 = phi i1 [ false, %entry ], [ false, %land.rhs.i] , [ false, %land.rhs.i.2 ], [ %cmp4.i, %land.rhs.i.3 ]
  ret i1 %8
}
