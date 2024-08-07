; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -verify-machineinstrs -mtriple=powerpc-ibm-aix -mcpu=pwr7 < %s | FileCheck %s -check-prefix=32BIT
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-ibm-aix -mcpu=pwr7 < %s | FileCheck %s -check-prefix=64BIT

define void @i64_join(i64 %a, i64 %b, i64 %c, i64 %d, i64 %e, i64 %f, i64 %g, i64 %h, i64 %i, i64 %j) #0 {
; 32BIT-LABEL: i64_join:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    mflr 0
; 32BIT-NEXT:    stwu 1, -64(1)
; 32BIT-NEXT:    stw 0, 72(1)
; 32BIT-NEXT:    stw 10, 116(1)
; 32BIT-NEXT:    stw 9, 112(1)
; 32BIT-NEXT:    stw 8, 108(1)
; 32BIT-NEXT:    stw 7, 104(1)
; 32BIT-NEXT:    stw 6, 100(1)
; 32BIT-NEXT:    stw 5, 96(1)
; 32BIT-NEXT:    stw 4, 92(1)
; 32BIT-NEXT:    stw 3, 88(1)
; 32BIT-NEXT:    bl .foo[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    addi 1, 1, 64
; 32BIT-NEXT:    lwz 0, 8(1)
; 32BIT-NEXT:    mtlr 0
; 32BIT-NEXT:    blr
;
; 64BIT-LABEL: i64_join:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    mflr 0
; 64BIT-NEXT:    stdu 1, -112(1)
; 64BIT-NEXT:    std 0, 128(1)
; 64BIT-NEXT:    std 10, 216(1)
; 64BIT-NEXT:    std 9, 208(1)
; 64BIT-NEXT:    std 8, 200(1)
; 64BIT-NEXT:    std 7, 192(1)
; 64BIT-NEXT:    std 6, 184(1)
; 64BIT-NEXT:    std 5, 176(1)
; 64BIT-NEXT:    std 4, 168(1)
; 64BIT-NEXT:    std 3, 160(1)
; 64BIT-NEXT:    bl .foo[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    addi 1, 1, 112
; 64BIT-NEXT:    ld 0, 16(1)
; 64BIT-NEXT:    mtlr 0
; 64BIT-NEXT:    blr
entry:
  %add = add nsw i64 %b, %a
  %add1 = add nsw i64 %add, %c
  %add2 = add nsw i64 %add1, %d
  %add3 = add nsw i64 %add2, %e
  %add4 = add nsw i64 %add3, %f
  %add5 = add nsw i64 %add4, %g
  %add6 = add nsw i64 %add5, %h
  %add7 = add nsw i64 %add6, %i
  %add8 = add nsw i64 %add7, %j
  tail call void @foo()
  ret void
}

define void @i64_join_missing(i64 %a, i64 %b, i64 %c, i64 %d, i64 %e, i64 %f, i64 %g, i64 %h, i64 %i, i64 %j) #0 {
; 32BIT-LABEL: i64_join_missing:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    mflr 0
; 32BIT-NEXT:    stwu 1, -64(1)
; 32BIT-NEXT:    stw 0, 72(1)
; 32BIT-NEXT:    stw 10, 116(1)
; 32BIT-NEXT:    stw 9, 112(1)
; 32BIT-NEXT:    stw 8, 108(1)
; 32BIT-NEXT:    stw 7, 104(1)
; 32BIT-NEXT:    stw 6, 100(1)
; 32BIT-NEXT:    stw 5, 96(1)
; 32BIT-NEXT:    stw 4, 92(1)
; 32BIT-NEXT:    stw 3, 88(1)
; 32BIT-NEXT:    bl .foo[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    addi 1, 1, 64
; 32BIT-NEXT:    lwz 0, 8(1)
; 32BIT-NEXT:    mtlr 0
; 32BIT-NEXT:    blr
;
; 64BIT-LABEL: i64_join_missing:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    mflr 0
; 64BIT-NEXT:    stdu 1, -112(1)
; 64BIT-NEXT:    std 0, 128(1)
; 64BIT-NEXT:    std 10, 216(1)
; 64BIT-NEXT:    std 9, 208(1)
; 64BIT-NEXT:    std 8, 200(1)
; 64BIT-NEXT:    std 7, 192(1)
; 64BIT-NEXT:    std 6, 184(1)
; 64BIT-NEXT:    std 5, 176(1)
; 64BIT-NEXT:    std 4, 168(1)
; 64BIT-NEXT:    std 3, 160(1)
; 64BIT-NEXT:    bl .foo[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    addi 1, 1, 112
; 64BIT-NEXT:    ld 0, 16(1)
; 64BIT-NEXT:    mtlr 0
; 64BIT-NEXT:    blr
entry:
  %add1 = mul nsw i64 %a, 3
  %add2 = add nsw i64 %add1, %d
  %add3 = add nsw i64 %add2, %e
  %add4 = add nsw i64 %add3, %f
  %add5 = add nsw i64 %add4, %g
  %add6 = add nsw i64 %add5, %h
  %add7 = add nsw i64 %add6, %i
  %add8 = add nsw i64 %add7, %j
  tail call void @foo()
  ret void
}

define void @i32_join(i32 signext %a, i32 signext %b, i32 signext %c, i32 signext %d, i32 signext %e, i32 signext %f, i32 signext %g, i32 signext %h, i32 signext %i, i32 signext %j) #0 {
; 32BIT-LABEL: i32_join:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    mflr 0
; 32BIT-NEXT:    stwu 1, -64(1)
; 32BIT-NEXT:    stw 0, 72(1)
; 32BIT-NEXT:    stw 10, 116(1)
; 32BIT-NEXT:    stw 9, 112(1)
; 32BIT-NEXT:    stw 8, 108(1)
; 32BIT-NEXT:    stw 7, 104(1)
; 32BIT-NEXT:    stw 6, 100(1)
; 32BIT-NEXT:    stw 5, 96(1)
; 32BIT-NEXT:    stw 4, 92(1)
; 32BIT-NEXT:    stw 3, 88(1)
; 32BIT-NEXT:    bl .foo[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    addi 1, 1, 64
; 32BIT-NEXT:    lwz 0, 8(1)
; 32BIT-NEXT:    mtlr 0
; 32BIT-NEXT:    blr
;
; 64BIT-LABEL: i32_join:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    mflr 0
; 64BIT-NEXT:    stdu 1, -112(1)
; 64BIT-NEXT:    std 0, 128(1)
; 64BIT-NEXT:    std 10, 216(1)
; 64BIT-NEXT:    std 9, 208(1)
; 64BIT-NEXT:    std 8, 200(1)
; 64BIT-NEXT:    std 7, 192(1)
; 64BIT-NEXT:    std 6, 184(1)
; 64BIT-NEXT:    std 5, 176(1)
; 64BIT-NEXT:    std 4, 168(1)
; 64BIT-NEXT:    std 3, 160(1)
; 64BIT-NEXT:    bl .foo[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    addi 1, 1, 112
; 64BIT-NEXT:    ld 0, 16(1)
; 64BIT-NEXT:    mtlr 0
; 64BIT-NEXT:    blr
entry:
  %add = add nsw i32 %b, %a
  %add1 = add nsw i32 %add, %c
  %add2 = add nsw i32 %add1, %d
  %add3 = add nsw i32 %add2, %e
  %add4 = add nsw i32 %add3, %f
  %add5 = add nsw i32 %add4, %g
  %add6 = add nsw i32 %add5, %h
  %add7 = add nsw i32 %add6, %i
  %add8 = add nsw i32 %add7, %j
  tail call void @foo()
  ret void
}

define void @i32_join_missing(i32 signext %a, i32 signext %b, i32 signext %c, i32 signext %d, i32 signext %e, i32 signext %f, i32 signext %g, i32 signext %h, i32 signext %i, i32 signext %j) #0 {
; 32BIT-LABEL: i32_join_missing:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    mflr 0
; 32BIT-NEXT:    stwu 1, -64(1)
; 32BIT-NEXT:    stw 0, 72(1)
; 32BIT-NEXT:    stw 10, 116(1)
; 32BIT-NEXT:    stw 9, 112(1)
; 32BIT-NEXT:    stw 8, 108(1)
; 32BIT-NEXT:    stw 7, 104(1)
; 32BIT-NEXT:    stw 6, 100(1)
; 32BIT-NEXT:    stw 5, 96(1)
; 32BIT-NEXT:    stw 4, 92(1)
; 32BIT-NEXT:    stw 3, 88(1)
; 32BIT-NEXT:    bl .foo[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    addi 1, 1, 64
; 32BIT-NEXT:    lwz 0, 8(1)
; 32BIT-NEXT:    mtlr 0
; 32BIT-NEXT:    blr
;
; 64BIT-LABEL: i32_join_missing:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    mflr 0
; 64BIT-NEXT:    stdu 1, -112(1)
; 64BIT-NEXT:    std 0, 128(1)
; 64BIT-NEXT:    std 10, 216(1)
; 64BIT-NEXT:    std 9, 208(1)
; 64BIT-NEXT:    std 8, 200(1)
; 64BIT-NEXT:    std 7, 192(1)
; 64BIT-NEXT:    std 6, 184(1)
; 64BIT-NEXT:    std 5, 176(1)
; 64BIT-NEXT:    std 4, 168(1)
; 64BIT-NEXT:    std 3, 160(1)
; 64BIT-NEXT:    bl .foo[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    addi 1, 1, 112
; 64BIT-NEXT:    ld 0, 16(1)
; 64BIT-NEXT:    mtlr 0
; 64BIT-NEXT:    blr
entry:
  %add1 = mul nsw i32 %a, 3
  %add2 = add nsw i32 %add1, %d
  %add3 = add nsw i32 %add2, %e
  %add4 = add nsw i32 %add3, %f
  %add5 = add nsw i32 %add4, %g
  %add6 = add nsw i32 %add5, %h
  %add7 = add nsw i32 %add6, %i
  %add8 = add nsw i32 %add7, %j
  tail call void @foo()
  ret void
}

define void @f32_join(float %a, float %b, float %c, float %d, float %e, float %f, float %g, float %h, float %i, float %j) #0 {
; 32BIT-LABEL: f32_join:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    mflr 0
; 32BIT-NEXT:    stwu 1, -64(1)
; 32BIT-NEXT:    stw 0, 72(1)
; 32BIT-NEXT:    stfs 10, 124(1)
; 32BIT-NEXT:    stfs 9, 120(1)
; 32BIT-NEXT:    stfs 8, 116(1)
; 32BIT-NEXT:    stfs 7, 112(1)
; 32BIT-NEXT:    stfs 6, 108(1)
; 32BIT-NEXT:    stfs 5, 104(1)
; 32BIT-NEXT:    stfs 4, 100(1)
; 32BIT-NEXT:    stfs 3, 96(1)
; 32BIT-NEXT:    stfs 2, 92(1)
; 32BIT-NEXT:    stfs 1, 88(1)
; 32BIT-NEXT:    bl .foo[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    addi 1, 1, 64
; 32BIT-NEXT:    lwz 0, 8(1)
; 32BIT-NEXT:    mtlr 0
; 32BIT-NEXT:    blr
;
; 64BIT-LABEL: f32_join:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    mflr 0
; 64BIT-NEXT:    stdu 1, -112(1)
; 64BIT-NEXT:    std 0, 128(1)
; 64BIT-NEXT:    stfs 10, 232(1)
; 64BIT-NEXT:    stfs 9, 224(1)
; 64BIT-NEXT:    stfs 8, 216(1)
; 64BIT-NEXT:    stfs 7, 208(1)
; 64BIT-NEXT:    stfs 6, 200(1)
; 64BIT-NEXT:    stfs 5, 192(1)
; 64BIT-NEXT:    stfs 4, 184(1)
; 64BIT-NEXT:    stfs 3, 176(1)
; 64BIT-NEXT:    stfs 2, 168(1)
; 64BIT-NEXT:    stfs 1, 160(1)
; 64BIT-NEXT:    bl .foo[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    addi 1, 1, 112
; 64BIT-NEXT:    ld 0, 16(1)
; 64BIT-NEXT:    mtlr 0
; 64BIT-NEXT:    blr
entry:
  %add = fadd float %a, %b
  %add1 = fadd float %add, %c
  %add2 = fadd float %add1, %d
  %add3 = fadd float %add2, %e
  %add4 = fadd float %add3, %f
  %add5 = fadd float %add4, %g
  %add6 = fadd float %add5, %h
  %add7 = fadd float %add6, %i
  %add8 = fadd float %add7, %j
  tail call void @foo()
  ret void
}

define void @f32_join_missing(float %a, float %b, float %c, float %d, float %e, float %f, float %g, float %h, float %i, float %j) #0 {
; 32BIT-LABEL: f32_join_missing:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    mflr 0
; 32BIT-NEXT:    stwu 1, -64(1)
; 32BIT-NEXT:    stw 0, 72(1)
; 32BIT-NEXT:    stfs 10, 124(1)
; 32BIT-NEXT:    stfs 9, 120(1)
; 32BIT-NEXT:    stfs 8, 116(1)
; 32BIT-NEXT:    stfs 7, 112(1)
; 32BIT-NEXT:    stfs 6, 108(1)
; 32BIT-NEXT:    stfs 5, 104(1)
; 32BIT-NEXT:    stfs 4, 100(1)
; 32BIT-NEXT:    stfs 3, 96(1)
; 32BIT-NEXT:    stfs 2, 92(1)
; 32BIT-NEXT:    stfs 1, 88(1)
; 32BIT-NEXT:    bl .foo[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    addi 1, 1, 64
; 32BIT-NEXT:    lwz 0, 8(1)
; 32BIT-NEXT:    mtlr 0
; 32BIT-NEXT:    blr
;
; 64BIT-LABEL: f32_join_missing:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    mflr 0
; 64BIT-NEXT:    stdu 1, -112(1)
; 64BIT-NEXT:    std 0, 128(1)
; 64BIT-NEXT:    stfs 10, 232(1)
; 64BIT-NEXT:    stfs 9, 224(1)
; 64BIT-NEXT:    stfs 8, 216(1)
; 64BIT-NEXT:    stfs 7, 208(1)
; 64BIT-NEXT:    stfs 6, 200(1)
; 64BIT-NEXT:    stfs 5, 192(1)
; 64BIT-NEXT:    stfs 4, 184(1)
; 64BIT-NEXT:    stfs 3, 176(1)
; 64BIT-NEXT:    stfs 2, 168(1)
; 64BIT-NEXT:    stfs 1, 160(1)
; 64BIT-NEXT:    bl .foo[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    addi 1, 1, 112
; 64BIT-NEXT:    ld 0, 16(1)
; 64BIT-NEXT:    mtlr 0
; 64BIT-NEXT:    blr
entry:
  %add = fadd float %a, %a
  %add1 = fadd float %add, %a
  %add2 = fadd float %add1, %d
  %add3 = fadd float %add2, %e
  %add4 = fadd float %add3, %f
  %add5 = fadd float %add4, %g
  %add6 = fadd float %add5, %h
  %add7 = fadd float %add6, %i
  %add8 = fadd float %add7, %j
  tail call void @foo()
  ret void
}

define void @f64_join(double %a, double %b, double %c, double %d, double %e, double %f, double %g, double %h, double %i, double %j) #0 {
; 32BIT-LABEL: f64_join:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    mflr 0
; 32BIT-NEXT:    stwu 1, -64(1)
; 32BIT-NEXT:    stw 0, 72(1)
; 32BIT-NEXT:    stfd 10, 160(1)
; 32BIT-NEXT:    stfd 9, 152(1)
; 32BIT-NEXT:    stfd 8, 144(1)
; 32BIT-NEXT:    stfd 7, 136(1)
; 32BIT-NEXT:    stfd 6, 128(1)
; 32BIT-NEXT:    stfd 5, 120(1)
; 32BIT-NEXT:    stfd 4, 112(1)
; 32BIT-NEXT:    stfd 3, 104(1)
; 32BIT-NEXT:    stfd 2, 96(1)
; 32BIT-NEXT:    stfd 1, 88(1)
; 32BIT-NEXT:    bl .foo[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    addi 1, 1, 64
; 32BIT-NEXT:    lwz 0, 8(1)
; 32BIT-NEXT:    mtlr 0
; 32BIT-NEXT:    blr
;
; 64BIT-LABEL: f64_join:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    mflr 0
; 64BIT-NEXT:    stdu 1, -112(1)
; 64BIT-NEXT:    std 0, 128(1)
; 64BIT-NEXT:    stfd 10, 232(1)
; 64BIT-NEXT:    stfd 9, 224(1)
; 64BIT-NEXT:    stfd 8, 216(1)
; 64BIT-NEXT:    stfd 7, 208(1)
; 64BIT-NEXT:    stfd 6, 200(1)
; 64BIT-NEXT:    stfd 5, 192(1)
; 64BIT-NEXT:    stfd 4, 184(1)
; 64BIT-NEXT:    stfd 3, 176(1)
; 64BIT-NEXT:    stfd 2, 168(1)
; 64BIT-NEXT:    stfd 1, 160(1)
; 64BIT-NEXT:    bl .foo[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    addi 1, 1, 112
; 64BIT-NEXT:    ld 0, 16(1)
; 64BIT-NEXT:    mtlr 0
; 64BIT-NEXT:    blr
entry:
  %add = fadd double %a, %b
  %add1 = fadd double %add, %c
  %add2 = fadd double %add1, %d
  %add3 = fadd double %add2, %e
  %add4 = fadd double %add3, %f
  %add5 = fadd double %add4, %g
  %add6 = fadd double %add5, %h
  %add7 = fadd double %add6, %i
  %add8 = fadd double %add7, %j
  tail call void @foo()
  ret void
}

define void @f64_missing(double %a, double %b, double %c, double %d, double %e, double %f, double %g, double %h, double %i, double %j) #0 {
; 32BIT-LABEL: f64_missing:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    mflr 0
; 32BIT-NEXT:    stwu 1, -64(1)
; 32BIT-NEXT:    stw 0, 72(1)
; 32BIT-NEXT:    stfd 10, 160(1)
; 32BIT-NEXT:    stfd 9, 152(1)
; 32BIT-NEXT:    stfd 8, 144(1)
; 32BIT-NEXT:    stfd 7, 136(1)
; 32BIT-NEXT:    stfd 6, 128(1)
; 32BIT-NEXT:    stfd 5, 120(1)
; 32BIT-NEXT:    stfd 4, 112(1)
; 32BIT-NEXT:    stfd 3, 104(1)
; 32BIT-NEXT:    stfd 2, 96(1)
; 32BIT-NEXT:    stfd 1, 88(1)
; 32BIT-NEXT:    bl .foo[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    addi 1, 1, 64
; 32BIT-NEXT:    lwz 0, 8(1)
; 32BIT-NEXT:    mtlr 0
; 32BIT-NEXT:    blr
;
; 64BIT-LABEL: f64_missing:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    mflr 0
; 64BIT-NEXT:    stdu 1, -112(1)
; 64BIT-NEXT:    std 0, 128(1)
; 64BIT-NEXT:    stfd 10, 232(1)
; 64BIT-NEXT:    stfd 9, 224(1)
; 64BIT-NEXT:    stfd 8, 216(1)
; 64BIT-NEXT:    stfd 7, 208(1)
; 64BIT-NEXT:    stfd 6, 200(1)
; 64BIT-NEXT:    stfd 5, 192(1)
; 64BIT-NEXT:    stfd 4, 184(1)
; 64BIT-NEXT:    stfd 3, 176(1)
; 64BIT-NEXT:    stfd 2, 168(1)
; 64BIT-NEXT:    stfd 1, 160(1)
; 64BIT-NEXT:    bl .foo[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    addi 1, 1, 112
; 64BIT-NEXT:    ld 0, 16(1)
; 64BIT-NEXT:    mtlr 0
; 64BIT-NEXT:    blr
entry:
  %add = fadd double %a, %a
  %add1 = fadd double %add, %a
  %add2 = fadd double %add1, %d
  %add3 = fadd double %add2, %e
  %add4 = fadd double %add3, %f
  %add5 = fadd double %add4, %g
  %add6 = fadd double %add5, %h
  %add7 = fadd double %add6, %i
  %add8 = fadd double %add7, %j
  tail call void @foo()
  ret void
}

define void @mixed_1(double %a, i64 %b, i64 %c, i32 signext %d, i64 %e, float %f, float %g, double %h, i32 signext %i, double %j) #0 {
; 32BIT-LABEL: mixed_1:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    mflr 0
; 32BIT-NEXT:    stwu 1, -112(1)
; 32BIT-NEXT:    stw 0, 120(1)
; 32BIT-NEXT:    stfd 1, 136(1)
; 32BIT-NEXT:    xsadddp 1, 1, 5
; 32BIT-NEXT:    stw 24, 64(1) # 4-byte Folded Spill
; 32BIT-NEXT:    lwz 24, 168(1)
; 32BIT-NEXT:    stw 25, 68(1) # 4-byte Folded Spill
; 32BIT-NEXT:    lwz 25, 188(1)
; 32BIT-NEXT:    stw 26, 72(1) # 4-byte Folded Spill
; 32BIT-NEXT:    stw 27, 76(1) # 4-byte Folded Spill
; 32BIT-NEXT:    stw 28, 80(1) # 4-byte Folded Spill
; 32BIT-NEXT:    stw 29, 84(1) # 4-byte Folded Spill
; 32BIT-NEXT:    stw 30, 88(1) # 4-byte Folded Spill
; 32BIT-NEXT:    stw 31, 92(1) # 4-byte Folded Spill
; 32BIT-NEXT:    stfd 30, 96(1) # 8-byte Folded Spill
; 32BIT-NEXT:    stfd 31, 104(1) # 8-byte Folded Spill
; 32BIT-NEXT:    fmr 31, 3
; 32BIT-NEXT:    fmr 30, 2
; 32BIT-NEXT:    mr 31, 10
; 32BIT-NEXT:    mr 30, 9
; 32BIT-NEXT:    mr 29, 8
; 32BIT-NEXT:    mr 28, 7
; 32BIT-NEXT:    mr 27, 6
; 32BIT-NEXT:    mr 26, 5
; 32BIT-NEXT:    stfd 5, 192(1)
; 32BIT-NEXT:    stfd 4, 180(1)
; 32BIT-NEXT:    stfs 3, 176(1)
; 32BIT-NEXT:    stfs 2, 172(1)
; 32BIT-NEXT:    stw 10, 164(1)
; 32BIT-NEXT:    stw 9, 160(1)
; 32BIT-NEXT:    stw 8, 156(1)
; 32BIT-NEXT:    stw 7, 152(1)
; 32BIT-NEXT:    stw 6, 148(1)
; 32BIT-NEXT:    stw 5, 144(1)
; 32BIT-NEXT:    bl .consume_f64[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    fadds 1, 30, 31
; 32BIT-NEXT:    bl .consume_f32[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    addc 3, 29, 27
; 32BIT-NEXT:    adde 4, 28, 26
; 32BIT-NEXT:    srawi 5, 30, 31
; 32BIT-NEXT:    addc 3, 3, 30
; 32BIT-NEXT:    adde 5, 4, 5
; 32BIT-NEXT:    addc 4, 3, 24
; 32BIT-NEXT:    adde 3, 5, 31
; 32BIT-NEXT:    bl .consume_i64[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    add 3, 25, 30
; 32BIT-NEXT:    bl .consume_i32[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    lfd 31, 104(1) # 8-byte Folded Reload
; 32BIT-NEXT:    lfd 30, 96(1) # 8-byte Folded Reload
; 32BIT-NEXT:    lwz 31, 92(1) # 4-byte Folded Reload
; 32BIT-NEXT:    lwz 30, 88(1) # 4-byte Folded Reload
; 32BIT-NEXT:    lwz 29, 84(1) # 4-byte Folded Reload
; 32BIT-NEXT:    lwz 28, 80(1) # 4-byte Folded Reload
; 32BIT-NEXT:    lwz 27, 76(1) # 4-byte Folded Reload
; 32BIT-NEXT:    lwz 26, 72(1) # 4-byte Folded Reload
; 32BIT-NEXT:    lwz 25, 68(1) # 4-byte Folded Reload
; 32BIT-NEXT:    lwz 24, 64(1) # 4-byte Folded Reload
; 32BIT-NEXT:    addi 1, 1, 112
; 32BIT-NEXT:    lwz 0, 8(1)
; 32BIT-NEXT:    mtlr 0
; 32BIT-NEXT:    blr
;
; 64BIT-LABEL: mixed_1:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    mflr 0
; 64BIT-NEXT:    stdu 1, -176(1)
; 64BIT-NEXT:    std 0, 192(1)
; 64BIT-NEXT:    stfd 1, 224(1)
; 64BIT-NEXT:    xsadddp 1, 1, 5
; 64BIT-NEXT:    std 27, 120(1) # 8-byte Folded Spill
; 64BIT-NEXT:    lwz 27, 292(1)
; 64BIT-NEXT:    std 28, 128(1) # 8-byte Folded Spill
; 64BIT-NEXT:    std 29, 136(1) # 8-byte Folded Spill
; 64BIT-NEXT:    std 30, 144(1) # 8-byte Folded Spill
; 64BIT-NEXT:    std 31, 152(1) # 8-byte Folded Spill
; 64BIT-NEXT:    stfd 30, 160(1) # 8-byte Folded Spill
; 64BIT-NEXT:    stfd 31, 168(1) # 8-byte Folded Spill
; 64BIT-NEXT:    fmr 31, 3
; 64BIT-NEXT:    fmr 30, 2
; 64BIT-NEXT:    mr 31, 7
; 64BIT-NEXT:    mr 30, 6
; 64BIT-NEXT:    mr 29, 5
; 64BIT-NEXT:    mr 28, 4
; 64BIT-NEXT:    stfd 5, 296(1)
; 64BIT-NEXT:    stfd 4, 280(1)
; 64BIT-NEXT:    stfs 3, 272(1)
; 64BIT-NEXT:    stfs 2, 264(1)
; 64BIT-NEXT:    std 7, 256(1)
; 64BIT-NEXT:    std 6, 248(1)
; 64BIT-NEXT:    std 5, 240(1)
; 64BIT-NEXT:    std 4, 232(1)
; 64BIT-NEXT:    bl .consume_f64[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    fadds 1, 30, 31
; 64BIT-NEXT:    bl .consume_f32[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    add 3, 29, 28
; 64BIT-NEXT:    add 3, 3, 30
; 64BIT-NEXT:    add 3, 3, 31
; 64BIT-NEXT:    bl .consume_i64[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    add 3, 27, 30
; 64BIT-NEXT:    extsw 3, 3
; 64BIT-NEXT:    bl .consume_i32[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    lfd 31, 168(1) # 8-byte Folded Reload
; 64BIT-NEXT:    lfd 30, 160(1) # 8-byte Folded Reload
; 64BIT-NEXT:    ld 31, 152(1) # 8-byte Folded Reload
; 64BIT-NEXT:    ld 30, 144(1) # 8-byte Folded Reload
; 64BIT-NEXT:    ld 29, 136(1) # 8-byte Folded Reload
; 64BIT-NEXT:    ld 28, 128(1) # 8-byte Folded Reload
; 64BIT-NEXT:    ld 27, 120(1) # 8-byte Folded Reload
; 64BIT-NEXT:    addi 1, 1, 176
; 64BIT-NEXT:    ld 0, 16(1)
; 64BIT-NEXT:    mtlr 0
; 64BIT-NEXT:    blr
entry:
  %add = fadd double %a, %j
  tail call void @consume_f64(double %add)
  %add1 = fadd float %f, %g
  tail call void @consume_f32(float %add1)
  %add2 = add nsw i64 %c, %b
  %conv = sext i32 %d to i64
  %add3 = add nsw i64 %add2, %conv
  %add4 = add nsw i64 %add3, %e
  tail call void @consume_i64(i64 %add4)
  %add5 = add nsw i32 %i, %d
  tail call void @consume_i32(i32 signext %add5)
  ret void
}

define void @mixed_2(<2 x double> %a, <4 x i32> %b, i64 %c) #0 {
; 32BIT-LABEL: mixed_2:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    mflr 0
; 32BIT-NEXT:    stwu 1, -80(1)
; 32BIT-NEXT:    li 5, 64
; 32BIT-NEXT:    stw 0, 88(1)
; 32BIT-NEXT:    stw 4, 140(1)
; 32BIT-NEXT:    stw 3, 136(1)
; 32BIT-NEXT:    stxvd2x 34, 1, 5 # 16-byte Folded Spill
; 32BIT-NEXT:    addi 5, 1, 120
; 32BIT-NEXT:    stxvw4x 35, 0, 5
; 32BIT-NEXT:    addi 5, 1, 104
; 32BIT-NEXT:    stxvd2x 34, 0, 5
; 32BIT-NEXT:    lwz 5, 120(1)
; 32BIT-NEXT:    srawi 6, 5, 31
; 32BIT-NEXT:    addc 4, 5, 4
; 32BIT-NEXT:    adde 3, 6, 3
; 32BIT-NEXT:    bl .consume_i64[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    li 3, 64
; 32BIT-NEXT:    lxvd2x 1, 1, 3 # 16-byte Folded Reload
; 32BIT-NEXT:    # kill: def $f1 killed $f1 killed $vsl1
; 32BIT-NEXT:    bl .consume_f64[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    addi 1, 1, 80
; 32BIT-NEXT:    lwz 0, 8(1)
; 32BIT-NEXT:    mtlr 0
; 32BIT-NEXT:    blr
;
; 64BIT-LABEL: mixed_2:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    mflr 0
; 64BIT-NEXT:    stdu 1, -144(1)
; 64BIT-NEXT:    li 4, 128
; 64BIT-NEXT:    std 0, 160(1)
; 64BIT-NEXT:    std 3, 224(1)
; 64BIT-NEXT:    stxvd2x 34, 1, 4 # 16-byte Folded Spill
; 64BIT-NEXT:    addi 4, 1, 208
; 64BIT-NEXT:    stxvw4x 35, 0, 4
; 64BIT-NEXT:    addi 4, 1, 192
; 64BIT-NEXT:    stxvd2x 34, 0, 4
; 64BIT-NEXT:    lwa 4, 208(1)
; 64BIT-NEXT:    add 3, 4, 3
; 64BIT-NEXT:    bl .consume_i64[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    li 3, 128
; 64BIT-NEXT:    lxvd2x 1, 1, 3 # 16-byte Folded Reload
; 64BIT-NEXT:    # kill: def $f1 killed $f1 killed $vsl1
; 64BIT-NEXT:    bl .consume_f64[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    addi 1, 1, 144
; 64BIT-NEXT:    ld 0, 16(1)
; 64BIT-NEXT:    mtlr 0
; 64BIT-NEXT:    blr
entry:
  %vecext = extractelement <4 x i32> %b, i64 0
  %conv = sext i32 %vecext to i64
  %add = add nsw i64 %conv, %c
  tail call void @consume_i64(i64 %add)
  %vecext1 = extractelement <2 x double> %a, i64 0
  tail call void @consume_f64(double %vecext1)
  ret void
}

%struct.foo = type <{ [3 x i32], double, [12 x i8], <4 x i32> }>

define void @mixed_3(<2 x double> %a, i64 %b, double %c, float %d, i32 signext %e, double %f, ...) #0 {
; 32BIT-LABEL: mixed_3:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    mflr 0
; 32BIT-NEXT:    stwu 1, -80(1)
; 32BIT-NEXT:    xsadddp 0, 34, 3
; 32BIT-NEXT:    stw 0, 88(1)
; 32BIT-NEXT:    stfd 1, 128(1)
; 32BIT-NEXT:    stw 29, 60(1) # 4-byte Folded Spill
; 32BIT-NEXT:    addi 3, 1, 104
; 32BIT-NEXT:    lwz 29, 148(1)
; 32BIT-NEXT:    stw 30, 64(1) # 4-byte Folded Spill
; 32BIT-NEXT:    stw 31, 68(1) # 4-byte Folded Spill
; 32BIT-NEXT:    stfd 31, 72(1) # 8-byte Folded Spill
; 32BIT-NEXT:    fmr 31, 2
; 32BIT-NEXT:    mr 31, 10
; 32BIT-NEXT:    mr 30, 9
; 32BIT-NEXT:    xsadddp 1, 0, 1
; 32BIT-NEXT:    stxvd2x 34, 0, 3
; 32BIT-NEXT:    stfd 3, 144(1)
; 32BIT-NEXT:    stfs 2, 136(1)
; 32BIT-NEXT:    stw 10, 124(1)
; 32BIT-NEXT:    stw 9, 120(1)
; 32BIT-NEXT:    bl .consume_f64[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    mr 3, 30
; 32BIT-NEXT:    mr 4, 31
; 32BIT-NEXT:    bl .consume_i64[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    fmr 1, 31
; 32BIT-NEXT:    bl .consume_f32[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    mr 3, 29
; 32BIT-NEXT:    bl .consume_i32[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    lfd 31, 72(1) # 8-byte Folded Reload
; 32BIT-NEXT:    lwz 31, 68(1) # 4-byte Folded Reload
; 32BIT-NEXT:    lwz 30, 64(1) # 4-byte Folded Reload
; 32BIT-NEXT:    lwz 29, 60(1) # 4-byte Folded Reload
; 32BIT-NEXT:    addi 1, 1, 80
; 32BIT-NEXT:    lwz 0, 8(1)
; 32BIT-NEXT:    mtlr 0
; 32BIT-NEXT:    blr
; 32BIT: NumOfGPRsSaved = 3
;
; 64BIT-LABEL: mixed_3:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    mflr 0
; 64BIT-NEXT:    stdu 1, -144(1)
; 64BIT-NEXT:    xsadddp 0, 34, 3
; 64BIT-NEXT:    std 0, 160(1)
; 64BIT-NEXT:    stfd 1, 216(1)
; 64BIT-NEXT:    addi 3, 1, 192
; 64BIT-NEXT:    std 30, 120(1) # 8-byte Folded Spill
; 64BIT-NEXT:    std 31, 128(1) # 8-byte Folded Spill
; 64BIT-NEXT:    stfd 31, 136(1) # 8-byte Folded Spill
; 64BIT-NEXT:    mr 31, 8
; 64BIT-NEXT:    fmr 31, 2
; 64BIT-NEXT:    mr 30, 5
; 64BIT-NEXT:    stxvd2x 34, 0, 3
; 64BIT-NEXT:    xsadddp 1, 0, 1
; 64BIT-NEXT:    std 10, 248(1)
; 64BIT-NEXT:    stfd 3, 240(1)
; 64BIT-NEXT:    std 8, 232(1)
; 64BIT-NEXT:    stfs 2, 224(1)
; 64BIT-NEXT:    std 5, 208(1)
; 64BIT-NEXT:    bl .consume_f64[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    mr 3, 30
; 64BIT-NEXT:    bl .consume_i64[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    fmr 1, 31
; 64BIT-NEXT:    bl .consume_f32[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    mr 3, 31
; 64BIT-NEXT:    bl .consume_i32[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    lfd 31, 136(1) # 8-byte Folded Reload
; 64BIT-NEXT:    ld 31, 128(1) # 8-byte Folded Reload
; 64BIT-NEXT:    ld 30, 120(1) # 8-byte Folded Reload
; 64BIT-NEXT:    addi 1, 1, 144
; 64BIT-NEXT:    ld 0, 16(1)
; 64BIT-NEXT:    mtlr 0
; 64BIT-NEXT:    blr
; 64BIT: NumOfGPRsSaved = 2
entry:
  %vecext = extractelement <2 x double> %a, i64 0
  %add = fadd double %vecext, %f
  %add1 = fadd double %add, %c
  tail call void @consume_f64(double %add1)
  tail call void @consume_i64(i64 %b)
  tail call void @consume_f32(float %d)
  tail call void @consume_i32(i32 signext %e)
  ret void
}

define signext i32 @mixed_4(ptr byval(%struct.foo) align 16 %foo, i32 %sec) #0 {
; 32BIT-LABEL: mixed_4:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    stw 9, 48(1)
; 32BIT-NEXT:    stw 8, 44(1)
; 32BIT-NEXT:    lfd 0, 44(1)
; 32BIT-NEXT:    addi 3, 1, -4
; 32BIT-NEXT:    xscvdpsxws 0, 0
; 32BIT-NEXT:    stw 5, 32(1)
; 32BIT-NEXT:    stw 6, 36(1)
; 32BIT-NEXT:    stw 7, 40(1)
; 32BIT-NEXT:    stw 10, 52(1)
; 32BIT-NEXT:    stfiwx 0, 0, 3
; 32BIT-NEXT:    lwz 3, -4(1)
; 32BIT-NEXT:    lwz 4, 76(1)
; 32BIT-NEXT:    add 3, 5, 3
; 32BIT-NEXT:    add 3, 3, 4
; 32BIT-NEXT:    blr
;
; 64BIT-LABEL: mixed_4:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    std 5, 64(1)
; 64BIT-NEXT:    std 4, 56(1)
; 64BIT-NEXT:    lfd 0, 60(1)
; 64BIT-NEXT:    addi 4, 1, -4
; 64BIT-NEXT:    xscvdpsxws 0, 0
; 64BIT-NEXT:    std 3, 48(1)
; 64BIT-NEXT:    std 6, 72(1)
; 64BIT-NEXT:    std 7, 80(1)
; 64BIT-NEXT:    std 8, 88(1)
; 64BIT-NEXT:    std 9, 96(1)
; 64BIT-NEXT:    rldicl 3, 3, 32, 32
; 64BIT-NEXT:    stfiwx 0, 0, 4
; 64BIT-NEXT:    lwz 4, -4(1)
; 64BIT-NEXT:    add 3, 3, 4
; 64BIT-NEXT:    add 3, 3, 8
; 64BIT-NEXT:    extsw 3, 3
; 64BIT-NEXT:    blr
entry:
  %0 = load i32, ptr %foo, align 16
  %x = getelementptr inbounds i8, ptr %foo, i64 12
  %1 = load double, ptr %x, align 4
  %conv = fptosi double %1 to i32
  %add = add nsw i32 %0, %conv
  %2 = getelementptr inbounds i8, ptr %foo, i64 44
  %vecext = load i32, ptr %2, align 4
  %add1 = add nsw i32 %add, %vecext
  ret i32 %add1
}

%struct.bar = type { i8, i32, <4 x i32>, ptr, i8 }

define void @mixed_5(ptr byref(%struct.bar) align 16 %r, ptr byval(%struct.bar) align 16 %x, i32 signext %y, ptr byval(%struct.foo) align 16 %f) #0 {
; 32BIT-LABEL: mixed_5:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    mflr 0
; 32BIT-NEXT:    stwu 1, -64(1)
; 32BIT-NEXT:    stw 0, 72(1)
; 32BIT-NEXT:    stw 5, 96(1)
; 32BIT-NEXT:    lfd 1, 172(1)
; 32BIT-NEXT:    stw 6, 100(1)
; 32BIT-NEXT:    stw 7, 104(1)
; 32BIT-NEXT:    stw 8, 108(1)
; 32BIT-NEXT:    stw 9, 112(1)
; 32BIT-NEXT:    stw 10, 116(1)
; 32BIT-NEXT:    stw 3, 88(1)
; 32BIT-NEXT:    bl .consume_f64[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    lwz 3, 100(1)
; 32BIT-NEXT:    bl .consume_i32[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    addi 1, 1, 64
; 32BIT-NEXT:    lwz 0, 8(1)
; 32BIT-NEXT:    mtlr 0
; 32BIT-NEXT:    blr
;
; 64BIT-LABEL: mixed_5:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    mflr 0
; 64BIT-NEXT:    stdu 1, -112(1)
; 64BIT-NEXT:    std 0, 128(1)
; 64BIT-NEXT:    std 5, 176(1)
; 64BIT-NEXT:    lfd 1, 252(1)
; 64BIT-NEXT:    std 6, 184(1)
; 64BIT-NEXT:    std 7, 192(1)
; 64BIT-NEXT:    std 8, 200(1)
; 64BIT-NEXT:    std 9, 208(1)
; 64BIT-NEXT:    std 10, 216(1)
; 64BIT-NEXT:    std 3, 160(1)
; 64BIT-NEXT:    bl .consume_f64[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    lwa 3, 180(1)
; 64BIT-NEXT:    bl .consume_i32[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    addi 1, 1, 112
; 64BIT-NEXT:    ld 0, 16(1)
; 64BIT-NEXT:    mtlr 0
; 64BIT-NEXT:    blr
entry:
  %d = getelementptr inbounds i8, ptr %f, i64 12
  %0 = load double, ptr %d, align 4
  tail call void @consume_f64(double %0)
  %i = getelementptr inbounds i8, ptr %x, i64 4
  %1 = load i32, ptr %i, align 4
  tail call void @consume_i32(i32 signext %1)
  ret void
}

declare void @foo()
declare void @consume_f64(double)
declare void @consume_f32(float)
declare void @consume_i64(i64)
declare void @consume_i32(i32 signext)

attributes #0 = { nofree noinline nounwind "save-reg-params" }
