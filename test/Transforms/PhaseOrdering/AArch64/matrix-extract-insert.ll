; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes='default<O3>' -enable-matrix -S %s | FileCheck %s

target triple = "arm64-apple-ios"

define void @matrix_extract_insert_scalar(i32 %i, i32 %k, i32 %j, [225 x double]* nonnull align 8 dereferenceable(1800) %A, [225 x double]* nonnull align 8 dereferenceable(1800) %B) #0 {
; CHECK-LABEL: @matrix_extract_insert_scalar(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CONV:%.*]] = zext i32 [[K:%.*]] to i64
; CHECK-NEXT:    [[CONV1:%.*]] = zext i32 [[J:%.*]] to i64
; CHECK-NEXT:    [[TMP0:%.*]] = mul nuw nsw i64 [[CONV1]], 15
; CHECK-NEXT:    [[TMP1:%.*]] = add nuw nsw i64 [[TMP0]], [[CONV]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ult i64 [[TMP1]], 225
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[TMP2]])
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast [225 x double]* [[A:%.*]] to <225 x double>*
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds <225 x double>, <225 x double>* [[TMP3]], i64 0, i64 [[TMP1]]
; CHECK-NEXT:    [[MATRIXEXT:%.*]] = load double, double* [[TMP4]], align 8
; CHECK-NEXT:    [[CONV2:%.*]] = zext i32 [[I:%.*]] to i64
; CHECK-NEXT:    [[TMP5:%.*]] = add nuw nsw i64 [[TMP0]], [[CONV2]]
; CHECK-NEXT:    [[TMP6:%.*]] = icmp ult i64 [[TMP5]], 225
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[TMP6]])
; CHECK-NEXT:    [[TMP7:%.*]] = bitcast [225 x double]* [[B:%.*]] to <225 x double>*
; CHECK-NEXT:    [[TMP8:%.*]] = load <225 x double>, <225 x double>* [[TMP7]], align 8
; CHECK-NEXT:    [[MATRIXEXT4:%.*]] = extractelement <225 x double> [[TMP8]], i64 [[TMP5]]
; CHECK-NEXT:    [[MUL:%.*]] = fmul double [[MATRIXEXT]], [[MATRIXEXT4]]
; CHECK-NEXT:    [[MATRIXEXT7:%.*]] = extractelement <225 x double> [[TMP8]], i64 [[TMP1]]
; CHECK-NEXT:    [[SUB:%.*]] = fsub double [[MATRIXEXT7]], [[MUL]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds <225 x double>, <225 x double>* [[TMP7]], i64 0, i64 [[TMP1]]
; CHECK-NEXT:    store double [[SUB]], double* [[TMP9]], align 8
; CHECK-NEXT:    ret void
;
entry:
  %i.addr = alloca i32, align 4
  %k.addr = alloca i32, align 4
  %j.addr = alloca i32, align 4
  %A.addr = alloca [225 x double]*, align 8
  %B.addr = alloca [225 x double]*, align 8
  store i32 %i, i32* %i.addr, align 4
  store i32 %k, i32* %k.addr, align 4
  store i32 %j, i32* %j.addr, align 4
  store [225 x double]* %A, [225 x double]** %A.addr, align 8
  store [225 x double]* %B, [225 x double]** %B.addr, align 8
  %0 = load i32, i32* %k.addr, align 4
  %conv = zext i32 %0 to i64
  %1 = load i32, i32* %j.addr, align 4
  %conv1 = zext i32 %1 to i64
  %2 = mul i64 %conv1, 15
  %3 = add i64 %2, %conv
  %4 = icmp ult i64 %3, 225
  call void @llvm.assume(i1 %4)
  %5 = load [225 x double]*, [225 x double]** %A.addr, align 8
  %6 = bitcast [225 x double]* %5 to <225 x double>*
  %7 = load <225 x double>, <225 x double>* %6, align 8
  %matrixext = extractelement <225 x double> %7, i64 %3
  %8 = load i32, i32* %i.addr, align 4
  %conv2 = zext i32 %8 to i64
  %9 = load i32, i32* %j.addr, align 4
  %conv3 = zext i32 %9 to i64
  %10 = mul i64 %conv3, 15
  %11 = add i64 %10, %conv2
  %12 = icmp ult i64 %11, 225
  call void @llvm.assume(i1 %12)
  %13 = load [225 x double]*, [225 x double]** %B.addr, align 8
  %14 = bitcast [225 x double]* %13 to <225 x double>*
  %15 = load <225 x double>, <225 x double>* %14, align 8
  %matrixext4 = extractelement <225 x double> %15, i64 %11
  %mul = fmul double %matrixext, %matrixext4
  %16 = load [225 x double]*, [225 x double]** %B.addr, align 8
  %17 = load i32, i32* %k.addr, align 4
  %conv5 = zext i32 %17 to i64
  %18 = load i32, i32* %j.addr, align 4
  %conv6 = zext i32 %18 to i64
  %19 = mul i64 %conv6, 15
  %20 = add i64 %19, %conv5
  %21 = bitcast [225 x double]* %16 to <225 x double>*
  %22 = icmp ult i64 %20, 225
  call void @llvm.assume(i1 %22)
  %23 = load <225 x double>, <225 x double>* %21, align 8
  %matrixext7 = extractelement <225 x double> %23, i64 %20
  %sub = fsub double %matrixext7, %mul
  %24 = icmp ult i64 %20, 225
  call void @llvm.assume(i1 %24)
  %25 = load <225 x double>, <225 x double>* %21, align 8
  %matins = insertelement <225 x double> %25, double %sub, i64 %20
  store <225 x double> %matins, <225 x double>* %21, align 8
  ret void
}
define void @matrix_extract_insert_loop(i32 %i, [225 x double]* nonnull align 8 dereferenceable(1800) %A, [225 x double]* nonnull align 8 dereferenceable(1800) %B) {
; CHECK-LABEL: @matrix_extract_insert_loop(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast [225 x double]* [[A:%.*]] to <225 x double>*
; CHECK-NEXT:    [[CONV6:%.*]] = zext i32 [[I:%.*]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast [225 x double]* [[B:%.*]] to <225 x double>*
; CHECK-NEXT:    [[CMP212_NOT:%.*]] = icmp eq i32 [[I]], 0
; CHECK-NEXT:    br i1 [[CMP212_NOT]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_COND1_PREHEADER_US_PREHEADER:%.*]]
; CHECK:       for.cond1.preheader.us.preheader:
; CHECK-NEXT:    [[DOTPRE_PRE:%.*]] = load <225 x double>, <225 x double>* [[TMP1]], align 8
; CHECK-NEXT:    br label [[FOR_COND1_PREHEADER_US:%.*]]
; CHECK:       for.cond1.preheader.us:
; CHECK-NEXT:    [[DOTPRE:%.*]] = phi <225 x double> [ [[MATINS_US:%.*]], [[FOR_COND1_FOR_COND_CLEANUP3_CRIT_EDGE_US:%.*]] ], [ [[DOTPRE_PRE]], [[FOR_COND1_PREHEADER_US_PREHEADER]] ]
; CHECK-NEXT:    [[J_014_US:%.*]] = phi i32 [ [[INC13_US:%.*]], [[FOR_COND1_FOR_COND_CLEANUP3_CRIT_EDGE_US]] ], [ 0, [[FOR_COND1_PREHEADER_US_PREHEADER]] ]
; CHECK-NEXT:    [[CONV5_US:%.*]] = zext i32 [[J_014_US]] to i64
; CHECK-NEXT:    [[TMP2:%.*]] = mul nuw nsw i64 [[CONV5_US]], 15
; CHECK-NEXT:    [[TMP3:%.*]] = add nuw nsw i64 [[TMP2]], [[CONV6]]
; CHECK-NEXT:    [[TMP4:%.*]] = icmp ult i64 [[TMP3]], 225
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[TMP4]])
; CHECK-NEXT:    br label [[FOR_BODY4_US:%.*]]
; CHECK:       for.body4.us:
; CHECK-NEXT:    [[TMP5:%.*]] = phi <225 x double> [ [[DOTPRE]], [[FOR_COND1_PREHEADER_US]] ], [ [[MATINS_US]], [[FOR_BODY4_US]] ]
; CHECK-NEXT:    [[K_013_US:%.*]] = phi i32 [ 0, [[FOR_COND1_PREHEADER_US]] ], [ [[INC_US:%.*]], [[FOR_BODY4_US]] ]
; CHECK-NEXT:    [[CONV_US:%.*]] = zext i32 [[K_013_US]] to i64
; CHECK-NEXT:    [[TMP6:%.*]] = add nuw nsw i64 [[TMP2]], [[CONV_US]]
; CHECK-NEXT:    [[TMP7:%.*]] = icmp ult i64 [[TMP6]], 225
; CHECK-NEXT:    tail call void @llvm.assume(i1 [[TMP7]])
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds <225 x double>, <225 x double>* [[TMP0]], i64 0, i64 [[TMP6]]
; CHECK-NEXT:    [[MATRIXEXT_US:%.*]] = load double, double* [[TMP8]], align 8
; CHECK-NEXT:    [[MATRIXEXT8_US:%.*]] = extractelement <225 x double> [[TMP5]], i64 [[TMP3]]
; CHECK-NEXT:    [[MUL_US:%.*]] = fmul double [[MATRIXEXT_US]], [[MATRIXEXT8_US]]
; CHECK-NEXT:    [[MATRIXEXT11_US:%.*]] = extractelement <225 x double> [[TMP5]], i64 [[TMP6]]
; CHECK-NEXT:    [[SUB_US:%.*]] = fsub double [[MATRIXEXT11_US]], [[MUL_US]]
; CHECK-NEXT:    [[MATINS_US]] = insertelement <225 x double> [[TMP5]], double [[SUB_US]], i64 [[TMP6]]
; CHECK-NEXT:    store <225 x double> [[MATINS_US]], <225 x double>* [[TMP1]], align 8
; CHECK-NEXT:    [[INC_US]] = add nuw i32 [[K_013_US]], 1
; CHECK-NEXT:    [[CMP2_US:%.*]] = icmp ult i32 [[INC_US]], [[I]]
; CHECK-NEXT:    br i1 [[CMP2_US]], label [[FOR_BODY4_US]], label [[FOR_COND1_FOR_COND_CLEANUP3_CRIT_EDGE_US]]
; CHECK:       for.cond1.for.cond.cleanup3_crit_edge.us:
; CHECK-NEXT:    [[INC13_US]] = add nuw nsw i32 [[J_014_US]], 1
; CHECK-NEXT:    [[CMP_US:%.*]] = icmp ult i32 [[J_014_US]], 3
; CHECK-NEXT:    br i1 [[CMP_US]], label [[FOR_COND1_PREHEADER_US]], label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
;
entry:
  %i.addr = alloca i32, align 4
  %A.addr = alloca [225 x double]*, align 8
  %B.addr = alloca [225 x double]*, align 8
  %j = alloca i32, align 4
  %cleanup.dest.slot = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 %i, i32* %i.addr, align 4
  store [225 x double]* %A, [225 x double]** %A.addr, align 8
  store [225 x double]* %B, [225 x double]** %B.addr, align 8
  %0 = bitcast i32* %j to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %0) #3
  store i32 0, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc12, %entry
  %1 = load i32, i32* %j, align 4
  %cmp = icmp ult i32 %1, 4
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  store i32 2, i32* %cleanup.dest.slot, align 4
  %2 = bitcast i32* %j to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %2) #3
  br label %for.end14

for.body:                                         ; preds = %for.cond
  %3 = bitcast i32* %k to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %3) #3
  store i32 0, i32* %k, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %4 = load i32, i32* %k, align 4
  %5 = load i32, i32* %i.addr, align 4
  %cmp2 = icmp ult i32 %4, %5
  br i1 %cmp2, label %for.body4, label %for.cond.cleanup3

for.cond.cleanup3:                                ; preds = %for.cond1
  store i32 5, i32* %cleanup.dest.slot, align 4
  %6 = bitcast i32* %k to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %6) #3
  br label %for.end

for.body4:                                        ; preds = %for.cond1
  %7 = load i32, i32* %k, align 4
  %conv = zext i32 %7 to i64
  %8 = load i32, i32* %j, align 4
  %conv5 = zext i32 %8 to i64
  %9 = mul i64 %conv5, 15
  %10 = add i64 %9, %conv
  %11 = icmp ult i64 %10, 225
  call void @llvm.assume(i1 %11)
  %12 = load [225 x double]*, [225 x double]** %A.addr, align 8
  %13 = bitcast [225 x double]* %12 to <225 x double>*
  %14 = load <225 x double>, <225 x double>* %13, align 8
  %matrixext = extractelement <225 x double> %14, i64 %10
  %15 = load i32, i32* %i.addr, align 4
  %conv6 = zext i32 %15 to i64
  %16 = load i32, i32* %j, align 4
  %conv7 = zext i32 %16 to i64
  %17 = mul i64 %conv7, 15
  %18 = add i64 %17, %conv6
  %19 = icmp ult i64 %18, 225
  call void @llvm.assume(i1 %19)
  %20 = load [225 x double]*, [225 x double]** %B.addr, align 8
  %21 = bitcast [225 x double]* %20 to <225 x double>*
  %22 = load <225 x double>, <225 x double>* %21, align 8
  %matrixext8 = extractelement <225 x double> %22, i64 %18
  %mul = fmul double %matrixext, %matrixext8
  %23 = load [225 x double]*, [225 x double]** %B.addr, align 8
  %24 = load i32, i32* %k, align 4
  %conv9 = zext i32 %24 to i64
  %25 = load i32, i32* %j, align 4
  %conv10 = zext i32 %25 to i64
  %26 = mul i64 %conv10, 15
  %27 = add i64 %26, %conv9
  %28 = bitcast [225 x double]* %23 to <225 x double>*
  %29 = icmp ult i64 %27, 225
  call void @llvm.assume(i1 %29)
  %30 = load <225 x double>, <225 x double>* %28, align 8
  %matrixext11 = extractelement <225 x double> %30, i64 %27
  %sub = fsub double %matrixext11, %mul
  %31 = icmp ult i64 %27, 225
  call void @llvm.assume(i1 %31)
  %32 = load <225 x double>, <225 x double>* %28, align 8
  %matins = insertelement <225 x double> %32, double %sub, i64 %27
  store <225 x double> %matins, <225 x double>* %28, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body4
  %33 = load i32, i32* %k, align 4
  %inc = add i32 %33, 1
  store i32 %inc, i32* %k, align 4
  br label %for.cond1

for.end:                                          ; preds = %for.cond.cleanup3
  br label %for.inc12

for.inc12:                                        ; preds = %for.end
  %34 = load i32, i32* %j, align 4
  %inc13 = add i32 %34, 1
  store i32 %inc13, i32* %j, align 4
  br label %for.cond

for.end14:                                        ; preds = %for.cond.cleanup
  ret void
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: inaccessiblememonly nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #2

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind ssp uwtable mustprogress
