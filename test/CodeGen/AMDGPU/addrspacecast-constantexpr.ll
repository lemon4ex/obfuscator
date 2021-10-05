; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-globals
; RUN: opt -mtriple=amdgcn-unknown-amdhsa -S -amdgpu-annotate-kernel-features < %s | FileCheck -check-prefixes=HSA,AKF_HSA %s
; RUN: opt -mtriple=amdgcn-unknown-amdhsa -S -amdgpu-attributor < %s | FileCheck -check-prefixes=HSA,ATTRIBUTOR_HSA %s

declare void @llvm.memcpy.p1i32.p4i32.i32(i32 addrspace(1)* nocapture, i32 addrspace(4)* nocapture, i32, i1) #0

@lds.i32 = unnamed_addr addrspace(3) global i32 undef, align 4
@lds.arr = unnamed_addr addrspace(3) global [256 x i32] undef, align 4

@global.i32 = unnamed_addr addrspace(1) global i32 undef, align 4
@global.arr = unnamed_addr addrspace(1) global [256 x i32] undef, align 4

;.
; HSA: @[[LDS_I32:[a-zA-Z0-9_$"\\.-]+]] = unnamed_addr addrspace(3) global i32 undef, align 4
; HSA: @[[LDS_ARR:[a-zA-Z0-9_$"\\.-]+]] = unnamed_addr addrspace(3) global [256 x i32] undef, align 4
; HSA: @[[GLOBAL_I32:[a-zA-Z0-9_$"\\.-]+]] = unnamed_addr addrspace(1) global i32 undef, align 4
; HSA: @[[GLOBAL_ARR:[a-zA-Z0-9_$"\\.-]+]] = unnamed_addr addrspace(1) global [256 x i32] undef, align 4
;.
define amdgpu_kernel void @store_cast_0_flat_to_group_addrspacecast() #1 {
; HSA-LABEL: define {{[^@]+}}@store_cast_0_flat_to_group_addrspacecast
; HSA-SAME: () #[[ATTR1:[0-9]+]] {
; HSA-NEXT:    store i32 7, i32 addrspace(3)* addrspacecast (i32 addrspace(4)* null to i32 addrspace(3)*), align 4
; HSA-NEXT:    ret void
;
  store i32 7, i32 addrspace(3)* addrspacecast (i32 addrspace(4)* null to i32 addrspace(3)*)
  ret void
}

define amdgpu_kernel void @store_cast_0_group_to_flat_addrspacecast() #1 {
; HSA-LABEL: define {{[^@]+}}@store_cast_0_group_to_flat_addrspacecast
; HSA-SAME: () #[[ATTR2:[0-9]+]] {
; HSA-NEXT:    store i32 7, i32 addrspace(4)* addrspacecast (i32 addrspace(3)* null to i32 addrspace(4)*), align 4
; HSA-NEXT:    ret void
;
  store i32 7, i32 addrspace(4)* addrspacecast (i32 addrspace(3)* null to i32 addrspace(4)*)
  ret void
}

define amdgpu_kernel void @store_constant_cast_group_gv_to_flat() #1 {
; HSA-LABEL: define {{[^@]+}}@store_constant_cast_group_gv_to_flat
; HSA-SAME: () #[[ATTR2]] {
; HSA-NEXT:    store i32 7, i32 addrspace(4)* addrspacecast (i32 addrspace(3)* @lds.i32 to i32 addrspace(4)*), align 4
; HSA-NEXT:    ret void
;
  store i32 7, i32 addrspace(4)* addrspacecast (i32 addrspace(3)* @lds.i32 to i32 addrspace(4)*)
  ret void
}

define amdgpu_kernel void @store_constant_cast_group_gv_gep_to_flat() #1 {
; HSA-LABEL: define {{[^@]+}}@store_constant_cast_group_gv_gep_to_flat
; HSA-SAME: () #[[ATTR2]] {
; HSA-NEXT:    store i32 7, i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8), align 4
; HSA-NEXT:    ret void
;
  store i32 7, i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8)
  ret void
}

define amdgpu_kernel void @store_constant_cast_global_gv_to_flat() #1 {
; HSA-LABEL: define {{[^@]+}}@store_constant_cast_global_gv_to_flat
; HSA-SAME: () #[[ATTR1]] {
; HSA-NEXT:    store i32 7, i32 addrspace(4)* addrspacecast (i32 addrspace(1)* @global.i32 to i32 addrspace(4)*), align 4
; HSA-NEXT:    ret void
;
  store i32 7, i32 addrspace(4)* addrspacecast (i32 addrspace(1)* @global.i32 to i32 addrspace(4)*)
  ret void
}

define amdgpu_kernel void @store_constant_cast_global_gv_gep_to_flat() #1 {
; HSA-LABEL: define {{[^@]+}}@store_constant_cast_global_gv_gep_to_flat
; HSA-SAME: () #[[ATTR1]] {
; HSA-NEXT:    store i32 7, i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(1)* @global.arr to [256 x i32] addrspace(4)*), i64 0, i64 8), align 4
; HSA-NEXT:    ret void
;
  store i32 7, i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(1)* @global.arr to [256 x i32] addrspace(4)*), i64 0, i64 8)
  ret void
}

define amdgpu_kernel void @load_constant_cast_group_gv_gep_to_flat(i32 addrspace(1)* %out) #1 {
; HSA-LABEL: define {{[^@]+}}@load_constant_cast_group_gv_gep_to_flat
; HSA-SAME: (i32 addrspace(1)* [[OUT:%.*]]) #[[ATTR2]] {
; HSA-NEXT:    [[VAL:%.*]] = load i32, i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8), align 4
; HSA-NEXT:    store i32 [[VAL]], i32 addrspace(1)* [[OUT]], align 4
; HSA-NEXT:    ret void
;
  %val = load i32, i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8)
  store i32 %val, i32 addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @atomicrmw_constant_cast_group_gv_gep_to_flat(i32 addrspace(1)* %out) #1 {
; HSA-LABEL: define {{[^@]+}}@atomicrmw_constant_cast_group_gv_gep_to_flat
; HSA-SAME: (i32 addrspace(1)* [[OUT:%.*]]) #[[ATTR2]] {
; HSA-NEXT:    [[VAL:%.*]] = atomicrmw add i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8), i32 1 seq_cst, align 4
; HSA-NEXT:    store i32 [[VAL]], i32 addrspace(1)* [[OUT]], align 4
; HSA-NEXT:    ret void
;
  %val = atomicrmw add i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8), i32 1 seq_cst
  store i32 %val, i32 addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @cmpxchg_constant_cast_group_gv_gep_to_flat(i32 addrspace(1)* %out) #1 {
; HSA-LABEL: define {{[^@]+}}@cmpxchg_constant_cast_group_gv_gep_to_flat
; HSA-SAME: (i32 addrspace(1)* [[OUT:%.*]]) #[[ATTR2]] {
; HSA-NEXT:    [[VAL:%.*]] = cmpxchg i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8), i32 0, i32 1 seq_cst seq_cst, align 4
; HSA-NEXT:    [[VAL0:%.*]] = extractvalue { i32, i1 } [[VAL]], 0
; HSA-NEXT:    store i32 [[VAL0]], i32 addrspace(1)* [[OUT]], align 4
; HSA-NEXT:    ret void
;
  %val = cmpxchg i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8), i32 0, i32 1 seq_cst seq_cst
  %val0 = extractvalue { i32, i1 } %val, 0
  store i32 %val0, i32 addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @memcpy_constant_cast_group_gv_gep_to_flat(i32 addrspace(1)* %out) #1 {
; HSA-LABEL: define {{[^@]+}}@memcpy_constant_cast_group_gv_gep_to_flat
; HSA-SAME: (i32 addrspace(1)* [[OUT:%.*]]) #[[ATTR2]] {
; HSA-NEXT:    call void @llvm.memcpy.p1i32.p4i32.i32(i32 addrspace(1)* align 4 [[OUT]], i32 addrspace(4)* align 4 getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8), i32 32, i1 false)
; HSA-NEXT:    ret void
;
  call void @llvm.memcpy.p1i32.p4i32.i32(i32 addrspace(1)* align 4 %out, i32 addrspace(4)* align 4 getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8), i32 32, i1 false)
  ret void
}

; Can't just search the pointer value
define amdgpu_kernel void @store_value_constant_cast_lds_gv_gep_to_flat(i32 addrspace(4)* addrspace(1)* %out) #1 {
; HSA-LABEL: define {{[^@]+}}@store_value_constant_cast_lds_gv_gep_to_flat
; HSA-SAME: (i32 addrspace(4)* addrspace(1)* [[OUT:%.*]]) #[[ATTR2]] {
; HSA-NEXT:    store i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8), i32 addrspace(4)* addrspace(1)* [[OUT]], align 8
; HSA-NEXT:    ret void
;
  store i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8), i32 addrspace(4)* addrspace(1)* %out
  ret void
}

; Can't just search pointer types
define amdgpu_kernel void @store_ptrtoint_value_constant_cast_lds_gv_gep_to_flat(i64 addrspace(1)* %out) #1 {
; HSA-LABEL: define {{[^@]+}}@store_ptrtoint_value_constant_cast_lds_gv_gep_to_flat
; HSA-SAME: (i64 addrspace(1)* [[OUT:%.*]]) #[[ATTR2]] {
; HSA-NEXT:    store i64 ptrtoint (i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8) to i64), i64 addrspace(1)* [[OUT]], align 4
; HSA-NEXT:    ret void
;
  store i64 ptrtoint (i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8) to i64), i64 addrspace(1)* %out
  ret void
}

; Cast group to flat, do GEP, cast back to group
define amdgpu_kernel void @store_constant_cast_group_gv_gep_to_flat_to_group() #1 {
; HSA-LABEL: define {{[^@]+}}@store_constant_cast_group_gv_gep_to_flat_to_group
; HSA-SAME: () #[[ATTR2]] {
; HSA-NEXT:    store i32 7, i32 addrspace(3)* addrspacecast (i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8) to i32 addrspace(3)*), align 4
; HSA-NEXT:    ret void
;
  store i32 7, i32 addrspace(3)* addrspacecast (i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8) to i32 addrspace(3)*)
  ret void
}

define i32 addrspace(3)* @ret_constant_cast_group_gv_gep_to_flat_to_group() #1 {
; HSA-LABEL: define {{[^@]+}}@ret_constant_cast_group_gv_gep_to_flat_to_group
; HSA-SAME: () #[[ATTR2]] {
; HSA-NEXT:    ret i32 addrspace(3)* addrspacecast (i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8) to i32 addrspace(3)*)
;
  ret i32 addrspace(3)* addrspacecast (i32 addrspace(4)* getelementptr ([256 x i32], [256 x i32] addrspace(4)* addrspacecast ([256 x i32] addrspace(3)* @lds.arr to [256 x i32] addrspace(4)*), i64 0, i64 8) to i32 addrspace(3)*)
}

attributes #0 = { argmemonly nounwind }
attributes #1 = { nounwind }
;.
; AKF_HSA: attributes #[[ATTR0:[0-9]+]] = { argmemonly nofree nounwind willreturn }
; AKF_HSA: attributes #[[ATTR1]] = { nounwind }
; AKF_HSA: attributes #[[ATTR2]] = { nounwind "amdgpu-queue-ptr" }
;.
; ATTRIBUTOR_HSA: attributes #[[ATTR0:[0-9]+]] = { argmemonly nofree nounwind willreturn "uniform-work-group-size"="false" }
; ATTRIBUTOR_HSA: attributes #[[ATTR1]] = { nounwind "uniform-work-group-size"="false" }
; ATTRIBUTOR_HSA: attributes #[[ATTR2]] = { nounwind "amdgpu-queue-ptr" "uniform-work-group-size"="false" }
;.
