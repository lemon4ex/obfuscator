; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instsimplify -S | FileCheck %s

define i32 @sub_self(i32 %A) {
; CHECK-LABEL: @sub_self(
; CHECK-NEXT:    ret i32 0
;
  %B = sub i32 %A, %A
  ret i32 %B
}

define <2 x i32> @sub_self_vec(<2 x i32> %A) {
; CHECK-LABEL: @sub_self_vec(
; CHECK-NEXT:    ret <2 x i32> zeroinitializer
;
  %B = sub <2 x i32> %A, %A
  ret <2 x i32> %B
}

define i32 @sub_zero(i32 %A) {
; CHECK-LABEL: @sub_zero(
; CHECK-NEXT:    ret i32 [[A:%.*]]
;
  %B = sub i32 %A, 0
  ret i32 %B
}

define <2 x i32> @sub_zero_vec(<2 x i32> %A) {
; CHECK-LABEL: @sub_zero_vec(
; CHECK-NEXT:    ret <2 x i32> [[A:%.*]]
;
  %B = sub <2 x i32> %A, <i32 0, i32 undef>
  ret <2 x i32> %B
}

define i32 @neg_neg(i32 %A) {
; CHECK-LABEL: @neg_neg(
; CHECK-NEXT:    ret i32 [[A:%.*]]
;
  %B = sub i32 0, %A
  %C = sub i32 0, %B
  ret i32 %C
}

define <2 x i32> @neg_neg_vec(<2 x i32> %A) {
; CHECK-LABEL: @neg_neg_vec(
; CHECK-NEXT:    ret <2 x i32> [[A:%.*]]
;
  %B = sub <2 x i32> <i32 0, i32 undef>, %A
  %C = sub <2 x i32> <i32 0, i32 undef>, %B
  ret <2 x i32> %C
}

define i32 @poison1(i32 %x) {
; CHECK-LABEL: @poison1(
; CHECK-NEXT:    ret i32 poison
;
  %v = sub i32 %x, poison
  ret i32 %v
}

define i32 @poison2(i32 %x) {
; CHECK-LABEL: @poison2(
; CHECK-NEXT:    ret i32 poison
;
  %v = sub i32 poison, %x
  ret i32 %v
}
