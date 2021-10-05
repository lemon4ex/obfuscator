; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; First example from Doc/Coroutines.rst (two block loop) converted to retcon
; RUN: opt < %s -enable-coroutines -passes='default<O2>' -S | FileCheck %s

define i8* @f(i8* %buffer, i32 %n) {
; CHECK-LABEL: @f(
; CHECK-NEXT:  coro.return:
; CHECK-NEXT:    [[N_VAL_SPILL_ADDR:%.*]] = bitcast i8* [[BUFFER:%.*]] to i32*
; CHECK-NEXT:    store i32 [[N:%.*]], i32* [[N_VAL_SPILL_ADDR]], align 4
; CHECK-NEXT:    tail call void @print(i32 [[N]])
; CHECK-NEXT:    ret i8* bitcast (i8* (i8*, i1)* @f.resume.0 to i8*)
;
entry:
  %id = call token @llvm.coro.id.retcon(i32 8, i32 4, i8* %buffer, i8* bitcast (i8* (i8*, i1)* @prototype to i8*), i8* bitcast (i8* (i32)* @allocate to i8*), i8* bitcast (void (i8*)* @deallocate to i8*))
  %hdl = call i8* @llvm.coro.begin(token %id, i8* null)
  br label %loop

loop:
  %n.val = phi i32 [ %n, %entry ], [ %inc, %resume ]
  call void @print(i32 %n.val)
  %unwind0 = call i1 (...) @llvm.coro.suspend.retcon.i1()
  br i1 %unwind0, label %cleanup, label %resume

resume:
  %inc = add i32 %n.val, 1
  br label %loop

cleanup:
  call i1 @llvm.coro.end(i8* %hdl, i1 0)
  unreachable
}



define i32 @main() {
; CHECK-LABEL: @main(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca [8 x i8], align 4
; CHECK-NEXT:    [[DOTSUB:%.*]] = getelementptr inbounds [8 x i8], [8 x i8]* [[TMP0]], i64 0, i64 0
; CHECK-NEXT:    [[N_VAL_SPILL_ADDR_I:%.*]] = bitcast [8 x i8]* [[TMP0]] to i32*
; CHECK-NEXT:    store i32 4, i32* [[N_VAL_SPILL_ADDR_I]], align 4
; CHECK-NEXT:    call void @print(i32 4)
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata [[META0:![0-9]+]])
; CHECK-NEXT:    [[N_VAL_RELOAD_I:%.*]] = load i32, i32* [[N_VAL_SPILL_ADDR_I]], align 4, !alias.scope !0
; CHECK-NEXT:    [[INC_I:%.*]] = add i32 [[N_VAL_RELOAD_I]], 1
; CHECK-NEXT:    store i32 [[INC_I]], i32* [[N_VAL_SPILL_ADDR_I]], align 4, !alias.scope !0
; CHECK-NEXT:    call void @print(i32 [[INC_I]]), !noalias !0
; CHECK-NEXT:    call void @llvm.experimental.noalias.scope.decl(metadata [[META3:![0-9]+]])
; CHECK-NEXT:    [[N_VAL_RELOAD_I3:%.*]] = load i32, i32* [[N_VAL_SPILL_ADDR_I]], align 4, !alias.scope !3
; CHECK-NEXT:    [[INC_I4:%.*]] = add i32 [[N_VAL_RELOAD_I3]], 1
; CHECK-NEXT:    call void @print(i32 [[INC_I4]]), !noalias !3
; CHECK-NEXT:    ret i32 0
;
entry:
  %0 = alloca [8 x i8], align 4
  %buffer = bitcast [8 x i8]* %0 to i8*
  %prepare = call i8* @llvm.coro.prepare.retcon(i8* bitcast (i8* (i8*, i32)* @f to i8*))
  %f = bitcast i8* %prepare to i8* (i8*, i32)*
  %cont0 = call i8* %f(i8* %buffer, i32 4)
  %cont0.cast = bitcast i8* %cont0 to i8* (i8*, i1)*
  %cont1 = call i8* %cont0.cast(i8* %buffer, i1 zeroext false)
  %cont1.cast = bitcast i8* %cont1 to i8* (i8*, i1)*
  %cont2 = call i8* %cont1.cast(i8* %buffer, i1 zeroext false)
  %cont2.cast = bitcast i8* %cont2 to i8* (i8*, i1)*
  call i8* %cont2.cast(i8* %buffer, i1 zeroext true)
  ret i32 0
}

;   Unfortunately, we don't seem to fully optimize this right now due
;   to some sort of phase-ordering thing.

define hidden { i8*, i8* } @g(i8* %buffer, i16* %ptr) {
; CHECK-LABEL: @g(
; CHECK-NEXT:  coro.return:
; CHECK-NEXT:    [[TMP0:%.*]] = tail call i8* @allocate(i32 8) #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast i8* [[BUFFER:%.*]] to i8**
; CHECK-NEXT:    store i8* [[TMP0]], i8** [[TMP1]], align 8
; CHECK-NEXT:    [[PTR_SPILL_ADDR:%.*]] = bitcast i8* [[TMP0]] to i16**
; CHECK-NEXT:    store i16* [[PTR:%.*]], i16** [[PTR_SPILL_ADDR]], align 8
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast i16* [[PTR]] to i8*
; CHECK-NEXT:    [[TMP3:%.*]] = insertvalue { i8*, i8* } { i8* bitcast ({ i8*, i8* } (i8*, i1)* @g.resume.0 to i8*), i8* undef }, i8* [[TMP2]], 1
; CHECK-NEXT:    ret { i8*, i8* } [[TMP3]]
;
entry:
  %id = call token @llvm.coro.id.retcon(i32 8, i32 4, i8* %buffer, i8* bitcast ({ i8*, i8* } (i8*, i1)* @g_prototype to i8*), i8* bitcast (i8* (i32)* @allocate to i8*), i8* bitcast (void (i8*)* @deallocate to i8*))
  %hdl = call i8* @llvm.coro.begin(token %id, i8* null)
  br label %loop

loop:
  %ptr2 = bitcast i16* %ptr to i8*
  %unwind0 = call i1 (...) @llvm.coro.suspend.retcon.i1(i8* %ptr2)
  br i1 %unwind0, label %cleanup, label %resume

resume:
  br label %loop

cleanup:
  call i1 @llvm.coro.end(i8* %hdl, i1 0)
  unreachable
}

declare token @llvm.coro.id.retcon(i32, i32, i8*, i8*, i8*, i8*)
declare i8* @llvm.coro.begin(token, i8*)
declare i1 @llvm.coro.suspend.retcon.i1(...)
declare i1 @llvm.coro.end(i8*, i1)
declare i8* @llvm.coro.prepare.retcon(i8*)

declare i8* @prototype(i8*, i1 zeroext)
declare {i8*,i8*} @g_prototype(i8*, i1 zeroext)

declare noalias i8* @allocate(i32 %size)
declare void @deallocate(i8* %ptr)

declare void @print(i32)
