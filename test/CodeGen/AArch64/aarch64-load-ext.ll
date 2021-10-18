; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s --check-prefix CHECK-LE
; RUN: llc -mtriple=aarch64_be-unknown-linux-gnu < %s | FileCheck %s --check-prefix CHECK-BE

define <2 x i16> @test0(i16* %i16_ptr, i64 %inc) {
; CHECK-LE-LABEL: test0:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    ld1 { v0.h }[0], [x0]
; CHECK-LE-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: test0:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ld1 { v0.h }[0], [x0]
; CHECK-BE-NEXT:    rev64 v0.2s, v0.2s
; CHECK-BE-NEXT:    ret
  %i_0 = load i16, i16* %i16_ptr
  %v0 = insertelement <2 x i16> undef, i16 %i_0, i32 0
  ret <2 x i16> %v0
}

define <2 x i16> @test1(<2 x i16>* %v2i16_ptr) {
; CHECK-LE-LABEL: test1:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    ld1 { v0.h }[0], [x0]
; CHECK-LE-NEXT:    add x8, x0, #2
; CHECK-LE-NEXT:    ld1 { v0.h }[2], [x8]
; CHECK-LE-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: test1:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ld1 { v0.h }[0], [x0]
; CHECK-BE-NEXT:    add x8, x0, #2
; CHECK-BE-NEXT:    ld1 { v0.h }[2], [x8]
; CHECK-BE-NEXT:    rev64 v0.2s, v0.2s
; CHECK-BE-NEXT:    ret
  %v2i16 = load <2 x i16>, <2 x i16>* %v2i16_ptr
  ret <2 x i16> %v2i16
}

define <2 x i16> @test2(i16* %i16_ptr, i64 %inc) {
; CHECK-LE-LABEL: test2:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    ld1 { v0.h }[0], [x0]
; CHECK-LE-NEXT:    add x8, x0, x1, lsl #1
; CHECK-LE-NEXT:    ld1 { v0.h }[2], [x8]
; CHECK-LE-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: test2:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ld1 { v0.h }[0], [x0]
; CHECK-BE-NEXT:    add x8, x0, x1, lsl #1
; CHECK-BE-NEXT:    ld1 { v0.h }[2], [x8]
; CHECK-BE-NEXT:    rev64 v0.2s, v0.2s
; CHECK-BE-NEXT:    ret
  %i_0 = load i16, i16* %i16_ptr
  %i16_ptr_inc = getelementptr i16, i16* %i16_ptr, i64 %inc
  %i_1 = load i16, i16* %i16_ptr_inc
  %v0 = insertelement <2 x i16> undef, i16 %i_0, i32 0
  %v1 = insertelement <2 x i16> %v0, i16 %i_1, i32 1
  ret <2 x i16> %v1
}

define <2 x i8> @test3(<2 x i8>* %v2i8_ptr) {
; CHECK-LE-LABEL: test3:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    ld1 { v0.b }[0], [x0]
; CHECK-LE-NEXT:    add x8, x0, #1
; CHECK-LE-NEXT:    ld1 { v0.b }[4], [x8]
; CHECK-LE-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: test3:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ld1 { v0.b }[0], [x0]
; CHECK-BE-NEXT:    add x8, x0, #1
; CHECK-BE-NEXT:    ld1 { v0.b }[4], [x8]
; CHECK-BE-NEXT:    rev64 v0.2s, v0.2s
; CHECK-BE-NEXT:    ret
  %v2i8 = load <2 x i8>, <2 x i8>* %v2i8_ptr
  ret <2 x i8> %v2i8
}

define <4 x i8> @test4(<4 x i8>* %v4i8_ptr) {
; CHECK-LE-LABEL: test4:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    ldr s0, [x0]
; CHECK-LE-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-LE-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: test4:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ldr s0, [x0]
; CHECK-BE-NEXT:    rev32 v0.8b, v0.8b
; CHECK-BE-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-BE-NEXT:    rev64 v0.4h, v0.4h
; CHECK-BE-NEXT:    ret
  %v4i8 = load <4 x i8>, <4 x i8>* %v4i8_ptr
  ret <4 x i8> %v4i8
}

define <4 x i32> @fsext_v4i32(<4 x i8>* %a) {
; CHECK-LE-LABEL: fsext_v4i32:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    ldr s0, [x0]
; CHECK-LE-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-LE-NEXT:    sshll v0.4s, v0.4h, #0
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: fsext_v4i32:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ldr s0, [x0]
; CHECK-BE-NEXT:    rev32 v0.8b, v0.8b
; CHECK-BE-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-BE-NEXT:    sshll v0.4s, v0.4h, #0
; CHECK-BE-NEXT:    rev64 v0.4s, v0.4s
; CHECK-BE-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-BE-NEXT:    ret
  %x = load <4 x i8>, <4 x i8>* %a
  %y = sext <4 x i8> %x to <4 x i32>
  ret <4 x i32> %y
}

define <4 x i32> @fzext_v4i32(<4 x i8>* %a) {
; CHECK-LE-LABEL: fzext_v4i32:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    ldr s0, [x0]
; CHECK-LE-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-LE-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: fzext_v4i32:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ldr s0, [x0]
; CHECK-BE-NEXT:    rev32 v0.8b, v0.8b
; CHECK-BE-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-BE-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-BE-NEXT:    rev64 v0.4s, v0.4s
; CHECK-BE-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-BE-NEXT:    ret
  %x = load <4 x i8>, <4 x i8>* %a
  %y = zext <4 x i8> %x to <4 x i32>
  ret <4 x i32> %y
}

; TODO: This codegen could just be:
;   ldrb w0, [x0]
;
define i32 @loadExti32(<4 x i8>* %ref) {
; CHECK-LE-LABEL: loadExti32:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    ldr s0, [x0]
; CHECK-LE-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-LE-NEXT:    umov w8, v0.h[0]
; CHECK-LE-NEXT:    and w0, w8, #0xff
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: loadExti32:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ldr s0, [x0]
; CHECK-BE-NEXT:    rev32 v0.8b, v0.8b
; CHECK-BE-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-BE-NEXT:    umov w8, v0.h[0]
; CHECK-BE-NEXT:    and w0, w8, #0xff
; CHECK-BE-NEXT:    ret
  %a = load <4 x i8>, <4 x i8>* %ref
  %vecext = extractelement <4 x i8> %a, i32 0
  %conv = zext i8 %vecext to i32
  ret i32 %conv
}

define <4 x i16> @fsext_v4i16(<4 x i8>* %a) {
; CHECK-LE-LABEL: fsext_v4i16:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    ldr s0, [x0]
; CHECK-LE-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-LE-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: fsext_v4i16:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ldr s0, [x0]
; CHECK-BE-NEXT:    rev32 v0.8b, v0.8b
; CHECK-BE-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-BE-NEXT:    rev64 v0.4h, v0.4h
; CHECK-BE-NEXT:    ret
  %x = load <4 x i8>, <4 x i8>* %a
  %y = sext <4 x i8> %x to <4 x i16>
  ret <4 x i16> %y
}

define <4 x i16> @fzext_v4i16(<4 x i8>* %a) {
; CHECK-LE-LABEL: fzext_v4i16:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    ldr s0, [x0]
; CHECK-LE-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-LE-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: fzext_v4i16:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ldr s0, [x0]
; CHECK-BE-NEXT:    rev32 v0.8b, v0.8b
; CHECK-BE-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-BE-NEXT:    rev64 v0.4h, v0.4h
; CHECK-BE-NEXT:    ret
  %x = load <4 x i8>, <4 x i8>* %a
  %y = zext <4 x i8> %x to <4 x i16>
  ret <4 x i16> %y
}

define <4 x i16> @anyext_v4i16(<4 x i8> *%a, <4 x i8> *%b) {
; CHECK-LE-LABEL: anyext_v4i16:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    ldr s0, [x0]
; CHECK-LE-NEXT:    ldr s1, [x1]
; CHECK-LE-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-LE-NEXT:    ushll v1.8h, v1.8b, #0
; CHECK-LE-NEXT:    add v0.4h, v0.4h, v1.4h
; CHECK-LE-NEXT:    shl v0.4h, v0.4h, #8
; CHECK-LE-NEXT:    sshr v0.4h, v0.4h, #8
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: anyext_v4i16:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ldr s0, [x0]
; CHECK-BE-NEXT:    ldr s1, [x1]
; CHECK-BE-NEXT:    rev32 v0.8b, v0.8b
; CHECK-BE-NEXT:    rev32 v1.8b, v1.8b
; CHECK-BE-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-BE-NEXT:    ushll v1.8h, v1.8b, #0
; CHECK-BE-NEXT:    add v0.4h, v0.4h, v1.4h
; CHECK-BE-NEXT:    shl v0.4h, v0.4h, #8
; CHECK-BE-NEXT:    sshr v0.4h, v0.4h, #8
; CHECK-BE-NEXT:    rev64 v0.4h, v0.4h
; CHECK-BE-NEXT:    ret
  %x = load <4 x i8>, <4 x i8>* %a, align 4
  %y = load <4 x i8>, <4 x i8>* %b, align 4
  %z = add <4 x i8> %x, %y
  %s = sext <4 x i8> %z to <4 x i16>
  ret <4 x i16> %s
}

define <4 x i32> @anyext_v4i32(<4 x i8> *%a, <4 x i8> *%b) {
; CHECK-LE-LABEL: anyext_v4i32:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    ldr s0, [x0]
; CHECK-LE-NEXT:    ldr s1, [x1]
; CHECK-LE-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-LE-NEXT:    ushll v1.8h, v1.8b, #0
; CHECK-LE-NEXT:    add v0.4h, v0.4h, v1.4h
; CHECK-LE-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-LE-NEXT:    shl v0.4s, v0.4s, #24
; CHECK-LE-NEXT:    sshr v0.4s, v0.4s, #24
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: anyext_v4i32:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ldr s0, [x0]
; CHECK-BE-NEXT:    ldr s1, [x1]
; CHECK-BE-NEXT:    rev32 v0.8b, v0.8b
; CHECK-BE-NEXT:    rev32 v1.8b, v1.8b
; CHECK-BE-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-BE-NEXT:    ushll v1.8h, v1.8b, #0
; CHECK-BE-NEXT:    add v0.4h, v0.4h, v1.4h
; CHECK-BE-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-BE-NEXT:    shl v0.4s, v0.4s, #24
; CHECK-BE-NEXT:    sshr v0.4s, v0.4s, #24
; CHECK-BE-NEXT:    rev64 v0.4s, v0.4s
; CHECK-BE-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-BE-NEXT:    ret
  %x = load <4 x i8>, <4 x i8>* %a, align 4
  %y = load <4 x i8>, <4 x i8>* %b, align 4
  %z = add <4 x i8> %x, %y
  %s = sext <4 x i8> %z to <4 x i32>
  ret <4 x i32> %s
}
