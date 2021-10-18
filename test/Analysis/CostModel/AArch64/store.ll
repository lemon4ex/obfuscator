; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt < %s -cost-model -analyze -mtriple=aarch64-unknown | FileCheck %s
; RUN: opt < %s -cost-model -cost-kind=code-size -analyze -mtriple=aarch64-unknown | FileCheck %s --check-prefix=SIZE
; RUN: opt < %s -cost-model -analyze -mtriple=aarch64-unknown -mattr=slow-misaligned-128store | FileCheck %s --check-prefix=SLOW_MISALIGNED_128_STORE

target datalayout = "e-p:32:32:32-i1:8:32-i8:8:32-i16:16:32-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:32:64-v128:32:128-v256:32:256-a0:0:32-n32-S32"
define void @getMemoryOpCost() {
    ; If FeatureSlowMisaligned128Store is set, we penalize 128-bit stores.
    ; The unlegalized 256-bit stores are further penalized when legalized down
    ; to 128-bit stores.
; CHECK-LABEL: 'getMemoryOpCost'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <4 x i64> undef, <4 x i64>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <8 x i32> undef, <8 x i32>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <16 x i16> undef, <16 x i16>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <32 x i8> undef, <32 x i8>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <4 x double> undef, <4 x double>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <8 x float> undef, <8 x float>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <16 x half> undef, <16 x half>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <2 x i64> undef, <2 x i64>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <4 x i32> undef, <4 x i32>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <8 x i16> undef, <8 x i16>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <16 x i8> undef, <16 x i8>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <2 x double> undef, <2 x double>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <4 x float> undef, <4 x float>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <8 x half> undef, <8 x half>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: store <2 x i8> undef, <2 x i8>* undef, align 2
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <4 x i8> undef, <4 x i8>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %1 = load <2 x i8>, <2 x i8>* undef, align 2
; CHECK-NEXT:  Cost Model: Found an estimated cost of 64 for instruction: %2 = load <4 x i8>, <4 x i8>* undef, align 4
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
; SIZE-LABEL: 'getMemoryOpCost'
; SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <4 x i64> undef, <4 x i64>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <8 x i32> undef, <8 x i32>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <16 x i16> undef, <16 x i16>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <32 x i8> undef, <32 x i8>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <4 x double> undef, <4 x double>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <8 x float> undef, <8 x float>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 2 for instruction: store <16 x half> undef, <16 x half>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <2 x i64> undef, <2 x i64>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <4 x i32> undef, <4 x i32>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <8 x i16> undef, <8 x i16>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <16 x i8> undef, <16 x i8>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <2 x double> undef, <2 x double>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <4 x float> undef, <4 x float>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <8 x half> undef, <8 x half>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <2 x i8> undef, <2 x i8>* undef, align 2
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <4 x i8> undef, <4 x i8>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %1 = load <2 x i8>, <2 x i8>* undef, align 2
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %2 = load <4 x i8>, <4 x i8>* undef, align 4
; SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret void
;
; SLOW_MISALIGNED_128_STORE-LABEL: 'getMemoryOpCost'
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: store <4 x i64> undef, <4 x i64>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: store <8 x i32> undef, <8 x i32>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: store <16 x i16> undef, <16 x i16>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: store <32 x i8> undef, <32 x i8>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: store <4 x double> undef, <4 x double>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: store <8 x float> undef, <8 x float>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 24 for instruction: store <16 x half> undef, <16 x half>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: store <2 x i64> undef, <2 x i64>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: store <4 x i32> undef, <4 x i32>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: store <8 x i16> undef, <8 x i16>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: store <16 x i8> undef, <16 x i8>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: store <2 x double> undef, <2 x double>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: store <4 x float> undef, <4 x float>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 12 for instruction: store <8 x half> undef, <8 x half>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: store <2 x i8> undef, <2 x i8>* undef, align 2
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: store <4 x i8> undef, <4 x i8>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 16 for instruction: %1 = load <2 x i8>, <2 x i8>* undef, align 2
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 64 for instruction: %2 = load <4 x i8>, <4 x i8>* undef, align 4
; SLOW_MISALIGNED_128_STORE-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret void
;
  store <4 x i64> undef, <4 x i64> * undef
  store <8 x i32> undef, <8 x i32> * undef
  store <16 x i16> undef, <16 x i16> * undef
  store <32 x i8> undef, <32 x i8> * undef

  store <4 x double> undef, <4 x double> * undef
  store <8 x float> undef, <8 x float> * undef
  store <16 x half> undef, <16 x half> * undef

  store <2 x i64> undef, <2 x i64> * undef
  store <4 x i32> undef, <4 x i32> * undef
  store <8 x i16> undef, <8 x i16> * undef
  store <16 x i8> undef, <16 x i8> * undef

  store <2 x double> undef, <2 x double> * undef
  store <4 x float> undef, <4 x float> * undef
  store <8 x half> undef, <8 x half> * undef

  ; We scalarize the loads/stores because there is no vector register name for
  ; these types (they get extended to v.4h/v.2s).
  store <2 x i8> undef, <2 x i8> * undef
  store <4 x i8> undef, <4 x i8> * undef
  load <2 x i8> , <2 x i8> * undef
  load <4 x i8> , <4 x i8> * undef

  ret void
}
