// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +f -target-feature +d -target-feature +experimental-v \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | opt -S -mem2reg | FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f32mf2_b64(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmfne.nxv1f32.nxv1f32.i64(<vscale x 1 x float> [[OP1:%.*]], <vscale x 1 x float> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmfne_vv_f32mf2_b64(vfloat32mf2_t op1, vfloat32mf2_t op2,
                                   size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f32mf2_b64(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmfne.nxv1f32.f32.i64(<vscale x 1 x float> [[OP1:%.*]], float [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmfne_vf_f32mf2_b64(vfloat32mf2_t op1, float op2, size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f32m1_b32(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmfne.nxv2f32.nxv2f32.i64(<vscale x 2 x float> [[OP1:%.*]], <vscale x 2 x float> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmfne_vv_f32m1_b32(vfloat32m1_t op1, vfloat32m1_t op2,
                                  size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f32m1_b32(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmfne.nxv2f32.f32.i64(<vscale x 2 x float> [[OP1:%.*]], float [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmfne_vf_f32m1_b32(vfloat32m1_t op1, float op2, size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f32m2_b16(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmfne.nxv4f32.nxv4f32.i64(<vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmfne_vv_f32m2_b16(vfloat32m2_t op1, vfloat32m2_t op2,
                                  size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f32m2_b16(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmfne.nxv4f32.f32.i64(<vscale x 4 x float> [[OP1:%.*]], float [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmfne_vf_f32m2_b16(vfloat32m2_t op1, float op2, size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f32m4_b8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmfne.nxv8f32.nxv8f32.i64(<vscale x 8 x float> [[OP1:%.*]], <vscale x 8 x float> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmfne_vv_f32m4_b8(vfloat32m4_t op1, vfloat32m4_t op2, size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f32m4_b8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmfne.nxv8f32.f32.i64(<vscale x 8 x float> [[OP1:%.*]], float [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmfne_vf_f32m4_b8(vfloat32m4_t op1, float op2, size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f32m8_b4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.vmfne.nxv16f32.nxv16f32.i64(<vscale x 16 x float> [[OP1:%.*]], <vscale x 16 x float> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmfne_vv_f32m8_b4(vfloat32m8_t op1, vfloat32m8_t op2, size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f32m8_b4(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.vmfne.nxv16f32.f32.i64(<vscale x 16 x float> [[OP1:%.*]], float [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmfne_vf_f32m8_b4(vfloat32m8_t op1, float op2, size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f64m1_b64(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmfne.nxv1f64.nxv1f64.i64(<vscale x 1 x double> [[OP1:%.*]], <vscale x 1 x double> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmfne_vv_f64m1_b64(vfloat64m1_t op1, vfloat64m1_t op2,
                                  size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f64m1_b64(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmfne.nxv1f64.f64.i64(<vscale x 1 x double> [[OP1:%.*]], double [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmfne_vf_f64m1_b64(vfloat64m1_t op1, double op2, size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f64m2_b32(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmfne.nxv2f64.nxv2f64.i64(<vscale x 2 x double> [[OP1:%.*]], <vscale x 2 x double> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmfne_vv_f64m2_b32(vfloat64m2_t op1, vfloat64m2_t op2,
                                  size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f64m2_b32(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmfne.nxv2f64.f64.i64(<vscale x 2 x double> [[OP1:%.*]], double [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmfne_vf_f64m2_b32(vfloat64m2_t op1, double op2, size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f64m4_b16(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmfne.nxv4f64.nxv4f64.i64(<vscale x 4 x double> [[OP1:%.*]], <vscale x 4 x double> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmfne_vv_f64m4_b16(vfloat64m4_t op1, vfloat64m4_t op2,
                                  size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f64m4_b16(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmfne.nxv4f64.f64.i64(<vscale x 4 x double> [[OP1:%.*]], double [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmfne_vf_f64m4_b16(vfloat64m4_t op1, double op2, size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f64m8_b8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmfne.nxv8f64.nxv8f64.i64(<vscale x 8 x double> [[OP1:%.*]], <vscale x 8 x double> [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmfne_vv_f64m8_b8(vfloat64m8_t op1, vfloat64m8_t op2, size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f64m8_b8(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmfne.nxv8f64.f64.i64(<vscale x 8 x double> [[OP1:%.*]], double [[OP2:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmfne_vf_f64m8_b8(vfloat64m8_t op1, double op2, size_t vl) {
  return vmfne(op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f32mf2_b64_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmfne.mask.nxv1f32.nxv1f32.i64(<vscale x 1 x i1> [[MASKEDOFF:%.*]], <vscale x 1 x float> [[OP1:%.*]], <vscale x 1 x float> [[OP2:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmfne_vv_f32mf2_b64_m(vbool64_t mask, vbool64_t maskedoff,
                                     vfloat32mf2_t op1, vfloat32mf2_t op2,
                                     size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f32mf2_b64_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmfne.mask.nxv1f32.f32.i64(<vscale x 1 x i1> [[MASKEDOFF:%.*]], <vscale x 1 x float> [[OP1:%.*]], float [[OP2:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmfne_vf_f32mf2_b64_m(vbool64_t mask, vbool64_t maskedoff,
                                     vfloat32mf2_t op1, float op2, size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f32m1_b32_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmfne.mask.nxv2f32.nxv2f32.i64(<vscale x 2 x i1> [[MASKEDOFF:%.*]], <vscale x 2 x float> [[OP1:%.*]], <vscale x 2 x float> [[OP2:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmfne_vv_f32m1_b32_m(vbool32_t mask, vbool32_t maskedoff,
                                    vfloat32m1_t op1, vfloat32m1_t op2,
                                    size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f32m1_b32_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmfne.mask.nxv2f32.f32.i64(<vscale x 2 x i1> [[MASKEDOFF:%.*]], <vscale x 2 x float> [[OP1:%.*]], float [[OP2:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmfne_vf_f32m1_b32_m(vbool32_t mask, vbool32_t maskedoff,
                                    vfloat32m1_t op1, float op2, size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f32m2_b16_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmfne.mask.nxv4f32.nxv4f32.i64(<vscale x 4 x i1> [[MASKEDOFF:%.*]], <vscale x 4 x float> [[OP1:%.*]], <vscale x 4 x float> [[OP2:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmfne_vv_f32m2_b16_m(vbool16_t mask, vbool16_t maskedoff,
                                    vfloat32m2_t op1, vfloat32m2_t op2,
                                    size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f32m2_b16_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmfne.mask.nxv4f32.f32.i64(<vscale x 4 x i1> [[MASKEDOFF:%.*]], <vscale x 4 x float> [[OP1:%.*]], float [[OP2:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmfne_vf_f32m2_b16_m(vbool16_t mask, vbool16_t maskedoff,
                                    vfloat32m2_t op1, float op2, size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f32m4_b8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmfne.mask.nxv8f32.nxv8f32.i64(<vscale x 8 x i1> [[MASKEDOFF:%.*]], <vscale x 8 x float> [[OP1:%.*]], <vscale x 8 x float> [[OP2:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmfne_vv_f32m4_b8_m(vbool8_t mask, vbool8_t maskedoff,
                                  vfloat32m4_t op1, vfloat32m4_t op2,
                                  size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f32m4_b8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmfne.mask.nxv8f32.f32.i64(<vscale x 8 x i1> [[MASKEDOFF:%.*]], <vscale x 8 x float> [[OP1:%.*]], float [[OP2:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmfne_vf_f32m4_b8_m(vbool8_t mask, vbool8_t maskedoff,
                                  vfloat32m4_t op1, float op2, size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f32m8_b4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.vmfne.mask.nxv16f32.nxv16f32.i64(<vscale x 16 x i1> [[MASKEDOFF:%.*]], <vscale x 16 x float> [[OP1:%.*]], <vscale x 16 x float> [[OP2:%.*]], <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmfne_vv_f32m8_b4_m(vbool4_t mask, vbool4_t maskedoff,
                                  vfloat32m8_t op1, vfloat32m8_t op2,
                                  size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f32m8_b4_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.vmfne.mask.nxv16f32.f32.i64(<vscale x 16 x i1> [[MASKEDOFF:%.*]], <vscale x 16 x float> [[OP1:%.*]], float [[OP2:%.*]], <vscale x 16 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmfne_vf_f32m8_b4_m(vbool4_t mask, vbool4_t maskedoff,
                                  vfloat32m8_t op1, float op2, size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f64m1_b64_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmfne.mask.nxv1f64.nxv1f64.i64(<vscale x 1 x i1> [[MASKEDOFF:%.*]], <vscale x 1 x double> [[OP1:%.*]], <vscale x 1 x double> [[OP2:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmfne_vv_f64m1_b64_m(vbool64_t mask, vbool64_t maskedoff,
                                    vfloat64m1_t op1, vfloat64m1_t op2,
                                    size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f64m1_b64_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.vmfne.mask.nxv1f64.f64.i64(<vscale x 1 x i1> [[MASKEDOFF:%.*]], <vscale x 1 x double> [[OP1:%.*]], double [[OP2:%.*]], <vscale x 1 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmfne_vf_f64m1_b64_m(vbool64_t mask, vbool64_t maskedoff,
                                    vfloat64m1_t op1, double op2, size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f64m2_b32_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmfne.mask.nxv2f64.nxv2f64.i64(<vscale x 2 x i1> [[MASKEDOFF:%.*]], <vscale x 2 x double> [[OP1:%.*]], <vscale x 2 x double> [[OP2:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmfne_vv_f64m2_b32_m(vbool32_t mask, vbool32_t maskedoff,
                                    vfloat64m2_t op1, vfloat64m2_t op2,
                                    size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f64m2_b32_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.vmfne.mask.nxv2f64.f64.i64(<vscale x 2 x i1> [[MASKEDOFF:%.*]], <vscale x 2 x double> [[OP1:%.*]], double [[OP2:%.*]], <vscale x 2 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmfne_vf_f64m2_b32_m(vbool32_t mask, vbool32_t maskedoff,
                                    vfloat64m2_t op1, double op2, size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f64m4_b16_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmfne.mask.nxv4f64.nxv4f64.i64(<vscale x 4 x i1> [[MASKEDOFF:%.*]], <vscale x 4 x double> [[OP1:%.*]], <vscale x 4 x double> [[OP2:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmfne_vv_f64m4_b16_m(vbool16_t mask, vbool16_t maskedoff,
                                    vfloat64m4_t op1, vfloat64m4_t op2,
                                    size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f64m4_b16_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.vmfne.mask.nxv4f64.f64.i64(<vscale x 4 x i1> [[MASKEDOFF:%.*]], <vscale x 4 x double> [[OP1:%.*]], double [[OP2:%.*]], <vscale x 4 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmfne_vf_f64m4_b16_m(vbool16_t mask, vbool16_t maskedoff,
                                    vfloat64m4_t op1, double op2, size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vv_f64m8_b8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmfne.mask.nxv8f64.nxv8f64.i64(<vscale x 8 x i1> [[MASKEDOFF:%.*]], <vscale x 8 x double> [[OP1:%.*]], <vscale x 8 x double> [[OP2:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmfne_vv_f64m8_b8_m(vbool8_t mask, vbool8_t maskedoff,
                                  vfloat64m8_t op1, vfloat64m8_t op2,
                                  size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}

//
// CHECK-RV64-LABEL: @test_vmfne_vf_f64m8_b8_m(
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.vmfne.mask.nxv8f64.f64.i64(<vscale x 8 x i1> [[MASKEDOFF:%.*]], <vscale x 8 x double> [[OP1:%.*]], double [[OP2:%.*]], <vscale x 8 x i1> [[MASK:%.*]], i64 [[VL:%.*]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmfne_vf_f64m8_b8_m(vbool8_t mask, vbool8_t maskedoff,
                                  vfloat64m8_t op1, double op2, size_t vl) {
  return vmfne(mask, maskedoff, op1, op2, vl);
}
