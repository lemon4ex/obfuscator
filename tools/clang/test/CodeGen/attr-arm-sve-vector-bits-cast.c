// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sve -msve-vector-bits=512 -fallow-half-arguments-and-returns -S -O1 -emit-llvm -o - %s | FileCheck %s

#include <arm_sve.h>

#define N __ARM_FEATURE_SVE_BITS

typedef svint32_t fixed_int32_t __attribute__((arm_sve_vector_bits(N)));
typedef svfloat64_t fixed_float64_t __attribute__((arm_sve_vector_bits(N)));
typedef svbool_t fixed_bool_t __attribute__((arm_sve_vector_bits(N)));
typedef int32_t gnu_int32_t __attribute__((vector_size(N / 8)));

// CHECK-LABEL: @to_svint32_t(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TYPE_COERCE:%.*]]
//
svint32_t to_svint32_t(fixed_int32_t type) {
  return type;
}

// CHECK-LABEL: @from_svint32_t(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TYPE:%.*]]
//
fixed_int32_t from_svint32_t(svint32_t type) {
  return type;
}

// CHECK-LABEL: @to_svfloat64_t(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret <vscale x 2 x double> [[TYPE_COERCE:%.*]]
//
svfloat64_t to_svfloat64_t(fixed_float64_t type) {
  return type;
}

// CHECK-LABEL: @from_svfloat64_t(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    ret <vscale x 2 x double> [[TYPE:%.*]]
//
fixed_float64_t from_svfloat64_t(svfloat64_t type) {
  return type;
}

// CHECK-LABEL: @to_svbool_t(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TYPE:%.*]] = alloca <8 x i8>, align 16
// CHECK-NEXT:    [[TYPE_ADDR:%.*]] = alloca <8 x i8>, align 16
// CHECK-NEXT:    [[TMP0:%.*]] = bitcast <8 x i8>* [[TYPE]] to <vscale x 16 x i1>*
// CHECK-NEXT:    store <vscale x 16 x i1> [[TYPE_COERCE:%.*]], <vscale x 16 x i1>* [[TMP0]], align 16
// CHECK-NEXT:    [[TYPE1:%.*]] = load <8 x i8>, <8 x i8>* [[TYPE]], align 16, !tbaa [[TBAA6:![0-9]+]]
// CHECK-NEXT:    store <8 x i8> [[TYPE1]], <8 x i8>* [[TYPE_ADDR]], align 16, !tbaa [[TBAA6]]
// CHECK-NEXT:    [[TMP1:%.*]] = bitcast <8 x i8>* [[TYPE_ADDR]] to <vscale x 16 x i1>*
// CHECK-NEXT:    [[TMP2:%.*]] = load <vscale x 16 x i1>, <vscale x 16 x i1>* [[TMP1]], align 16, !tbaa [[TBAA6]]
// CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP2]]
//
svbool_t to_svbool_t(fixed_bool_t type) {
  return type;
}

// CHECK-LABEL: @from_svbool_t(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TYPE_ADDR:%.*]] = alloca <vscale x 16 x i1>, align 16
// CHECK-NEXT:    [[RETVAL_COERCE:%.*]] = alloca <vscale x 16 x i1>, align 16
// CHECK-NEXT:    store <vscale x 16 x i1> [[TYPE:%.*]], <vscale x 16 x i1>* [[TYPE_ADDR]], align 16, !tbaa [[TBAA9:![0-9]+]]
// CHECK-NEXT:    [[TMP0:%.*]] = bitcast <vscale x 16 x i1>* [[TYPE_ADDR]] to <8 x i8>*
// CHECK-NEXT:    [[TMP1:%.*]] = load <8 x i8>, <8 x i8>* [[TMP0]], align 16, !tbaa [[TBAA6]]
// CHECK-NEXT:    [[RETVAL_0__SROA_CAST:%.*]] = bitcast <vscale x 16 x i1>* [[RETVAL_COERCE]] to <8 x i8>*
// CHECK-NEXT:    store <8 x i8> [[TMP1]], <8 x i8>* [[RETVAL_0__SROA_CAST]], align 16
// CHECK-NEXT:    [[TMP2:%.*]] = load <vscale x 16 x i1>, <vscale x 16 x i1>* [[RETVAL_COERCE]], align 16
// CHECK-NEXT:    ret <vscale x 16 x i1> [[TMP2]]
//
fixed_bool_t from_svbool_t(svbool_t type) {
  return type;
}

// CHECK-LABEL: @to_svint32_t__from_gnu_int32_t(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TYPE:%.*]] = load <16 x i32>, <16 x i32>* [[TMP0:%.*]], align 16, !tbaa [[TBAA6]]
// CHECK-NEXT:    [[CASTSCALABLESVE:%.*]] = call <vscale x 4 x i32> @llvm.experimental.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32> undef, <16 x i32> [[TYPE]], i64 0)
// CHECK-NEXT:    ret <vscale x 4 x i32> [[CASTSCALABLESVE]]
//
svint32_t to_svint32_t__from_gnu_int32_t(gnu_int32_t type) {
  return type;
}

// CHECK-LABEL: @from_svint32_t__to_gnu_int32_t(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[CASTFIXEDSVE:%.*]] = call <16 x i32> @llvm.experimental.vector.extract.v16i32.nxv4i32(<vscale x 4 x i32> [[TYPE:%.*]], i64 0)
// CHECK-NEXT:    store <16 x i32> [[CASTFIXEDSVE]], <16 x i32>* [[AGG_RESULT:%.*]], align 16, !tbaa [[TBAA6]]
// CHECK-NEXT:    ret void
//
gnu_int32_t from_svint32_t__to_gnu_int32_t(svint32_t type) {
  return type;
}

// CHECK-LABEL: @to_fixed_int32_t__from_gnu_int32_t(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TYPE:%.*]] = load <16 x i32>, <16 x i32>* [[TMP0:%.*]], align 16, !tbaa [[TBAA6]]
// CHECK-NEXT:    [[CASTSCALABLESVE:%.*]] = call <vscale x 4 x i32> @llvm.experimental.vector.insert.nxv4i32.v16i32(<vscale x 4 x i32> undef, <16 x i32> [[TYPE]], i64 0)
// CHECK-NEXT:    ret <vscale x 4 x i32> [[CASTSCALABLESVE]]
//
fixed_int32_t to_fixed_int32_t__from_gnu_int32_t(gnu_int32_t type) {
  return type;
}

// CHECK-LABEL: @from_fixed_int32_t__to_gnu_int32_t(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TYPE:%.*]] = call <16 x i32> @llvm.experimental.vector.extract.v16i32.nxv4i32(<vscale x 4 x i32> [[TYPE_COERCE:%.*]], i64 0)
// CHECK-NEXT:    store <16 x i32> [[TYPE]], <16 x i32>* [[AGG_RESULT:%.*]], align 16, !tbaa [[TBAA6]]
// CHECK-NEXT:    ret void
//
gnu_int32_t from_fixed_int32_t__to_gnu_int32_t(fixed_int32_t type) {
  return type;
}
