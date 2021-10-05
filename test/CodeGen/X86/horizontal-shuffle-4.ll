; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-apple-darwin -mattr=+avx2 | FileCheck %s
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mattr=+avx2 | FileCheck %s

;
; 128-bit Vectors
;

define <16 x i8> @permute_packss_packss_128(<4 x i32> %a0, <4 x i32> %a1, <4 x i32> %a2, <4 x i32> %a3) {
; CHECK-LABEL: permute_packss_packss_128:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vpackssdw %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    vpackssdw %xmm3, %xmm2, %xmm1
; CHECK-NEXT:    vpacksswb %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[1,2,3,0]
; CHECK-NEXT:    ret{{[l|q]}}
  %1 = call <8 x i16> @llvm.x86.sse2.packssdw.128(<4 x i32> %a0, <4 x i32> %a1)
  %2 = call <8 x i16> @llvm.x86.sse2.packssdw.128(<4 x i32> %a2, <4 x i32> %a3)
  %3 = call <16 x i8> @llvm.x86.sse2.packsswb.128(<8 x i16> %1, <8 x i16> %2)
  %4 = shufflevector <16 x i8> %3, <16 x i8> poison, <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 0, i32 1, i32 2, i32 3>
  ret <16 x i8> %4
}

define <16 x i8> @permute_packss_packus_128(<4 x i32> %a0, <4 x i32> %a1, <4 x i32> %a2, <4 x i32> %a3) {
; CHECK-LABEL: permute_packss_packus_128:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vpackusdw %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    vpackusdw %xmm3, %xmm2, %xmm1
; CHECK-NEXT:    vpackuswb %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[1,2,3,0]
; CHECK-NEXT:    ret{{[l|q]}}
  %1 = call <8 x i16> @llvm.x86.sse41.packusdw(<4 x i32> %a0, <4 x i32> %a1)
  %2 = call <8 x i16> @llvm.x86.sse41.packusdw(<4 x i32> %a2, <4 x i32> %a3)
  %3 = call <16 x i8> @llvm.x86.sse2.packuswb.128(<8 x i16> %1, <8 x i16> %2)
  %4 = shufflevector <16 x i8> %3, <16 x i8> poison, <16 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 0, i32 1, i32 2, i32 3>
  ret <16 x i8> %4
}

define <8 x i16> @permute_phadd_phadd_128(<8 x i16> %a0, <8 x i16> %a1, <8 x i16> %a2, <8 x i16> %a3) {
; CHECK-LABEL: permute_phadd_phadd_128:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vphaddw %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    vphaddw %xmm3, %xmm2, %xmm1
; CHECK-NEXT:    vphaddw %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[1,2,3,0]
; CHECK-NEXT:    ret{{[l|q]}}
  %1 = call <8 x i16> @llvm.x86.ssse3.phadd.w.128(<8 x i16> %a0, <8 x i16> %a1)
  %2 = call <8 x i16> @llvm.x86.ssse3.phadd.w.128(<8 x i16> %a2, <8 x i16> %a3)
  %3 = call <8 x i16> @llvm.x86.ssse3.phadd.w.128(<8 x i16> %1, <8 x i16> %2)
  %4 = shufflevector <8 x i16> %3, <8 x i16> poison, <8 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1>
  ret <8 x i16> %4
}

;
; 256-bit Vectors
;

define <8 x float> @permute_hadd_hadd_256(<8 x float> %a0, <8 x float> %a1, <8 x float> %a2, <8 x float> %a3) {
; CHECK-LABEL: permute_hadd_hadd_256:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vhaddps %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    vhaddps %ymm3, %ymm2, %ymm1
; CHECK-NEXT:    vhaddps %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    vpermilps {{.*#+}} ymm0 = ymm0[1,2,3,0,5,6,7,4]
; CHECK-NEXT:    ret{{[l|q]}}
  %1 = call <8 x float> @llvm.x86.avx.hadd.ps.256(<8 x float> %a0, <8 x float> %a1)
  %2 = call <8 x float> @llvm.x86.avx.hadd.ps.256(<8 x float> %a2, <8 x float> %a3)
  %3 = call <8 x float> @llvm.x86.avx.hadd.ps.256(<8 x float> %1, <8 x float> %2)
  %4 = shufflevector <8 x float> %3, <8 x float> poison, <8 x i32> <i32 1, i32 2, i32 3, i32 0, i32 5, i32 6, i32 7, i32 4>
  ret <8 x float> %4
}

define <16 x i16> @permute_phadd_phadd_256(<16 x i16> %a0, <16 x i16> %a1, <16 x i16> %a2, <16 x i16> %a3) {
; CHECK-LABEL: permute_phadd_phadd_256:
; CHECK:       ## %bb.0:
; CHECK-NEXT:    vphaddw %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    vphaddw %ymm3, %ymm2, %ymm1
; CHECK-NEXT:    vphaddw %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    vpshufd {{.*#+}} ymm0 = ymm0[1,2,3,0,5,6,7,4]
; CHECK-NEXT:    ret{{[l|q]}}
  %1 = call <16 x i16> @llvm.x86.avx2.phadd.w(<16 x i16> %a0, <16 x i16> %a1)
  %2 = call <16 x i16> @llvm.x86.avx2.phadd.w(<16 x i16> %a2, <16 x i16> %a3)
  %3 = call <16 x i16> @llvm.x86.avx2.phadd.w(<16 x i16> %1, <16 x i16> %2)
  %4 = shufflevector <16 x i16> %3, <16 x i16> poison, <16 x i32> <i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 0, i32 1, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 8, i32 9>
  ret <16 x i16> %4
}

declare <4 x float> @llvm.x86.sse3.hadd.ps(<4 x float>, <4 x float>)
declare <4 x float> @llvm.x86.sse3.hsub.ps(<4 x float>, <4 x float>)
declare <2 x double> @llvm.x86.sse3.hadd.pd(<2 x double>, <2 x double>)
declare <2 x double> @llvm.x86.sse3.hsub.pd(<2 x double>, <2 x double>)

declare <8 x i16> @llvm.x86.ssse3.phadd.w.128(<8 x i16>, <8 x i16>)
declare <4 x i32> @llvm.x86.ssse3.phadd.d.128(<4 x i32>, <4 x i32>)
declare <8 x i16> @llvm.x86.ssse3.phsub.w.128(<8 x i16>, <8 x i16>)
declare <4 x i32> @llvm.x86.ssse3.phsub.d.128(<4 x i32>, <4 x i32>)

declare <16 x i8> @llvm.x86.sse2.packsswb.128(<8 x i16>, <8 x i16>)
declare <8 x i16> @llvm.x86.sse2.packssdw.128(<4 x i32>, <4 x i32>)
declare <16 x i8> @llvm.x86.sse2.packuswb.128(<8 x i16>, <8 x i16>)
declare <8 x i16> @llvm.x86.sse41.packusdw(<4 x i32>, <4 x i32>)

declare <8 x float> @llvm.x86.avx.hadd.ps.256(<8 x float>, <8 x float>)
declare <8 x float> @llvm.x86.avx.hsub.ps.256(<8 x float>, <8 x float>)
declare <4 x double> @llvm.x86.avx.hadd.pd.256(<4 x double>, <4 x double>)
declare <4 x double> @llvm.x86.avx.hsub.pd.256(<4 x double>, <4 x double>)

declare <16 x i16> @llvm.x86.avx2.phadd.w(<16 x i16>, <16 x i16>)
declare <8 x i32> @llvm.x86.avx2.phadd.d(<8 x i32>, <8 x i32>)
declare <16 x i16> @llvm.x86.avx2.phsub.w(<16 x i16>, <16 x i16>)
declare <8 x i32> @llvm.x86.avx2.phsub.d(<8 x i32>, <8 x i32>)

declare <32 x i8> @llvm.x86.avx2.packsswb(<16 x i16>, <16 x i16>)
declare <16 x i16> @llvm.x86.avx2.packssdw(<8 x i32>, <8 x i32>)
declare <32 x i8> @llvm.x86.avx2.packuswb(<16 x i16>, <16 x i16>)
declare <16 x i16> @llvm.x86.avx2.packusdw(<8 x i32>, <8 x i32>)
