; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=x86_64-unknown-unknown -mcpu=generic -mattr=+avx512f -fast-isel --fast-isel-abort=1 < %s | FileCheck %s --check-prefix=AVX
; RUN: llc -verify-machineinstrs -mtriple=i686-unknown-unknown -mcpu=generic -mattr=+avx512f -fast-isel --fast-isel-abort=1 < %s | FileCheck %s --check-prefix=AVX_X86


define double @int_to_double_rr(i32 %a) {
; AVX-LABEL: int_to_double_rr:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vcvtusi2sd %edi, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; AVX_X86-LABEL: int_to_double_rr:
; AVX_X86:       # %bb.0: # %entry
; AVX_X86-NEXT:    pushl %ebp
; AVX_X86-NEXT:    .cfi_def_cfa_offset 8
; AVX_X86-NEXT:    .cfi_offset %ebp, -8
; AVX_X86-NEXT:    movl %esp, %ebp
; AVX_X86-NEXT:    .cfi_def_cfa_register %ebp
; AVX_X86-NEXT:    andl $-8, %esp
; AVX_X86-NEXT:    subl $8, %esp
; AVX_X86-NEXT:    vcvtusi2sdl 8(%ebp), %xmm0, %xmm0
; AVX_X86-NEXT:    vmovsd %xmm0, (%esp)
; AVX_X86-NEXT:    fldl (%esp)
; AVX_X86-NEXT:    movl %ebp, %esp
; AVX_X86-NEXT:    popl %ebp
; AVX_X86-NEXT:    .cfi_def_cfa %esp, 4
; AVX_X86-NEXT:    retl
entry:
  %0 = uitofp i32 %a to double
  ret double %0
}

define double @int_to_double_rm(i32* %a) {
; AVX-LABEL: int_to_double_rm:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vcvtusi2sdl (%rdi), %xmm0, %xmm0
; AVX-NEXT:    retq
;
; AVX_X86-LABEL: int_to_double_rm:
; AVX_X86:       # %bb.0: # %entry
; AVX_X86-NEXT:    pushl %ebp
; AVX_X86-NEXT:    .cfi_def_cfa_offset 8
; AVX_X86-NEXT:    .cfi_offset %ebp, -8
; AVX_X86-NEXT:    movl %esp, %ebp
; AVX_X86-NEXT:    .cfi_def_cfa_register %ebp
; AVX_X86-NEXT:    andl $-8, %esp
; AVX_X86-NEXT:    subl $8, %esp
; AVX_X86-NEXT:    movl 8(%ebp), %eax
; AVX_X86-NEXT:    vcvtusi2sdl (%eax), %xmm0, %xmm0
; AVX_X86-NEXT:    vmovsd %xmm0, (%esp)
; AVX_X86-NEXT:    fldl (%esp)
; AVX_X86-NEXT:    movl %ebp, %esp
; AVX_X86-NEXT:    popl %ebp
; AVX_X86-NEXT:    .cfi_def_cfa %esp, 4
; AVX_X86-NEXT:    retl
entry:
  %0 = load i32, i32* %a
  %1 = uitofp i32 %0 to double
  ret double %1
}

define double @int_to_double_rm_optsize(i32* %a) optsize {
; AVX-LABEL: int_to_double_rm_optsize:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vcvtusi2sdl (%rdi), %xmm0, %xmm0
; AVX-NEXT:    retq
;
; AVX_X86-LABEL: int_to_double_rm_optsize:
; AVX_X86:       # %bb.0: # %entry
; AVX_X86-NEXT:    pushl %ebp
; AVX_X86-NEXT:    .cfi_def_cfa_offset 8
; AVX_X86-NEXT:    .cfi_offset %ebp, -8
; AVX_X86-NEXT:    movl %esp, %ebp
; AVX_X86-NEXT:    .cfi_def_cfa_register %ebp
; AVX_X86-NEXT:    andl $-8, %esp
; AVX_X86-NEXT:    subl $8, %esp
; AVX_X86-NEXT:    movl 8(%ebp), %eax
; AVX_X86-NEXT:    vcvtusi2sdl (%eax), %xmm0, %xmm0
; AVX_X86-NEXT:    vmovsd %xmm0, (%esp)
; AVX_X86-NEXT:    fldl (%esp)
; AVX_X86-NEXT:    movl %ebp, %esp
; AVX_X86-NEXT:    popl %ebp
; AVX_X86-NEXT:    .cfi_def_cfa %esp, 4
; AVX_X86-NEXT:    retl
entry:
  %0 = load i32, i32* %a
  %1 = uitofp i32 %0 to double
  ret double %1
}

define float @int_to_float_rr(i32 %a) {
; AVX-LABEL: int_to_float_rr:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vcvtusi2ss %edi, %xmm0, %xmm0
; AVX-NEXT:    retq
;
; AVX_X86-LABEL: int_to_float_rr:
; AVX_X86:       # %bb.0: # %entry
; AVX_X86-NEXT:    pushl %eax
; AVX_X86-NEXT:    .cfi_def_cfa_offset 8
; AVX_X86-NEXT:    vcvtusi2ssl {{[0-9]+}}(%esp), %xmm0, %xmm0
; AVX_X86-NEXT:    vmovss %xmm0, (%esp)
; AVX_X86-NEXT:    flds (%esp)
; AVX_X86-NEXT:    popl %eax
; AVX_X86-NEXT:    .cfi_def_cfa_offset 4
; AVX_X86-NEXT:    retl
entry:
  %0 = uitofp i32 %a to float
  ret float %0
}

define float @int_to_float_rm(i32* %a) {
; AVX-LABEL: int_to_float_rm:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vcvtusi2ssl (%rdi), %xmm0, %xmm0
; AVX-NEXT:    retq
;
; AVX_X86-LABEL: int_to_float_rm:
; AVX_X86:       # %bb.0: # %entry
; AVX_X86-NEXT:    pushl %eax
; AVX_X86-NEXT:    .cfi_def_cfa_offset 8
; AVX_X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; AVX_X86-NEXT:    vcvtusi2ssl (%eax), %xmm0, %xmm0
; AVX_X86-NEXT:    vmovss %xmm0, (%esp)
; AVX_X86-NEXT:    flds (%esp)
; AVX_X86-NEXT:    popl %eax
; AVX_X86-NEXT:    .cfi_def_cfa_offset 4
; AVX_X86-NEXT:    retl
entry:
  %0 = load i32, i32* %a
  %1 = uitofp i32 %0 to float
  ret float %1
}

define float @int_to_float_rm_optsize(i32* %a) optsize {
; AVX-LABEL: int_to_float_rm_optsize:
; AVX:       # %bb.0: # %entry
; AVX-NEXT:    vcvtusi2ssl (%rdi), %xmm0, %xmm0
; AVX-NEXT:    retq
;
; AVX_X86-LABEL: int_to_float_rm_optsize:
; AVX_X86:       # %bb.0: # %entry
; AVX_X86-NEXT:    pushl %eax
; AVX_X86-NEXT:    .cfi_def_cfa_offset 8
; AVX_X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; AVX_X86-NEXT:    vcvtusi2ssl (%eax), %xmm0, %xmm0
; AVX_X86-NEXT:    vmovss %xmm0, (%esp)
; AVX_X86-NEXT:    flds (%esp)
; AVX_X86-NEXT:    popl %eax
; AVX_X86-NEXT:    .cfi_def_cfa_offset 4
; AVX_X86-NEXT:    retl
entry:
  %0 = load i32, i32* %a
  %1 = uitofp i32 %0 to float
  ret float %1
}
