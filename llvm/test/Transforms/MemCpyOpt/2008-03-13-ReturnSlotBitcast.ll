; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -basic-aa -memcpyopt -S -enable-memcpyopt-memoryssa=0 | FileCheck %s --check-prefixes=CHECK,NO_MSSA
; RUN: opt < %s -basic-aa -memcpyopt -S -enable-memcpyopt-memoryssa=1 -verify-memoryssa | FileCheck %s --check-prefixes=CHECK,MSSA
target datalayout = "E-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64"

%a = type { i32 }
%b = type { float }

declare void @g(%a* nocapture)

define float @f() {
; CHECK-LABEL: @f(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A_VAR:%.*]] = alloca [[A:%.*]], align 8
; CHECK-NEXT:    [[B_VAR:%.*]] = alloca [[B:%.*]], align 8
; CHECK-NEXT:    [[B_VAR1:%.*]] = bitcast %b* [[B_VAR]] to %a*
; CHECK-NEXT:    call void @g(%a* [[B_VAR1]])
; CHECK-NEXT:    [[A_I8:%.*]] = bitcast %a* [[A_VAR]] to i8*
; CHECK-NEXT:    [[B_I8:%.*]] = bitcast %b* [[B_VAR]] to i8*
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr [[B]], %b* [[B_VAR]], i32 0, i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = load float, float* [[TMP1]], align 4
; CHECK-NEXT:    ret float [[TMP2]]
;
entry:
  %a_var = alloca %a
  %b_var = alloca %b, align 1
  call void @g(%a* %a_var)
  %a_i8 = bitcast %a* %a_var to i8*
  %b_i8 = bitcast %b* %b_var to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %b_i8, i8* %a_i8, i32 4, i1 false)
  %tmp1 = getelementptr %b, %b* %b_var, i32 0, i32 0
  %tmp2 = load float, float* %tmp1
  ret float %tmp2
}

declare void @llvm.memcpy.p0i8.p0i8.i32(i8* nocapture, i8* nocapture, i32, i1) nounwind
