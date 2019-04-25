; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -mattr=sse2 | FileCheck %s --check-prefix=SSE
; RUN: llc < %s -mtriple=x86_64-- -mattr=avx  | FileCheck %s --check-prefix=AVX

define <2 x double> @splat_fdiv_v2f64(<2 x double> %x, double %y) {
; SSE-LABEL: splat_fdiv_v2f64:
; SSE:       # %bb.0:
; SSE-NEXT:    movsd {{.*#+}} xmm2 = mem[0],zero
; SSE-NEXT:    divsd %xmm1, %xmm2
; SSE-NEXT:    unpcklpd {{.*#+}} xmm2 = xmm2[0,0]
; SSE-NEXT:    mulpd %xmm2, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: splat_fdiv_v2f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovsd {{.*#+}} xmm2 = mem[0],zero
; AVX-NEXT:    vdivsd %xmm1, %xmm2, %xmm1
; AVX-NEXT:    vmovddup {{.*#+}} xmm1 = xmm1[0,0]
; AVX-NEXT:    vmulpd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %vy = insertelement <2 x double> undef, double %y, i32 0
  %splaty = shufflevector <2 x double> %vy, <2 x double> undef, <2 x i32> zeroinitializer
  %r = fdiv fast <2 x double> %x, %splaty
  ret <2 x double> %r
}

define <4 x double> @splat_fdiv_v4f64(<4 x double> %x, double %y) {
; SSE-LABEL: splat_fdiv_v4f64:
; SSE:       # %bb.0:
; SSE-NEXT:    movsd {{.*#+}} xmm3 = mem[0],zero
; SSE-NEXT:    divsd %xmm2, %xmm3
; SSE-NEXT:    unpcklpd {{.*#+}} xmm3 = xmm3[0,0]
; SSE-NEXT:    mulpd %xmm3, %xmm0
; SSE-NEXT:    mulpd %xmm3, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: splat_fdiv_v4f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovsd {{.*#+}} xmm2 = mem[0],zero
; AVX-NEXT:    vdivsd %xmm1, %xmm2, %xmm1
; AVX-NEXT:    vmovddup {{.*#+}} xmm1 = xmm1[0,0]
; AVX-NEXT:    vinsertf128 $1, %xmm1, %ymm1, %ymm1
; AVX-NEXT:    vmulpd %ymm1, %ymm0, %ymm0
; AVX-NEXT:    retq
  %vy = insertelement <4 x double> undef, double %y, i32 0
  %splaty = shufflevector <4 x double> %vy, <4 x double> undef, <4 x i32> zeroinitializer
  %r = fdiv arcp <4 x double> %x, %splaty
  ret <4 x double> %r
}

define <4 x float> @splat_fdiv_v4f32(<4 x float> %x, float %y) {
; SSE-LABEL: splat_fdiv_v4f32:
; SSE:       # %bb.0:
; SSE-NEXT:    shufps {{.*#+}} xmm1 = xmm1[0,0,0,0]
; SSE-NEXT:    rcpps %xmm1, %xmm2
; SSE-NEXT:    mulps %xmm2, %xmm1
; SSE-NEXT:    movaps {{.*#+}} xmm3 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0]
; SSE-NEXT:    subps %xmm1, %xmm3
; SSE-NEXT:    mulps %xmm2, %xmm3
; SSE-NEXT:    addps %xmm2, %xmm3
; SSE-NEXT:    mulps %xmm3, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: splat_fdiv_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpermilps {{.*#+}} xmm1 = xmm1[0,0,0,0]
; AVX-NEXT:    vrcpps %xmm1, %xmm2
; AVX-NEXT:    vmulps %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vmovaps {{.*#+}} xmm3 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0]
; AVX-NEXT:    vsubps %xmm1, %xmm3, %xmm1
; AVX-NEXT:    vmulps %xmm1, %xmm2, %xmm1
; AVX-NEXT:    vaddps %xmm1, %xmm2, %xmm1
; AVX-NEXT:    vmulps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %vy = insertelement <4 x float> undef, float %y, i32 0
  %splaty = shufflevector <4 x float> %vy, <4 x float> undef, <4 x i32> zeroinitializer
  %r = fdiv arcp reassoc <4 x float> %x, %splaty
  ret <4 x float> %r
}

define <8 x float> @splat_fdiv_v8f32(<8 x float> %x, float %y) {
; SSE-LABEL: splat_fdiv_v8f32:
; SSE:       # %bb.0:
; SSE-NEXT:    movss {{.*#+}} xmm3 = mem[0],zero,zero,zero
; SSE-NEXT:    divss %xmm2, %xmm3
; SSE-NEXT:    shufps {{.*#+}} xmm3 = xmm3[0,0,0,0]
; SSE-NEXT:    mulps %xmm3, %xmm0
; SSE-NEXT:    mulps %xmm3, %xmm1
; SSE-NEXT:    retq
;
; AVX-LABEL: splat_fdiv_v8f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vpermilps {{.*#+}} xmm1 = xmm1[0,0,0,0]
; AVX-NEXT:    vinsertf128 $1, %xmm1, %ymm1, %ymm1
; AVX-NEXT:    vrcpps %ymm1, %ymm2
; AVX-NEXT:    vmulps %ymm2, %ymm1, %ymm1
; AVX-NEXT:    vmovaps {{.*#+}} ymm3 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
; AVX-NEXT:    vsubps %ymm1, %ymm3, %ymm1
; AVX-NEXT:    vmulps %ymm1, %ymm2, %ymm1
; AVX-NEXT:    vaddps %ymm1, %ymm2, %ymm1
; AVX-NEXT:    vmulps %ymm1, %ymm0, %ymm0
; AVX-NEXT:    retq
  %vy = insertelement <8 x float> undef, float %y, i32 0
  %splaty = shufflevector <8 x float> %vy, <8 x float> undef, <8 x i32> zeroinitializer
  %r = fdiv fast <8 x float> %x, %splaty
  ret <8 x float> %r
}
