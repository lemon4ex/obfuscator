; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -x86-speculative-load-hardening | FileCheck %s --check-prefix=X64-NOPIC
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -x86-speculative-load-hardening -code-model medium | FileCheck %s --check-prefix=X64-NOPIC-MCM
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -x86-speculative-load-hardening -relocation-model pic | FileCheck %s --check-prefix=X64-PIC
;
; FIXME: Add support for 32-bit.

declare void @f()

define i32 @test_calls_and_rets(i32 *%ptr) nounwind {
; X64-NOPIC-LABEL: test_calls_and_rets:
; X64-NOPIC:       # %bb.0: # %entry
; X64-NOPIC-NEXT:    pushq %rbp
; X64-NOPIC-NEXT:    pushq %r14
; X64-NOPIC-NEXT:    pushq %rbx
; X64-NOPIC-NEXT:    movq %rsp, %rax
; X64-NOPIC-NEXT:    movq %rdi, %rbx
; X64-NOPIC-NEXT:    movq $-1, %r14
; X64-NOPIC-NEXT:    sarq $63, %rax
; X64-NOPIC-NEXT:    shlq $47, %rax
; X64-NOPIC-NEXT:    orq %rax, %rsp
; X64-NOPIC-NEXT:    callq f@PLT
; X64-NOPIC-NEXT:  .Lslh_ret_addr0:
; X64-NOPIC-NEXT:    movq %rsp, %rax
; X64-NOPIC-NEXT:    movq -{{[0-9]+}}(%rsp), %rcx
; X64-NOPIC-NEXT:    sarq $63, %rax
; X64-NOPIC-NEXT:    cmpq $.Lslh_ret_addr0, %rcx
; X64-NOPIC-NEXT:    cmovneq %r14, %rax
; X64-NOPIC-NEXT:    movl (%rbx), %ebp
; X64-NOPIC-NEXT:    shlq $47, %rax
; X64-NOPIC-NEXT:    orq %rax, %rsp
; X64-NOPIC-NEXT:    callq f@PLT
; X64-NOPIC-NEXT:  .Lslh_ret_addr1:
; X64-NOPIC-NEXT:    movq %rsp, %rcx
; X64-NOPIC-NEXT:    movq -{{[0-9]+}}(%rsp), %rax
; X64-NOPIC-NEXT:    sarq $63, %rcx
; X64-NOPIC-NEXT:    cmpq $.Lslh_ret_addr1, %rax
; X64-NOPIC-NEXT:    cmovneq %r14, %rcx
; X64-NOPIC-NEXT:    addl (%rbx), %ebp
; X64-NOPIC-NEXT:    orl %ecx, %ebp
; X64-NOPIC-NEXT:    shlq $47, %rcx
; X64-NOPIC-NEXT:    movl %ebp, %eax
; X64-NOPIC-NEXT:    orq %rcx, %rsp
; X64-NOPIC-NEXT:    popq %rbx
; X64-NOPIC-NEXT:    popq %r14
; X64-NOPIC-NEXT:    popq %rbp
; X64-NOPIC-NEXT:    retq
;
; X64-NOPIC-MCM-LABEL: test_calls_and_rets:
; X64-NOPIC-MCM:       # %bb.0: # %entry
; X64-NOPIC-MCM-NEXT:    pushq %rbp
; X64-NOPIC-MCM-NEXT:    pushq %r14
; X64-NOPIC-MCM-NEXT:    pushq %rbx
; X64-NOPIC-MCM-NEXT:    movq %rsp, %rax
; X64-NOPIC-MCM-NEXT:    movq %rdi, %rbx
; X64-NOPIC-MCM-NEXT:    movq $-1, %r14
; X64-NOPIC-MCM-NEXT:    sarq $63, %rax
; X64-NOPIC-MCM-NEXT:    shlq $47, %rax
; X64-NOPIC-MCM-NEXT:    orq %rax, %rsp
; X64-NOPIC-MCM-NEXT:    callq f@PLT
; X64-NOPIC-MCM-NEXT:  .Lslh_ret_addr0:
; X64-NOPIC-MCM-NEXT:    movq %rsp, %rax
; X64-NOPIC-MCM-NEXT:    movq -{{[0-9]+}}(%rsp), %rcx
; X64-NOPIC-MCM-NEXT:    sarq $63, %rax
; X64-NOPIC-MCM-NEXT:    leaq .Lslh_ret_addr0(%rip), %rdx
; X64-NOPIC-MCM-NEXT:    cmpq %rdx, %rcx
; X64-NOPIC-MCM-NEXT:    cmovneq %r14, %rax
; X64-NOPIC-MCM-NEXT:    movl (%rbx), %ebp
; X64-NOPIC-MCM-NEXT:    shlq $47, %rax
; X64-NOPIC-MCM-NEXT:    orq %rax, %rsp
; X64-NOPIC-MCM-NEXT:    callq f@PLT
; X64-NOPIC-MCM-NEXT:  .Lslh_ret_addr1:
; X64-NOPIC-MCM-NEXT:    movq %rsp, %rcx
; X64-NOPIC-MCM-NEXT:    movq -{{[0-9]+}}(%rsp), %rax
; X64-NOPIC-MCM-NEXT:    sarq $63, %rcx
; X64-NOPIC-MCM-NEXT:    leaq .Lslh_ret_addr1(%rip), %rdx
; X64-NOPIC-MCM-NEXT:    cmpq %rdx, %rax
; X64-NOPIC-MCM-NEXT:    cmovneq %r14, %rcx
; X64-NOPIC-MCM-NEXT:    addl (%rbx), %ebp
; X64-NOPIC-MCM-NEXT:    orl %ecx, %ebp
; X64-NOPIC-MCM-NEXT:    shlq $47, %rcx
; X64-NOPIC-MCM-NEXT:    movl %ebp, %eax
; X64-NOPIC-MCM-NEXT:    orq %rcx, %rsp
; X64-NOPIC-MCM-NEXT:    popq %rbx
; X64-NOPIC-MCM-NEXT:    popq %r14
; X64-NOPIC-MCM-NEXT:    popq %rbp
; X64-NOPIC-MCM-NEXT:    retq
;
; X64-PIC-LABEL: test_calls_and_rets:
; X64-PIC:       # %bb.0: # %entry
; X64-PIC-NEXT:    pushq %rbp
; X64-PIC-NEXT:    pushq %r14
; X64-PIC-NEXT:    pushq %rbx
; X64-PIC-NEXT:    movq %rsp, %rax
; X64-PIC-NEXT:    movq %rdi, %rbx
; X64-PIC-NEXT:    movq $-1, %r14
; X64-PIC-NEXT:    sarq $63, %rax
; X64-PIC-NEXT:    shlq $47, %rax
; X64-PIC-NEXT:    orq %rax, %rsp
; X64-PIC-NEXT:    callq f@PLT
; X64-PIC-NEXT:  .Lslh_ret_addr0:
; X64-PIC-NEXT:    movq %rsp, %rax
; X64-PIC-NEXT:    movq -{{[0-9]+}}(%rsp), %rcx
; X64-PIC-NEXT:    sarq $63, %rax
; X64-PIC-NEXT:    leaq .Lslh_ret_addr0(%rip), %rdx
; X64-PIC-NEXT:    cmpq %rdx, %rcx
; X64-PIC-NEXT:    cmovneq %r14, %rax
; X64-PIC-NEXT:    movl (%rbx), %ebp
; X64-PIC-NEXT:    shlq $47, %rax
; X64-PIC-NEXT:    orq %rax, %rsp
; X64-PIC-NEXT:    callq f@PLT
; X64-PIC-NEXT:  .Lslh_ret_addr1:
; X64-PIC-NEXT:    movq %rsp, %rcx
; X64-PIC-NEXT:    movq -{{[0-9]+}}(%rsp), %rax
; X64-PIC-NEXT:    sarq $63, %rcx
; X64-PIC-NEXT:    leaq .Lslh_ret_addr1(%rip), %rdx
; X64-PIC-NEXT:    cmpq %rdx, %rax
; X64-PIC-NEXT:    cmovneq %r14, %rcx
; X64-PIC-NEXT:    addl (%rbx), %ebp
; X64-PIC-NEXT:    orl %ecx, %ebp
; X64-PIC-NEXT:    shlq $47, %rcx
; X64-PIC-NEXT:    movl %ebp, %eax
; X64-PIC-NEXT:    orq %rcx, %rsp
; X64-PIC-NEXT:    popq %rbx
; X64-PIC-NEXT:    popq %r14
; X64-PIC-NEXT:    popq %rbp
; X64-PIC-NEXT:    retq
entry:
  call void @f()
  %x = load i32, i32* %ptr
  call void @f()
  %y = load i32, i32* %ptr
  %z = add i32 %x, %y
  ret i32 %z
}

define i32 @test_calls_and_rets_noredzone(i32 *%ptr) nounwind noredzone {
; X64-NOPIC-LABEL: test_calls_and_rets_noredzone:
; X64-NOPIC:       # %bb.0: # %entry
; X64-NOPIC-NEXT:    pushq %rbp
; X64-NOPIC-NEXT:    pushq %r15
; X64-NOPIC-NEXT:    pushq %r14
; X64-NOPIC-NEXT:    pushq %rbx
; X64-NOPIC-NEXT:    pushq %rax
; X64-NOPIC-NEXT:    movq %rsp, %rax
; X64-NOPIC-NEXT:    movq %rdi, %rbx
; X64-NOPIC-NEXT:    movq $-1, %r14
; X64-NOPIC-NEXT:    sarq $63, %rax
; X64-NOPIC-NEXT:    shlq $47, %rax
; X64-NOPIC-NEXT:    orq %rax, %rsp
; X64-NOPIC-NEXT:    movq $.Lslh_ret_addr2, %rbp
; X64-NOPIC-NEXT:    callq f@PLT
; X64-NOPIC-NEXT:  .Lslh_ret_addr2:
; X64-NOPIC-NEXT:    movq %rsp, %rax
; X64-NOPIC-NEXT:    sarq $63, %rax
; X64-NOPIC-NEXT:    cmpq $.Lslh_ret_addr2, %rbp
; X64-NOPIC-NEXT:    cmovneq %r14, %rax
; X64-NOPIC-NEXT:    movl (%rbx), %ebp
; X64-NOPIC-NEXT:    shlq $47, %rax
; X64-NOPIC-NEXT:    orq %rax, %rsp
; X64-NOPIC-NEXT:    movq $.Lslh_ret_addr3, %r15
; X64-NOPIC-NEXT:    callq f@PLT
; X64-NOPIC-NEXT:  .Lslh_ret_addr3:
; X64-NOPIC-NEXT:    movq %rsp, %rcx
; X64-NOPIC-NEXT:    sarq $63, %rcx
; X64-NOPIC-NEXT:    cmpq $.Lslh_ret_addr3, %r15
; X64-NOPIC-NEXT:    cmovneq %r14, %rcx
; X64-NOPIC-NEXT:    addl (%rbx), %ebp
; X64-NOPIC-NEXT:    orl %ecx, %ebp
; X64-NOPIC-NEXT:    shlq $47, %rcx
; X64-NOPIC-NEXT:    movl %ebp, %eax
; X64-NOPIC-NEXT:    orq %rcx, %rsp
; X64-NOPIC-NEXT:    addq $8, %rsp
; X64-NOPIC-NEXT:    popq %rbx
; X64-NOPIC-NEXT:    popq %r14
; X64-NOPIC-NEXT:    popq %r15
; X64-NOPIC-NEXT:    popq %rbp
; X64-NOPIC-NEXT:    retq
;
; X64-NOPIC-MCM-LABEL: test_calls_and_rets_noredzone:
; X64-NOPIC-MCM:       # %bb.0: # %entry
; X64-NOPIC-MCM-NEXT:    pushq %rbp
; X64-NOPIC-MCM-NEXT:    pushq %r15
; X64-NOPIC-MCM-NEXT:    pushq %r14
; X64-NOPIC-MCM-NEXT:    pushq %rbx
; X64-NOPIC-MCM-NEXT:    pushq %rax
; X64-NOPIC-MCM-NEXT:    movq %rsp, %rax
; X64-NOPIC-MCM-NEXT:    movq %rdi, %rbx
; X64-NOPIC-MCM-NEXT:    movq $-1, %r14
; X64-NOPIC-MCM-NEXT:    sarq $63, %rax
; X64-NOPIC-MCM-NEXT:    shlq $47, %rax
; X64-NOPIC-MCM-NEXT:    orq %rax, %rsp
; X64-NOPIC-MCM-NEXT:    leaq .Lslh_ret_addr2(%rip), %rbp
; X64-NOPIC-MCM-NEXT:    callq f@PLT
; X64-NOPIC-MCM-NEXT:  .Lslh_ret_addr2:
; X64-NOPIC-MCM-NEXT:    movq %rsp, %rax
; X64-NOPIC-MCM-NEXT:    sarq $63, %rax
; X64-NOPIC-MCM-NEXT:    leaq .Lslh_ret_addr2(%rip), %rcx
; X64-NOPIC-MCM-NEXT:    cmpq %rcx, %rbp
; X64-NOPIC-MCM-NEXT:    cmovneq %r14, %rax
; X64-NOPIC-MCM-NEXT:    movl (%rbx), %ebp
; X64-NOPIC-MCM-NEXT:    shlq $47, %rax
; X64-NOPIC-MCM-NEXT:    orq %rax, %rsp
; X64-NOPIC-MCM-NEXT:    leaq .Lslh_ret_addr3(%rip), %r15
; X64-NOPIC-MCM-NEXT:    callq f@PLT
; X64-NOPIC-MCM-NEXT:  .Lslh_ret_addr3:
; X64-NOPIC-MCM-NEXT:    movq %rsp, %rcx
; X64-NOPIC-MCM-NEXT:    sarq $63, %rcx
; X64-NOPIC-MCM-NEXT:    leaq .Lslh_ret_addr3(%rip), %rax
; X64-NOPIC-MCM-NEXT:    cmpq %rax, %r15
; X64-NOPIC-MCM-NEXT:    cmovneq %r14, %rcx
; X64-NOPIC-MCM-NEXT:    addl (%rbx), %ebp
; X64-NOPIC-MCM-NEXT:    orl %ecx, %ebp
; X64-NOPIC-MCM-NEXT:    shlq $47, %rcx
; X64-NOPIC-MCM-NEXT:    movl %ebp, %eax
; X64-NOPIC-MCM-NEXT:    orq %rcx, %rsp
; X64-NOPIC-MCM-NEXT:    addq $8, %rsp
; X64-NOPIC-MCM-NEXT:    popq %rbx
; X64-NOPIC-MCM-NEXT:    popq %r14
; X64-NOPIC-MCM-NEXT:    popq %r15
; X64-NOPIC-MCM-NEXT:    popq %rbp
; X64-NOPIC-MCM-NEXT:    retq
;
; X64-PIC-LABEL: test_calls_and_rets_noredzone:
; X64-PIC:       # %bb.0: # %entry
; X64-PIC-NEXT:    pushq %rbp
; X64-PIC-NEXT:    pushq %r15
; X64-PIC-NEXT:    pushq %r14
; X64-PIC-NEXT:    pushq %rbx
; X64-PIC-NEXT:    pushq %rax
; X64-PIC-NEXT:    movq %rsp, %rax
; X64-PIC-NEXT:    movq %rdi, %rbx
; X64-PIC-NEXT:    movq $-1, %r14
; X64-PIC-NEXT:    sarq $63, %rax
; X64-PIC-NEXT:    shlq $47, %rax
; X64-PIC-NEXT:    orq %rax, %rsp
; X64-PIC-NEXT:    leaq .Lslh_ret_addr2(%rip), %rbp
; X64-PIC-NEXT:    callq f@PLT
; X64-PIC-NEXT:  .Lslh_ret_addr2:
; X64-PIC-NEXT:    movq %rsp, %rax
; X64-PIC-NEXT:    sarq $63, %rax
; X64-PIC-NEXT:    leaq .Lslh_ret_addr2(%rip), %rcx
; X64-PIC-NEXT:    cmpq %rcx, %rbp
; X64-PIC-NEXT:    cmovneq %r14, %rax
; X64-PIC-NEXT:    movl (%rbx), %ebp
; X64-PIC-NEXT:    shlq $47, %rax
; X64-PIC-NEXT:    orq %rax, %rsp
; X64-PIC-NEXT:    leaq .Lslh_ret_addr3(%rip), %r15
; X64-PIC-NEXT:    callq f@PLT
; X64-PIC-NEXT:  .Lslh_ret_addr3:
; X64-PIC-NEXT:    movq %rsp, %rcx
; X64-PIC-NEXT:    sarq $63, %rcx
; X64-PIC-NEXT:    leaq .Lslh_ret_addr3(%rip), %rax
; X64-PIC-NEXT:    cmpq %rax, %r15
; X64-PIC-NEXT:    cmovneq %r14, %rcx
; X64-PIC-NEXT:    addl (%rbx), %ebp
; X64-PIC-NEXT:    orl %ecx, %ebp
; X64-PIC-NEXT:    shlq $47, %rcx
; X64-PIC-NEXT:    movl %ebp, %eax
; X64-PIC-NEXT:    orq %rcx, %rsp
; X64-PIC-NEXT:    addq $8, %rsp
; X64-PIC-NEXT:    popq %rbx
; X64-PIC-NEXT:    popq %r14
; X64-PIC-NEXT:    popq %r15
; X64-PIC-NEXT:    popq %rbp
; X64-PIC-NEXT:    retq
entry:
  call void @f()
  %x = load i32, i32* %ptr
  call void @f()
  %y = load i32, i32* %ptr
  %z = add i32 %x, %y
  ret i32 %z
}

declare i32 @setjmp(i8* %env) returns_twice
declare i32 @sigsetjmp(i8* %env, i32 %savemask) returns_twice
declare i32 @__sigsetjmp(i8* %foo, i8* %bar, i32 %baz) returns_twice

define i32 @test_call_setjmp(i32 *%ptr) nounwind {
; X64-NOPIC-LABEL: test_call_setjmp:
; X64-NOPIC:       # %bb.0: # %entry
; X64-NOPIC-NEXT:    pushq %rbp
; X64-NOPIC-NEXT:    pushq %r15
; X64-NOPIC-NEXT:    pushq %r14
; X64-NOPIC-NEXT:    pushq %r13
; X64-NOPIC-NEXT:    pushq %r12
; X64-NOPIC-NEXT:    pushq %rbx
; X64-NOPIC-NEXT:    subq $24, %rsp
; X64-NOPIC-NEXT:    movq %rsp, %rax
; X64-NOPIC-NEXT:    movq %rdi, %rbx
; X64-NOPIC-NEXT:    movq $-1, %r15
; X64-NOPIC-NEXT:    sarq $63, %rax
; X64-NOPIC-NEXT:    leaq {{[0-9]+}}(%rsp), %r14
; X64-NOPIC-NEXT:    shlq $47, %rax
; X64-NOPIC-NEXT:    movq %r14, %rdi
; X64-NOPIC-NEXT:    orq %rax, %rsp
; X64-NOPIC-NEXT:    movq $.Lslh_ret_addr4, %rbp
; X64-NOPIC-NEXT:    callq setjmp@PLT
; X64-NOPIC-NEXT:  .Lslh_ret_addr4:
; X64-NOPIC-NEXT:    movq %rsp, %rax
; X64-NOPIC-NEXT:    sarq $63, %rax
; X64-NOPIC-NEXT:    cmpq $.Lslh_ret_addr4, %rbp
; X64-NOPIC-NEXT:    cmovneq %r15, %rax
; X64-NOPIC-NEXT:    movl (%rbx), %ebp
; X64-NOPIC-NEXT:    movl $42, %r12d
; X64-NOPIC-NEXT:    shlq $47, %rax
; X64-NOPIC-NEXT:    movq %r14, %rdi
; X64-NOPIC-NEXT:    movl %r12d, %esi
; X64-NOPIC-NEXT:    orq %rax, %rsp
; X64-NOPIC-NEXT:    movq $.Lslh_ret_addr5, %r13
; X64-NOPIC-NEXT:    callq sigsetjmp@PLT
; X64-NOPIC-NEXT:  .Lslh_ret_addr5:
; X64-NOPIC-NEXT:    movq %rsp, %rax
; X64-NOPIC-NEXT:    sarq $63, %rax
; X64-NOPIC-NEXT:    cmpq $.Lslh_ret_addr5, %r13
; X64-NOPIC-NEXT:    cmovneq %r15, %rax
; X64-NOPIC-NEXT:    addl (%rbx), %ebp
; X64-NOPIC-NEXT:    shlq $47, %rax
; X64-NOPIC-NEXT:    movq %r14, %rdi
; X64-NOPIC-NEXT:    movq %r14, %rsi
; X64-NOPIC-NEXT:    movl %r12d, %edx
; X64-NOPIC-NEXT:    orq %rax, %rsp
; X64-NOPIC-NEXT:    movq $.Lslh_ret_addr6, %r14
; X64-NOPIC-NEXT:    callq __sigsetjmp@PLT
; X64-NOPIC-NEXT:  .Lslh_ret_addr6:
; X64-NOPIC-NEXT:    movq %rsp, %rax
; X64-NOPIC-NEXT:    sarq $63, %rax
; X64-NOPIC-NEXT:    cmpq $.Lslh_ret_addr6, %r14
; X64-NOPIC-NEXT:    movq %rax, %rcx
; X64-NOPIC-NEXT:    cmovneq %r15, %rcx
; X64-NOPIC-NEXT:    addl (%rbx), %ebp
; X64-NOPIC-NEXT:    movl %ebp, %eax
; X64-NOPIC-NEXT:    orl %ecx, %eax
; X64-NOPIC-NEXT:    shlq $47, %rcx
; X64-NOPIC-NEXT:    orq %rcx, %rsp
; X64-NOPIC-NEXT:    addq $24, %rsp
; X64-NOPIC-NEXT:    popq %rbx
; X64-NOPIC-NEXT:    popq %r12
; X64-NOPIC-NEXT:    popq %r13
; X64-NOPIC-NEXT:    popq %r14
; X64-NOPIC-NEXT:    popq %r15
; X64-NOPIC-NEXT:    popq %rbp
; X64-NOPIC-NEXT:    retq
;
; X64-NOPIC-MCM-LABEL: test_call_setjmp:
; X64-NOPIC-MCM:       # %bb.0: # %entry
; X64-NOPIC-MCM-NEXT:    pushq %rbp
; X64-NOPIC-MCM-NEXT:    pushq %r15
; X64-NOPIC-MCM-NEXT:    pushq %r14
; X64-NOPIC-MCM-NEXT:    pushq %r13
; X64-NOPIC-MCM-NEXT:    pushq %r12
; X64-NOPIC-MCM-NEXT:    pushq %rbx
; X64-NOPIC-MCM-NEXT:    subq $24, %rsp
; X64-NOPIC-MCM-NEXT:    movq %rsp, %rax
; X64-NOPIC-MCM-NEXT:    movq %rdi, %rbx
; X64-NOPIC-MCM-NEXT:    movq $-1, %r15
; X64-NOPIC-MCM-NEXT:    sarq $63, %rax
; X64-NOPIC-MCM-NEXT:    leaq {{[0-9]+}}(%rsp), %r14
; X64-NOPIC-MCM-NEXT:    shlq $47, %rax
; X64-NOPIC-MCM-NEXT:    movq %r14, %rdi
; X64-NOPIC-MCM-NEXT:    orq %rax, %rsp
; X64-NOPIC-MCM-NEXT:    leaq .Lslh_ret_addr4(%rip), %rbp
; X64-NOPIC-MCM-NEXT:    callq setjmp@PLT
; X64-NOPIC-MCM-NEXT:  .Lslh_ret_addr4:
; X64-NOPIC-MCM-NEXT:    movq %rsp, %rax
; X64-NOPIC-MCM-NEXT:    sarq $63, %rax
; X64-NOPIC-MCM-NEXT:    leaq .Lslh_ret_addr4(%rip), %rcx
; X64-NOPIC-MCM-NEXT:    cmpq %rcx, %rbp
; X64-NOPIC-MCM-NEXT:    cmovneq %r15, %rax
; X64-NOPIC-MCM-NEXT:    movl (%rbx), %ebp
; X64-NOPIC-MCM-NEXT:    movl $42, %r12d
; X64-NOPIC-MCM-NEXT:    shlq $47, %rax
; X64-NOPIC-MCM-NEXT:    movq %r14, %rdi
; X64-NOPIC-MCM-NEXT:    movl %r12d, %esi
; X64-NOPIC-MCM-NEXT:    orq %rax, %rsp
; X64-NOPIC-MCM-NEXT:    leaq .Lslh_ret_addr5(%rip), %r13
; X64-NOPIC-MCM-NEXT:    callq sigsetjmp@PLT
; X64-NOPIC-MCM-NEXT:  .Lslh_ret_addr5:
; X64-NOPIC-MCM-NEXT:    movq %rsp, %rax
; X64-NOPIC-MCM-NEXT:    sarq $63, %rax
; X64-NOPIC-MCM-NEXT:    leaq .Lslh_ret_addr5(%rip), %rcx
; X64-NOPIC-MCM-NEXT:    cmpq %rcx, %r13
; X64-NOPIC-MCM-NEXT:    cmovneq %r15, %rax
; X64-NOPIC-MCM-NEXT:    addl (%rbx), %ebp
; X64-NOPIC-MCM-NEXT:    shlq $47, %rax
; X64-NOPIC-MCM-NEXT:    movq %r14, %rdi
; X64-NOPIC-MCM-NEXT:    movq %r14, %rsi
; X64-NOPIC-MCM-NEXT:    movl %r12d, %edx
; X64-NOPIC-MCM-NEXT:    orq %rax, %rsp
; X64-NOPIC-MCM-NEXT:    leaq .Lslh_ret_addr6(%rip), %r14
; X64-NOPIC-MCM-NEXT:    callq __sigsetjmp@PLT
; X64-NOPIC-MCM-NEXT:  .Lslh_ret_addr6:
; X64-NOPIC-MCM-NEXT:    movq %rsp, %rax
; X64-NOPIC-MCM-NEXT:    sarq $63, %rax
; X64-NOPIC-MCM-NEXT:    leaq .Lslh_ret_addr6(%rip), %rcx
; X64-NOPIC-MCM-NEXT:    cmpq %rcx, %r14
; X64-NOPIC-MCM-NEXT:    movq %rax, %rcx
; X64-NOPIC-MCM-NEXT:    cmovneq %r15, %rcx
; X64-NOPIC-MCM-NEXT:    addl (%rbx), %ebp
; X64-NOPIC-MCM-NEXT:    movl %ebp, %eax
; X64-NOPIC-MCM-NEXT:    orl %ecx, %eax
; X64-NOPIC-MCM-NEXT:    shlq $47, %rcx
; X64-NOPIC-MCM-NEXT:    orq %rcx, %rsp
; X64-NOPIC-MCM-NEXT:    addq $24, %rsp
; X64-NOPIC-MCM-NEXT:    popq %rbx
; X64-NOPIC-MCM-NEXT:    popq %r12
; X64-NOPIC-MCM-NEXT:    popq %r13
; X64-NOPIC-MCM-NEXT:    popq %r14
; X64-NOPIC-MCM-NEXT:    popq %r15
; X64-NOPIC-MCM-NEXT:    popq %rbp
; X64-NOPIC-MCM-NEXT:    retq
;
; X64-PIC-LABEL: test_call_setjmp:
; X64-PIC:       # %bb.0: # %entry
; X64-PIC-NEXT:    pushq %rbp
; X64-PIC-NEXT:    pushq %r15
; X64-PIC-NEXT:    pushq %r14
; X64-PIC-NEXT:    pushq %r13
; X64-PIC-NEXT:    pushq %r12
; X64-PIC-NEXT:    pushq %rbx
; X64-PIC-NEXT:    subq $24, %rsp
; X64-PIC-NEXT:    movq %rsp, %rax
; X64-PIC-NEXT:    movq %rdi, %rbx
; X64-PIC-NEXT:    movq $-1, %r15
; X64-PIC-NEXT:    sarq $63, %rax
; X64-PIC-NEXT:    leaq {{[0-9]+}}(%rsp), %r14
; X64-PIC-NEXT:    shlq $47, %rax
; X64-PIC-NEXT:    movq %r14, %rdi
; X64-PIC-NEXT:    orq %rax, %rsp
; X64-PIC-NEXT:    leaq .Lslh_ret_addr4(%rip), %rbp
; X64-PIC-NEXT:    callq setjmp@PLT
; X64-PIC-NEXT:  .Lslh_ret_addr4:
; X64-PIC-NEXT:    movq %rsp, %rax
; X64-PIC-NEXT:    sarq $63, %rax
; X64-PIC-NEXT:    leaq .Lslh_ret_addr4(%rip), %rcx
; X64-PIC-NEXT:    cmpq %rcx, %rbp
; X64-PIC-NEXT:    cmovneq %r15, %rax
; X64-PIC-NEXT:    movl (%rbx), %ebp
; X64-PIC-NEXT:    movl $42, %r12d
; X64-PIC-NEXT:    shlq $47, %rax
; X64-PIC-NEXT:    movq %r14, %rdi
; X64-PIC-NEXT:    movl %r12d, %esi
; X64-PIC-NEXT:    orq %rax, %rsp
; X64-PIC-NEXT:    leaq .Lslh_ret_addr5(%rip), %r13
; X64-PIC-NEXT:    callq sigsetjmp@PLT
; X64-PIC-NEXT:  .Lslh_ret_addr5:
; X64-PIC-NEXT:    movq %rsp, %rax
; X64-PIC-NEXT:    sarq $63, %rax
; X64-PIC-NEXT:    leaq .Lslh_ret_addr5(%rip), %rcx
; X64-PIC-NEXT:    cmpq %rcx, %r13
; X64-PIC-NEXT:    cmovneq %r15, %rax
; X64-PIC-NEXT:    addl (%rbx), %ebp
; X64-PIC-NEXT:    shlq $47, %rax
; X64-PIC-NEXT:    movq %r14, %rdi
; X64-PIC-NEXT:    movq %r14, %rsi
; X64-PIC-NEXT:    movl %r12d, %edx
; X64-PIC-NEXT:    orq %rax, %rsp
; X64-PIC-NEXT:    leaq .Lslh_ret_addr6(%rip), %r14
; X64-PIC-NEXT:    callq __sigsetjmp@PLT
; X64-PIC-NEXT:  .Lslh_ret_addr6:
; X64-PIC-NEXT:    movq %rsp, %rax
; X64-PIC-NEXT:    sarq $63, %rax
; X64-PIC-NEXT:    leaq .Lslh_ret_addr6(%rip), %rcx
; X64-PIC-NEXT:    cmpq %rcx, %r14
; X64-PIC-NEXT:    movq %rax, %rcx
; X64-PIC-NEXT:    cmovneq %r15, %rcx
; X64-PIC-NEXT:    addl (%rbx), %ebp
; X64-PIC-NEXT:    movl %ebp, %eax
; X64-PIC-NEXT:    orl %ecx, %eax
; X64-PIC-NEXT:    shlq $47, %rcx
; X64-PIC-NEXT:    orq %rcx, %rsp
; X64-PIC-NEXT:    addq $24, %rsp
; X64-PIC-NEXT:    popq %rbx
; X64-PIC-NEXT:    popq %r12
; X64-PIC-NEXT:    popq %r13
; X64-PIC-NEXT:    popq %r14
; X64-PIC-NEXT:    popq %r15
; X64-PIC-NEXT:    popq %rbp
; X64-PIC-NEXT:    retq
entry:
  %env = alloca i8, i32 16
  ; Call a normal setjmp function.
  call i32 @setjmp(i8* %env)
  %x = load i32, i32* %ptr
  ; Call something like sigsetjmp.
  call i32 @sigsetjmp(i8* %env, i32 42)
  %y = load i32, i32* %ptr
  ; Call something that might be an implementation detail expanded out of a
  ; macro that has a weird signature but still gets annotated as returning
  ; twice.
  call i32 @__sigsetjmp(i8* %env, i8* %env, i32 42)
  %z = load i32, i32* %ptr
  %s1 = add i32 %x, %y
  %s2 = add i32 %s1, %z
  ret i32 %s2
}
