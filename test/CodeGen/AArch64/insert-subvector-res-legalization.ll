; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s | FileCheck %s

target triple = "aarch64-unknown-linux-gnu"

; SCALABLE INSERTED INTO SCALABLE TESTS

define <vscale x 8 x i8> @vec_scalable_subvec_scalable_idx_zero_i8(<vscale x 8 x i8>* %a, <vscale x 4 x i8>* %b) #0 {
; CHECK-LABEL: vec_scalable_subvec_scalable_idx_zero_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    ld1b { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1b { z1.s }, p0/z, [x1]
; CHECK-NEXT:    uunpkhi z0.s, z0.h
; CHECK-NEXT:    uzp1 z0.h, z1.h, z0.h
; CHECK-NEXT:    ret
  %vec = load <vscale x 8 x i8>, <vscale x 8 x i8>* %a
  %subvec = load <vscale x 4 x i8>, <vscale x 4 x i8>* %b
  %ins = call <vscale x 8 x i8> @llvm.experimental.vector.insert.nxv8i8.nxv4i8(<vscale x 8 x i8> %vec, <vscale x 4 x i8> %subvec, i64 0)
  ret <vscale x 8 x i8> %ins
}

define <vscale x 8 x i8> @vec_scalable_subvec_scalable_idx_nonzero_i8(<vscale x 8 x i8>* %a, <vscale x 4 x i8>* %b) #0 {
; CHECK-LABEL: vec_scalable_subvec_scalable_idx_nonzero_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    ld1b { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1b { z1.s }, p0/z, [x1]
; CHECK-NEXT:    uunpklo z0.s, z0.h
; CHECK-NEXT:    uzp1 z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %vec = load <vscale x 8 x i8>, <vscale x 8 x i8>* %a
  %subvec = load <vscale x 4 x i8>, <vscale x 4 x i8>* %b
  %ins = call <vscale x 8 x i8> @llvm.experimental.vector.insert.nxv8i8.nxv4i8(<vscale x 8 x i8> %vec, <vscale x 4 x i8> %subvec, i64 4)
  ret <vscale x 8 x i8> %ins
}

define <vscale x 4 x i16> @vec_scalable_subvec_scalable_idx_zero_i16(<vscale x 4 x i16>* %a, <vscale x 2 x i16>* %b) #0 {
; CHECK-LABEL: vec_scalable_subvec_scalable_idx_zero_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1h { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ld1h { z1.d }, p0/z, [x1]
; CHECK-NEXT:    uunpkhi z0.d, z0.s
; CHECK-NEXT:    uzp1 z0.s, z1.s, z0.s
; CHECK-NEXT:    ret
  %vec = load <vscale x 4 x i16>, <vscale x 4 x i16>* %a
  %subvec = load <vscale x 2 x i16>, <vscale x 2 x i16>* %b
  %ins = call <vscale x 4 x i16> @llvm.experimental.vector.insert.nxv4i16.nxv2i16(<vscale x 4 x i16> %vec, <vscale x 2 x i16> %subvec, i64 0)
  ret <vscale x 4 x i16> %ins
}

define <vscale x 4 x i16> @vec_scalable_subvec_scalable_idx_nonzero_i16(<vscale x 4 x i16>* %a, <vscale x 2 x i16>* %b) #0 {
; CHECK-LABEL: vec_scalable_subvec_scalable_idx_nonzero_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1h { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ld1h { z1.d }, p0/z, [x1]
; CHECK-NEXT:    uunpklo z0.d, z0.s
; CHECK-NEXT:    uzp1 z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %vec = load <vscale x 4 x i16>, <vscale x 4 x i16>* %a
  %subvec = load <vscale x 2 x i16>, <vscale x 2 x i16>* %b
  %ins = call <vscale x 4 x i16> @llvm.experimental.vector.insert.nxv4i16.nxv2i16(<vscale x 4 x i16> %vec, <vscale x 2 x i16> %subvec, i64 2)
  ret <vscale x 4 x i16> %ins
}

; FIXED INSERTED INTO SCALABLE TESTS

define <vscale x 8 x i8> @vec_scalable_subvec_fixed_idx_zero_i8(<vscale x 8 x i8>* %a, <8 x i8>* %b) #0 {
; CHECK-LABEL: vec_scalable_subvec_fixed_idx_zero_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    ld1b { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    st1h { z0.h }, p0, [sp]
; CHECK-NEXT:    ushll v0.8h, v1.8b, #0
; CHECK-NEXT:    str q0, [sp]
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [sp]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %vec = load <vscale x 8 x i8>, <vscale x 8 x i8>* %a
  %subvec = load <8 x i8>, <8 x i8>* %b
  %ins = call <vscale x 8 x i8> @llvm.experimental.vector.insert.nxv8i8.v8i8(<vscale x 8 x i8> %vec, <8 x i8> %subvec, i64 0)
  ret <vscale x 8 x i8> %ins
}

define <vscale x 8 x i8> @vec_scalable_subvec_fixed_idx_nonzero_i8(<vscale x 8 x i8>* %a, <8 x i8>* %b) #0 {
; CHECK-LABEL: vec_scalable_subvec_fixed_idx_nonzero_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    ld1b { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    cnth x9
; CHECK-NEXT:    sub x9, x9, #8 // =8
; CHECK-NEXT:    mov w8, #8
; CHECK-NEXT:    cmp x9, #8 // =8
; CHECK-NEXT:    csel x8, x9, x8, lo
; CHECK-NEXT:    lsl x8, x8, #1
; CHECK-NEXT:    st1h { z0.h }, p0, [sp]
; CHECK-NEXT:    ushll v0.8h, v1.8b, #0
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    str q0, [x9, x8]
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [sp]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %vec = load <vscale x 8 x i8>, <vscale x 8 x i8>* %a
  %subvec = load <8 x i8>, <8 x i8>* %b
  %ins = call <vscale x 8 x i8> @llvm.experimental.vector.insert.nxv8i8.v8i8(<vscale x 8 x i8> %vec, <8 x i8> %subvec, i64 8)
  ret <vscale x 8 x i8> %ins
}

define <vscale x 4 x i16> @vec_scalable_subvec_fixed_idx_zero_i16(<vscale x 4 x i16>* %a, <4 x i16>* %b) #0 {
; CHECK-LABEL: vec_scalable_subvec_fixed_idx_zero_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1h { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    st1w { z0.s }, p0, [sp]
; CHECK-NEXT:    ushll v0.4s, v1.4h, #0
; CHECK-NEXT:    str q0, [sp]
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [sp]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %vec = load <vscale x 4 x i16>, <vscale x 4 x i16>* %a
  %subvec = load <4 x i16>, <4 x i16>* %b
  %ins = call <vscale x 4 x i16> @llvm.experimental.vector.insert.nxv4i16.v4i16(<vscale x 4 x i16> %vec, <4 x i16> %subvec, i64 0)
  ret <vscale x 4 x i16> %ins
}

define <vscale x 4 x i16> @vec_scalable_subvec_fixed_idx_nonzero_i16(<vscale x 4 x i16>* %a, <4 x i16>* %b) #0 {
; CHECK-LABEL: vec_scalable_subvec_fixed_idx_nonzero_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1h { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    cntw x9
; CHECK-NEXT:    sub x9, x9, #4 // =4
; CHECK-NEXT:    mov w8, #4
; CHECK-NEXT:    cmp x9, #4 // =4
; CHECK-NEXT:    csel x8, x9, x8, lo
; CHECK-NEXT:    lsl x8, x8, #2
; CHECK-NEXT:    st1w { z0.s }, p0, [sp]
; CHECK-NEXT:    ushll v0.4s, v1.4h, #0
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    str q0, [x9, x8]
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [sp]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %vec = load <vscale x 4 x i16>, <vscale x 4 x i16>* %a
  %subvec = load <4 x i16>, <4 x i16>* %b
  %ins = call <vscale x 4 x i16> @llvm.experimental.vector.insert.nxv4i16.v4i16(<vscale x 4 x i16> %vec, <4 x i16> %subvec, i64 4)
  ret <vscale x 4 x i16> %ins
}

define <vscale x 2 x i32> @vec_scalable_subvec_fixed_idx_zero_i32(<vscale x 2 x i32>* %a, <2 x i32>* %b) #0 {
; CHECK-LABEL: vec_scalable_subvec_fixed_idx_zero_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ld1w { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    st1d { z0.d }, p0, [sp]
; CHECK-NEXT:    ushll v0.2d, v1.2s, #0
; CHECK-NEXT:    str q0, [sp]
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [sp]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %vec = load <vscale x 2 x i32>, <vscale x 2 x i32>* %a
  %subvec = load <2 x i32>, <2 x i32>* %b
  %ins = call <vscale x 2 x i32> @llvm.experimental.vector.insert.nxv2i32.v2i32(<vscale x 2 x i32> %vec, <2 x i32> %subvec, i64 0)
  ret <vscale x 2 x i32> %ins
}

define <vscale x 2 x i32> @vec_scalable_subvec_fixed_idx_nonzero_i32(<vscale x 2 x i32>* %a, <2 x i32>* %b) #0 {
; CHECK-LABEL: vec_scalable_subvec_fixed_idx_nonzero_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ld1w { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    cntd x9
; CHECK-NEXT:    sub x9, x9, #2 // =2
; CHECK-NEXT:    mov w8, #2
; CHECK-NEXT:    cmp x9, #2 // =2
; CHECK-NEXT:    csel x8, x9, x8, lo
; CHECK-NEXT:    lsl x8, x8, #3
; CHECK-NEXT:    st1d { z0.d }, p0, [sp]
; CHECK-NEXT:    ushll v0.2d, v1.2s, #0
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    str q0, [x9, x8]
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [sp]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %vec = load <vscale x 2 x i32>, <vscale x 2 x i32>* %a
  %subvec = load <2 x i32>, <2 x i32>* %b
  %ins = call <vscale x 2 x i32> @llvm.experimental.vector.insert.nxv2i32.v2i32(<vscale x 2 x i32> %vec, <2 x i32> %subvec, i64 2)
  ret <vscale x 2 x i32> %ins
}

define <vscale x 2 x i32> @vec_scalable_subvec_fixed_idx_nonzero_large_i32(<vscale x 2 x i32>* %a, <8 x i32>* %b) #1 {
; CHECK-LABEL: vec_scalable_subvec_fixed_idx_nonzero_large_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ptrue p1.s, vl8
; CHECK-NEXT:    ld1w { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ld1w { z1.s }, p1/z, [x1]
; CHECK-NEXT:    cntd x8
; CHECK-NEXT:    subs x8, x8, #8 // =8
; CHECK-NEXT:    csel x8, xzr, x8, lo
; CHECK-NEXT:    mov w9, #8
; CHECK-NEXT:    cmp x8, #8 // =8
; CHECK-NEXT:    ptrue p1.d, vl8
; CHECK-NEXT:    csel x8, x8, x9, lo
; CHECK-NEXT:    st1d { z0.d }, p0, [sp]
; CHECK-NEXT:    uunpklo z0.d, z1.s
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    st1d { z0.d }, p1, [x9, x8, lsl #3]
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [sp]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %vec = load <vscale x 2 x i32>, <vscale x 2 x i32>* %a
  %subvec = load <8 x i32>, <8 x i32>* %b
  %ins = call <vscale x 2 x i32> @llvm.experimental.vector.insert.nxv2i32.v8i32(<vscale x 2 x i32> %vec, <8 x i32> %subvec, i64 8)
  ret <vscale x 2 x i32> %ins
}

declare <vscale x 8 x i8> @llvm.experimental.vector.insert.nxv8i8.nxv4i8(<vscale x 8 x i8>, <vscale x 4 x i8>, i64)
declare <vscale x 4 x i16> @llvm.experimental.vector.insert.nxv4i16.nxv2i16(<vscale x 4 x i16>, <vscale x 2 x i16>, i64)

declare <vscale x 8 x i8> @llvm.experimental.vector.insert.nxv8i8.v8i8(<vscale x 8 x i8>, <8 x i8>, i64)
declare <vscale x 4 x i16> @llvm.experimental.vector.insert.nxv4i16.v4i16(<vscale x 4 x i16>, <4 x i16>, i64)
declare <vscale x 2 x i32> @llvm.experimental.vector.insert.nxv2i32.v2i32(<vscale x 2 x i32>, <2 x i32>, i64)

declare <vscale x 2 x i32> @llvm.experimental.vector.insert.nxv2i32.v8i32(<vscale x 2 x i32>, <8 x i32>, i64)

attributes #0 = { nounwind "target-features"="+sve" }
attributes #1 = { nounwind "target-features"="+sve" vscale_range(4,4) }
