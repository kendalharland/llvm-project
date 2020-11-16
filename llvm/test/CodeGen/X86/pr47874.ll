; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-apple-darwin19.6.0 | FileCheck %s --check-prefix=SSE2
; RUN: llc < %s -mtriple=x86_64-apple-darwin19.6.0 -mattr=avx | FileCheck %s --check-prefix=AVX
; RUN: llc < %s -mtriple=x86_64-apple-darwin19.6.0 -mattr=avx512f | FileCheck %s --check-prefix=AVX

define void @a(float* %arg, i32 %arg1) {
; SSE2-LABEL: a:
; SSE2:       ## %bb.0: ## %bb
; SSE2-NEXT:    testl %esi, %esi
; SSE2-NEXT:    jle LBB0_3
; SSE2-NEXT:  ## %bb.1: ## %bb2
; SSE2-NEXT:    movl %esi, {{[-0-9]+}}(%r{{[sb]}}p) ## 4-byte Spill
; SSE2-NEXT:    movl %esi, %eax
; SSE2-NEXT:    .p2align 4, 0x90
; SSE2-NEXT:  LBB0_2: ## %bb6
; SSE2-NEXT:    ## =>This Inner Loop Header: Depth=1
; SSE2-NEXT:    ## InlineAsm Start
; SSE2-NEXT:    ## InlineAsm End
; SSE2-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE2-NEXT:    addss {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 ## 4-byte Folded Reload
; SSE2-NEXT:    movss %xmm0, (%rdi)
; SSE2-NEXT:    addq $4, %rdi
; SSE2-NEXT:    decq %rax
; SSE2-NEXT:    jne LBB0_2
; SSE2-NEXT:  LBB0_3: ## %bb5
; SSE2-NEXT:    retq
;
; AVX-LABEL: a:
; AVX:       ## %bb.0: ## %bb
; AVX-NEXT:    testl %esi, %esi
; AVX-NEXT:    jle LBB0_3
; AVX-NEXT:  ## %bb.1: ## %bb2
; AVX-NEXT:    movl %esi, {{[-0-9]+}}(%r{{[sb]}}p) ## 4-byte Spill
; AVX-NEXT:    movl %esi, %eax
; AVX-NEXT:    .p2align 4, 0x90
; AVX-NEXT:  LBB0_2: ## %bb6
; AVX-NEXT:    ## =>This Inner Loop Header: Depth=1
; AVX-NEXT:    ## InlineAsm Start
; AVX-NEXT:    ## InlineAsm End
; AVX-NEXT:    vmovss {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 ## 4-byte Reload
; AVX-NEXT:    ## xmm0 = mem[0],zero,zero,zero
; AVX-NEXT:    vaddss (%rdi), %xmm0, %xmm0
; AVX-NEXT:    vmovss %xmm0, (%rdi)
; AVX-NEXT:    addq $4, %rdi
; AVX-NEXT:    decq %rax
; AVX-NEXT:    jne LBB0_2
; AVX-NEXT:  LBB0_3: ## %bb5
; AVX-NEXT:    retq
bb:
  %i = icmp sgt i32 %arg1, 0
  br i1 %i, label %bb2, label %bb5

bb2:                                              ; preds = %bb
  %i3 = bitcast i32 %arg1 to float
  %i4 = zext i32 %arg1 to i64
  br label %bb6

bb5:                                              ; preds = %bb6, %bb
  ret void

bb6:                                              ; preds = %bb6, %bb2
  %i7 = phi i64 [ 0, %bb2 ], [ %i11, %bb6 ]
  tail call void asm sideeffect "", "~{xmm0},~{xmm1},~{xmm2},~{xmm3},~{xmm4},~{xmm5},~{xmm6},~{xmm7},~{xmm8},~{xmm9},~{xmm10},~{xmm11},~{xmm12},~{xmm13},~{xmm14},~{xmm15},~{xmm16},~{xmm17},~{xmm18},~{xmm19},~{xmm20},~{xmm21},~{xmm22},~{xmm23},~{xmm24},~{xmm25},~{xmm26},~{xmm27},~{xmm28},~{xmm29},~{xmm30},~{xmm31},~{dirflag},~{fpsr},~{flags}"()
  %i8 = getelementptr inbounds float, float* %arg, i64 %i7
  %i9 = load float, float* %i8, align 4
  %i10 = fadd float %i9, %i3
  store float %i10, float* %i8, align 4
  %i11 = add nuw nsw i64 %i7, 1
  %i12 = icmp eq i64 %i11, %i4
  br i1 %i12, label %bb5, label %bb6
}

define void @b(double* %arg, i64 %arg1) {
; SSE2-LABEL: b:
; SSE2:       ## %bb.0: ## %bb
; SSE2-NEXT:    testq %rsi, %rsi
; SSE2-NEXT:    jle LBB1_3
; SSE2-NEXT:  ## %bb.1: ## %bb2
; SSE2-NEXT:    movq %rsi, {{[-0-9]+}}(%r{{[sb]}}p) ## 8-byte Spill
; SSE2-NEXT:    .p2align 4, 0x90
; SSE2-NEXT:  LBB1_2: ## %bb6
; SSE2-NEXT:    ## =>This Inner Loop Header: Depth=1
; SSE2-NEXT:    ## InlineAsm Start
; SSE2-NEXT:    ## InlineAsm End
; SSE2-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSE2-NEXT:    addsd {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 ## 8-byte Folded Reload
; SSE2-NEXT:    movsd %xmm0, (%rdi)
; SSE2-NEXT:    addq $8, %rdi
; SSE2-NEXT:    decq %rsi
; SSE2-NEXT:    jne LBB1_2
; SSE2-NEXT:  LBB1_3: ## %bb5
; SSE2-NEXT:    retq
;
; AVX-LABEL: b:
; AVX:       ## %bb.0: ## %bb
; AVX-NEXT:    testq %rsi, %rsi
; AVX-NEXT:    jle LBB1_3
; AVX-NEXT:  ## %bb.1: ## %bb2
; AVX-NEXT:    movq %rsi, {{[-0-9]+}}(%r{{[sb]}}p) ## 8-byte Spill
; AVX-NEXT:    .p2align 4, 0x90
; AVX-NEXT:  LBB1_2: ## %bb6
; AVX-NEXT:    ## =>This Inner Loop Header: Depth=1
; AVX-NEXT:    ## InlineAsm Start
; AVX-NEXT:    ## InlineAsm End
; AVX-NEXT:    vmovsd {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 ## 8-byte Reload
; AVX-NEXT:    ## xmm0 = mem[0],zero
; AVX-NEXT:    vaddsd (%rdi), %xmm0, %xmm0
; AVX-NEXT:    vmovsd %xmm0, (%rdi)
; AVX-NEXT:    addq $8, %rdi
; AVX-NEXT:    decq %rsi
; AVX-NEXT:    jne LBB1_2
; AVX-NEXT:  LBB1_3: ## %bb5
; AVX-NEXT:    retq
bb:
  %i = icmp sgt i64 %arg1, 0
  br i1 %i, label %bb2, label %bb5

bb2:                                              ; preds = %bb
  %i3 = bitcast i64 %arg1 to double
  br label %bb6

bb5:                                              ; preds = %bb6, %bb
  ret void

bb6:                                              ; preds = %bb6, %bb2
  %i7 = phi i64 [ 0, %bb2 ], [ %i11, %bb6 ]
  tail call void asm sideeffect "", "~{xmm0},~{xmm1},~{xmm2},~{xmm3},~{xmm4},~{xmm5},~{xmm6},~{xmm7},~{xmm8},~{xmm9},~{xmm10},~{xmm11},~{xmm12},~{xmm13},~{xmm14},~{xmm15},~{xmm16},~{xmm17},~{xmm18},~{xmm19},~{xmm20},~{xmm21},~{xmm22},~{xmm23},~{xmm24},~{xmm25},~{xmm26},~{xmm27},~{xmm28},~{xmm29},~{xmm30},~{xmm31},~{dirflag},~{fpsr},~{flags}"()
  %i8 = getelementptr inbounds double, double* %arg, i64 %i7
  %i9 = load double, double* %i8, align 4
  %i10 = fadd double %i9, %i3
  store double %i10, double* %i8, align 4
  %i11 = add nuw nsw i64 %i7, 1
  %i12 = icmp eq i64 %i11, %arg1
  br i1 %i12, label %bb5, label %bb6
}

define void @c(<4 x float>* %arg, <4 x float>* %arg1, i32 %arg2) {
; SSE2-LABEL: c:
; SSE2:       ## %bb.0: ## %bb
; SSE2-NEXT:    testl %edx, %edx
; SSE2-NEXT:    jle LBB2_3
; SSE2-NEXT:  ## %bb.1: ## %bb4
; SSE2-NEXT:    movd %edx, %xmm0
; SSE2-NEXT:    movdqa %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) ## 16-byte Spill
; SSE2-NEXT:    movl %edx, %eax
; SSE2-NEXT:    .p2align 4, 0x90
; SSE2-NEXT:  LBB2_2: ## %bb8
; SSE2-NEXT:    ## =>This Inner Loop Header: Depth=1
; SSE2-NEXT:    ## InlineAsm Start
; SSE2-NEXT:    ## InlineAsm End
; SSE2-NEXT:    movaps (%rdi), %xmm0
; SSE2-NEXT:    addss {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 ## 16-byte Folded Reload
; SSE2-NEXT:    movaps %xmm0, (%rdi)
; SSE2-NEXT:    addq $16, %rdi
; SSE2-NEXT:    decq %rax
; SSE2-NEXT:    jne LBB2_2
; SSE2-NEXT:  LBB2_3: ## %bb7
; SSE2-NEXT:    retq
;
; AVX-LABEL: c:
; AVX:       ## %bb.0: ## %bb
; AVX-NEXT:    testl %edx, %edx
; AVX-NEXT:    jle LBB2_3
; AVX-NEXT:  ## %bb.1: ## %bb4
; AVX-NEXT:    vmovd %edx, %xmm0
; AVX-NEXT:    vmovdqa %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) ## 16-byte Spill
; AVX-NEXT:    movl %edx, %eax
; AVX-NEXT:    .p2align 4, 0x90
; AVX-NEXT:  LBB2_2: ## %bb8
; AVX-NEXT:    ## =>This Inner Loop Header: Depth=1
; AVX-NEXT:    ## InlineAsm Start
; AVX-NEXT:    ## InlineAsm End
; AVX-NEXT:    vmovaps (%rdi), %xmm0
; AVX-NEXT:    vaddss {{[-0-9]+}}(%r{{[sb]}}p), %xmm0, %xmm0 ## 16-byte Folded Reload
; AVX-NEXT:    vmovaps %xmm0, (%rdi)
; AVX-NEXT:    addq $16, %rdi
; AVX-NEXT:    decq %rax
; AVX-NEXT:    jne LBB2_2
; AVX-NEXT:  LBB2_3: ## %bb7
; AVX-NEXT:    retq
bb:
  %i = icmp sgt i32 %arg2, 0
  br i1 %i, label %bb4, label %bb7

bb4:                                              ; preds = %bb
  %i5 = bitcast i32 %arg2 to float
  %i6 = zext i32 %arg2 to i64
  br label %bb8

bb7:                                              ; preds = %bb8, %bb
  ret void

bb8:                                              ; preds = %bb8, %bb4
  %i9 = phi i64 [ 0, %bb4 ], [ %i15, %bb8 ]
  tail call void asm sideeffect "", "~{xmm0},~{xmm1},~{xmm2},~{xmm3},~{xmm4},~{xmm5},~{xmm6},~{xmm7},~{xmm8},~{xmm9},~{xmm10},~{xmm11},~{xmm12},~{xmm13},~{xmm14},~{xmm15},~{xmm16},~{xmm17},~{xmm18},~{xmm19},~{xmm20},~{xmm21},~{xmm22},~{xmm23},~{xmm24},~{xmm25},~{xmm26},~{xmm27},~{xmm28},~{xmm29},~{xmm30},~{xmm31},~{dirflag},~{fpsr},~{flags}"()
  %i10 = getelementptr inbounds <4 x float>, <4 x float>* %arg, i64 %i9
  %i11 = load <4 x float>, <4 x float>* %i10, align 16
  %i12 = extractelement <4 x float> %i11, i32 0
  %i13 = fadd float %i12, %i5
  %i14 = insertelement <4 x float> %i11, float %i13, i32 0
  store <4 x float> %i14, <4 x float>* %i10, align 16
  %i15 = add nuw nsw i64 %i9, 1
  %i16 = icmp eq i64 %i15, %i6
  br i1 %i16, label %bb7, label %bb8
}

define void @d(<2 x double>* %arg, <2 x double>* %arg1, i64 %arg2) {
; SSE2-LABEL: d:
; SSE2:       ## %bb.0: ## %bb
; SSE2-NEXT:    testq %rdx, %rdx
; SSE2-NEXT:    jle LBB3_3
; SSE2-NEXT:  ## %bb.1: ## %bb3
; SSE2-NEXT:    movq %rdx, %xmm0
; SSE2-NEXT:    movdqa %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) ## 16-byte Spill
; SSE2-NEXT:    .p2align 4, 0x90
; SSE2-NEXT:  LBB3_2: ## %bb6
; SSE2-NEXT:    ## =>This Inner Loop Header: Depth=1
; SSE2-NEXT:    ## InlineAsm Start
; SSE2-NEXT:    ## InlineAsm End
; SSE2-NEXT:    movapd (%rdi), %xmm0
; SSE2-NEXT:    addsd {{[-0-9]+}}(%r{{[sb]}}p), %xmm0 ## 16-byte Folded Reload
; SSE2-NEXT:    movapd %xmm0, (%rdi)
; SSE2-NEXT:    addq $16, %rdi
; SSE2-NEXT:    decq %rdx
; SSE2-NEXT:    jne LBB3_2
; SSE2-NEXT:  LBB3_3: ## %bb5
; SSE2-NEXT:    retq
;
; AVX-LABEL: d:
; AVX:       ## %bb.0: ## %bb
; AVX-NEXT:    testq %rdx, %rdx
; AVX-NEXT:    jle LBB3_3
; AVX-NEXT:  ## %bb.1: ## %bb3
; AVX-NEXT:    vmovq %rdx, %xmm0
; AVX-NEXT:    vmovdqa %xmm0, {{[-0-9]+}}(%r{{[sb]}}p) ## 16-byte Spill
; AVX-NEXT:    .p2align 4, 0x90
; AVX-NEXT:  LBB3_2: ## %bb6
; AVX-NEXT:    ## =>This Inner Loop Header: Depth=1
; AVX-NEXT:    ## InlineAsm Start
; AVX-NEXT:    ## InlineAsm End
; AVX-NEXT:    vmovapd (%rdi), %xmm0
; AVX-NEXT:    vaddsd {{[-0-9]+}}(%r{{[sb]}}p), %xmm0, %xmm0 ## 16-byte Folded Reload
; AVX-NEXT:    vmovapd %xmm0, (%rdi)
; AVX-NEXT:    addq $16, %rdi
; AVX-NEXT:    decq %rdx
; AVX-NEXT:    jne LBB3_2
; AVX-NEXT:  LBB3_3: ## %bb5
; AVX-NEXT:    retq
bb:
  %i = icmp sgt i64 %arg2, 0
  br i1 %i, label %bb3, label %bb5

bb3:                                              ; preds = %bb
  %i4 = bitcast i64 %arg2 to double
  br label %bb6

bb5:                                              ; preds = %bb6, %bb
  ret void

bb6:                                              ; preds = %bb6, %bb3
  %i7 = phi i64 [ 0, %bb3 ], [ %i13, %bb6 ]
  tail call void asm sideeffect "", "~{xmm0},~{xmm1},~{xmm2},~{xmm3},~{xmm4},~{xmm5},~{xmm6},~{xmm7},~{xmm8},~{xmm9},~{xmm10},~{xmm11},~{xmm12},~{xmm13},~{xmm14},~{xmm15},~{xmm16},~{xmm17},~{xmm18},~{xmm19},~{xmm20},~{xmm21},~{xmm22},~{xmm23},~{xmm24},~{xmm25},~{xmm26},~{xmm27},~{xmm28},~{xmm29},~{xmm30},~{xmm31},~{dirflag},~{fpsr},~{flags}"()
  %i8 = getelementptr inbounds <2 x double>, <2 x double>* %arg, i64 %i7
  %i9 = load <2 x double>, <2 x double>* %i8, align 16
  %i10 = extractelement <2 x double> %i9, i32 0
  %i11 = fadd double %i10, %i4
  %i12 = insertelement <2 x double> %i9, double %i11, i32 0
  store <2 x double> %i12, <2 x double>* %i8, align 16
  %i13 = add nuw nsw i64 %i7, 1
  %i14 = icmp eq i64 %i13, %arg2
  br i1 %i14, label %bb5, label %bb6
}
