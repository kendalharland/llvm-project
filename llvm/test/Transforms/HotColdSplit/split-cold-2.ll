; RUN: opt -hotcoldsplit -S < %s | FileCheck %s
; RUN: opt -passes=hotcoldsplit -S < %s | FileCheck %s

; Make sure this compiles. This test used to fail with an invalid phi node: the
; two predecessors were outlined and the SSA representation was invalid.

; CHECK-LABEL: @fun
; CHECK: codeRepl:
; CHECK-NEXT: call void @fun_if.else

define void @fun() {
entry:
  br i1 undef, label %if.then, label %if.else

if.then:
  ret void

if.else:
  br label %if.then4

if.then4:
  br i1 undef, label %if.then5, label %if.end

if.then5:
  br label %cleanup

if.end:
  br label %cleanup

cleanup:
  %cleanup.dest.slot.0 = phi i32 [ 1, %if.then5 ], [ 0, %if.end ]
  unreachable
}
