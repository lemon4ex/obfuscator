; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-- | FileCheck %s

declare float @llvm.pow.f32(float, float)
declare <4 x float> @llvm.pow.v4f32(<4 x float>, <4 x float>)

declare double @llvm.pow.f64(double, double)
declare <2 x double> @llvm.pow.v2f64(<2 x double>, <2 x double>)

define float @pow_f32_one_fourth_fmf(float %x) nounwind {
; CHECK-LABEL: pow_f32_one_fourth_fmf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fsqrt s0, s0
; CHECK-NEXT:    fsqrt s0, s0
; CHECK-NEXT:    ret
  %r = call nsz ninf afn float @llvm.pow.f32(float %x, float 2.5e-01)
  ret float %r
}

define double @pow_f64_one_fourth_fmf(double %x) nounwind {
; CHECK-LABEL: pow_f64_one_fourth_fmf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fsqrt d0, d0
; CHECK-NEXT:    fsqrt d0, d0
; CHECK-NEXT:    ret
  %r = call nsz ninf afn double @llvm.pow.f64(double %x, double 2.5e-01)
  ret double %r
}

define <4 x float> @pow_v4f32_one_fourth_fmf(<4 x float> %x) nounwind {
; CHECK-LABEL: pow_v4f32_one_fourth_fmf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fsqrt v0.4s, v0.4s
; CHECK-NEXT:    fsqrt v0.4s, v0.4s
; CHECK-NEXT:    ret
  %r = call fast <4 x float> @llvm.pow.v4f32(<4 x float> %x, <4 x float> <float 2.5e-1, float 2.5e-1, float 2.5e-01, float 2.5e-01>)
  ret <4 x float> %r
}

define <2 x double> @pow_v2f64_one_fourth_fmf(<2 x double> %x) nounwind {
; CHECK-LABEL: pow_v2f64_one_fourth_fmf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fsqrt v0.2d, v0.2d
; CHECK-NEXT:    fsqrt v0.2d, v0.2d
; CHECK-NEXT:    ret
  %r = call fast <2 x double> @llvm.pow.v2f64(<2 x double> %x, <2 x double> <double 2.5e-1, double 2.5e-1>)
  ret <2 x double> %r
}

define float @pow_f32_one_fourth_not_enough_fmf(float %x) nounwind {
; CHECK-LABEL: pow_f32_one_fourth_not_enough_fmf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov s1, #0.25000000
; CHECK-NEXT:    b powf
  %r = call afn ninf float @llvm.pow.f32(float %x, float 2.5e-01)
  ret float %r
}

define double @pow_f64_one_fourth_not_enough_fmf(double %x) nounwind {
; CHECK-LABEL: pow_f64_one_fourth_not_enough_fmf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov d1, #0.25000000
; CHECK-NEXT:    b pow
  %r = call nsz ninf double @llvm.pow.f64(double %x, double 2.5e-01)
  ret double %r
}

define <4 x float> @pow_v4f32_one_fourth_not_enough_fmf(<4 x float> %x) nounwind {
; CHECK-LABEL: pow_v4f32_one_fourth_not_enough_fmf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #48
; CHECK-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    mov s0, v0.s[1]
; CHECK-NEXT:    fmov s1, #0.25000000
; CHECK-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; CHECK-NEXT:    bl powf
; CHECK-NEXT:    str d0, [sp] // 16-byte Folded Spill
; CHECK-NEXT:    fmov s1, #0.25000000
; CHECK-NEXT:    ldr q0, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    // kill: def $s0 killed $s0 killed $q0
; CHECK-NEXT:    bl powf
; CHECK-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-NEXT:    mov v0.s[1], v1.s[0]
; CHECK-NEXT:    str q0, [sp] // 16-byte Folded Spill
; CHECK-NEXT:    ldr q0, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    fmov s1, #0.25000000
; CHECK-NEXT:    mov s0, v0.s[2]
; CHECK-NEXT:    bl powf
; CHECK-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-NEXT:    mov v1.s[2], v0.s[0]
; CHECK-NEXT:    ldr q0, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    str q1, [sp] // 16-byte Folded Spill
; CHECK-NEXT:    fmov s1, #0.25000000
; CHECK-NEXT:    mov s0, v0.s[3]
; CHECK-NEXT:    bl powf
; CHECK-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; CHECK-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-NEXT:    mov v1.s[3], v0.s[0]
; CHECK-NEXT:    mov v0.16b, v1.16b
; CHECK-NEXT:    add sp, sp, #48
; CHECK-NEXT:    ret
  %r = call afn nsz <4 x float> @llvm.pow.v4f32(<4 x float> %x, <4 x float> <float 2.5e-1, float 2.5e-1, float 2.5e-01, float 2.5e-01>)
  ret <4 x float> %r
}

define <2 x double> @pow_v2f64_one_fourth_not_enough_fmf(<2 x double> %x) nounwind {
; CHECK-LABEL: pow_v2f64_one_fourth_not_enough_fmf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #48
; CHECK-NEXT:    str q0, [sp] // 16-byte Folded Spill
; CHECK-NEXT:    mov d0, v0.d[1]
; CHECK-NEXT:    fmov d1, #0.25000000
; CHECK-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; CHECK-NEXT:    bl pow
; CHECK-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    fmov d1, #0.25000000
; CHECK-NEXT:    ldr q0, [sp] // 16-byte Folded Reload
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-NEXT:    bl pow
; CHECK-NEXT:    ldr q1, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-NEXT:    add sp, sp, #48
; CHECK-NEXT:    ret
  %r = call nsz nnan reassoc <2 x double> @llvm.pow.v2f64(<2 x double> %x, <2 x double> <double 2.5e-1, double 2.5e-1>)
  ret <2 x double> %r
}

