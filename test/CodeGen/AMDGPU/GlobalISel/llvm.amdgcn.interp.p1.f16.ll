; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX9-32BANK %s
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=fiji -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX8-32BANK %s
; RUN: llc -global-isel -mtriple=amdgcn -mcpu=gfx810 -verify-machineinstrs < %s | FileCheck -check-prefixes=GFX8-16BANK %s

define amdgpu_ps float @interp_f16(float %i, i32 inreg %m0) #0 {
; GFX9-32BANK-LABEL: interp_f16:
; GFX9-32BANK:       ; %bb.0:
; GFX9-32BANK-NEXT:    s_mov_b32 m0, s0
; GFX9-32BANK-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 2, 2), 3
; GFX9-32BANK-NEXT:    v_interp_p1ll_f16 v0, v0, attr2.y
; GFX9-32BANK-NEXT:    ; return to shader part epilog
;
; GFX8-32BANK-LABEL: interp_f16:
; GFX8-32BANK:       ; %bb.0:
; GFX8-32BANK-NEXT:    s_mov_b32 m0, s0
; GFX8-32BANK-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 2, 2), 3
; GFX8-32BANK-NEXT:    v_interp_p1ll_f16 v0, v0, attr2.y
; GFX8-32BANK-NEXT:    ; return to shader part epilog
;
; GFX8-16BANK-LABEL: interp_f16:
; GFX8-16BANK:       ; %bb.0:
; GFX8-16BANK-NEXT:    s_mov_b32 m0, s0
; GFX8-16BANK-NEXT:    v_interp_mov_f32_e32 v1, p0, attr2.y
; GFX8-16BANK-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 2, 2), 3
; GFX8-16BANK-NEXT:    v_interp_p1lv_f16 v0, v0, attr2.y, v1
; GFX8-16BANK-NEXT:    ; return to shader part epilog
  %res = call float @llvm.amdgcn.interp.p1.f16(float %i, i32 1, i32 2, i1 false, i32 %m0)
  ret float %res
}

define amdgpu_ps float @interp_f16_high(float %i, i32 inreg %m0) #0 {
; GFX9-32BANK-LABEL: interp_f16_high:
; GFX9-32BANK:       ; %bb.0:
; GFX9-32BANK-NEXT:    s_mov_b32 m0, s0
; GFX9-32BANK-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 2, 2), 3
; GFX9-32BANK-NEXT:    v_interp_p1ll_f16 v0, v0, attr2.y high
; GFX9-32BANK-NEXT:    ; return to shader part epilog
;
; GFX8-32BANK-LABEL: interp_f16_high:
; GFX8-32BANK:       ; %bb.0:
; GFX8-32BANK-NEXT:    s_mov_b32 m0, s0
; GFX8-32BANK-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 2, 2), 3
; GFX8-32BANK-NEXT:    v_interp_p1ll_f16 v0, v0, attr2.y high
; GFX8-32BANK-NEXT:    ; return to shader part epilog
;
; GFX8-16BANK-LABEL: interp_f16_high:
; GFX8-16BANK:       ; %bb.0:
; GFX8-16BANK-NEXT:    s_mov_b32 m0, s0
; GFX8-16BANK-NEXT:    v_interp_mov_f32_e32 v1, p0, attr2.y
; GFX8-16BANK-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 2, 2), 3
; GFX8-16BANK-NEXT:    v_interp_p1lv_f16 v0, v0, attr2.y, v1 high
; GFX8-16BANK-NEXT:    ; return to shader part epilog
  %res = call float @llvm.amdgcn.interp.p1.f16(float %i, i32 1, i32 2, i1 true, i32 %m0)
  ret float %res
}

define amdgpu_ps float @interp_f16_0_0(float %i, i32 inreg %m0) #0 {
; GFX9-32BANK-LABEL: interp_f16_0_0:
; GFX9-32BANK:       ; %bb.0:
; GFX9-32BANK-NEXT:    s_mov_b32 m0, s0
; GFX9-32BANK-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 2, 2), 3
; GFX9-32BANK-NEXT:    v_interp_p1ll_f16 v0, v0, attr0.x
; GFX9-32BANK-NEXT:    ; return to shader part epilog
;
; GFX8-32BANK-LABEL: interp_f16_0_0:
; GFX8-32BANK:       ; %bb.0:
; GFX8-32BANK-NEXT:    s_mov_b32 m0, s0
; GFX8-32BANK-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 2, 2), 3
; GFX8-32BANK-NEXT:    v_interp_p1ll_f16 v0, v0, attr0.x
; GFX8-32BANK-NEXT:    ; return to shader part epilog
;
; GFX8-16BANK-LABEL: interp_f16_0_0:
; GFX8-16BANK:       ; %bb.0:
; GFX8-16BANK-NEXT:    s_mov_b32 m0, s0
; GFX8-16BANK-NEXT:    v_interp_mov_f32_e32 v1, p0, attr0.x
; GFX8-16BANK-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 2, 2), 3
; GFX8-16BANK-NEXT:    v_interp_p1lv_f16 v0, v0, attr0.x, v1
; GFX8-16BANK-NEXT:    ; return to shader part epilog
  %res = call float @llvm.amdgcn.interp.p1.f16(float %i, i32 0, i32 0, i1 false, i32 %m0)
  ret float %res
}

; Copy needed to legalize %i
define amdgpu_ps float @interp_f16_sgpr_i(float inreg %i,i32 inreg %m0) #0 {
; GFX9-32BANK-LABEL: interp_f16_sgpr_i:
; GFX9-32BANK:       ; %bb.0:
; GFX9-32BANK-NEXT:    v_mov_b32_e32 v0, s0
; GFX9-32BANK-NEXT:    s_mov_b32 m0, s1
; GFX9-32BANK-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 2, 2), 3
; GFX9-32BANK-NEXT:    v_interp_p1ll_f16 v0, v0, attr2.y
; GFX9-32BANK-NEXT:    ; return to shader part epilog
;
; GFX8-32BANK-LABEL: interp_f16_sgpr_i:
; GFX8-32BANK:       ; %bb.0:
; GFX8-32BANK-NEXT:    v_mov_b32_e32 v0, s0
; GFX8-32BANK-NEXT:    s_mov_b32 m0, s1
; GFX8-32BANK-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 2, 2), 3
; GFX8-32BANK-NEXT:    v_interp_p1ll_f16 v0, v0, attr2.y
; GFX8-32BANK-NEXT:    ; return to shader part epilog
;
; GFX8-16BANK-LABEL: interp_f16_sgpr_i:
; GFX8-16BANK:       ; %bb.0:
; GFX8-16BANK-NEXT:    s_mov_b32 m0, s1
; GFX8-16BANK-NEXT:    v_mov_b32_e32 v0, s0
; GFX8-16BANK-NEXT:    v_interp_mov_f32_e32 v1, p0, attr2.y
; GFX8-16BANK-NEXT:    s_setreg_imm32_b32 hwreg(HW_REG_MODE, 2, 2), 3
; GFX8-16BANK-NEXT:    v_interp_p1lv_f16 v0, v0, attr2.y, v1
; GFX8-16BANK-NEXT:    ; return to shader part epilog
  %res = call float @llvm.amdgcn.interp.p1.f16(float %i, i32 1, i32 2, i1 false, i32 %m0)
  ret float %res
}

declare float @llvm.amdgcn.interp.p1.f16(float, i32 immarg, i32 immarg, i1 immarg, i32) #0

attributes #0 = { nounwind readnone speculatable }
