//===-- asan_errors.cc ------------------------------------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file is a part of AddressSanitizer, an address sanity checker.
//
// ASan implementation for error structures.
//===----------------------------------------------------------------------===//

#include "asan_errors.h"
#include <signal.h>
#include "asan_descriptions.h"
#include "asan_report.h"
#include "asan_stack.h"

namespace __asan {

void ErrorStackOverflow::Print() {
  Decorator d;
  Printf("%s", d.Warning());
  Report(
      "ERROR: AddressSanitizer: stack-overflow on address %p"
      " (pc %p bp %p sp %p T%d)\n",
      (void *)addr, (void *)pc, (void *)bp, (void *)sp, tid);
  Printf("%s", d.EndWarning());
  scariness.Print();
  BufferedStackTrace stack;
  GetStackTraceWithPcBpAndContext(&stack, kStackTraceMax, pc, bp, context,
                                  common_flags()->fast_unwind_on_fatal);
  stack.Print();
  ReportErrorSummary("stack-overflow", &stack);
}

static void MaybeDumpInstructionBytes(uptr pc) {
  if (!flags()->dump_instruction_bytes || (pc < GetPageSizeCached())) return;
  InternalScopedString str(1024);
  str.append("First 16 instruction bytes at pc: ");
  if (IsAccessibleMemoryRange(pc, 16)) {
    for (int i = 0; i < 16; ++i) {
      PrintMemoryByte(&str, "", ((u8 *)pc)[i], /*in_shadow*/ false, " ");
    }
    str.append("\n");
  } else {
    str.append("unaccessible\n");
  }
  Report("%s", str.data());
}

void ErrorDeadlySignal::Print() {
  Decorator d;
  Printf("%s", d.Warning());
  const char *description = DescribeSignalOrException(signo);
  Report(
      "ERROR: AddressSanitizer: %s on unknown address %p (pc %p bp %p sp %p "
      "T%d)\n",
      description, (void *)addr, (void *)pc, (void *)bp, (void *)sp, tid);
  Printf("%s", d.EndWarning());
  if (pc < GetPageSizeCached()) Report("Hint: pc points to the zero page.\n");
  if (is_memory_access) {
    const char *access_type =
        write_flag == SignalContext::WRITE
            ? "WRITE"
            : (write_flag == SignalContext::READ ? "READ" : "UNKNOWN");
    Report("The signal is caused by a %s memory access.\n", access_type);
    if (addr < GetPageSizeCached())
      Report("Hint: address points to the zero page.\n");
  }
  scariness.Print();
  BufferedStackTrace stack;
  GetStackTraceWithPcBpAndContext(&stack, kStackTraceMax, pc, bp, context,
                                  common_flags()->fast_unwind_on_fatal);
  stack.Print();
  MaybeDumpInstructionBytes(pc);
  Printf("AddressSanitizer can not provide additional info.\n");
  ReportErrorSummary(description, &stack);
}

void ErrorDoubleFree::Print() {
  Decorator d;
  Printf("%s", d.Warning());
  char tname[128];
  Report(
      "ERROR: AddressSanitizer: attempting double-free on %p in "
      "thread T%d%s:\n",
      addr_description.addr, tid,
      ThreadNameWithParenthesis(tid, tname, sizeof(tname)));
  Printf("%s", d.EndWarning());
  scariness.Print();
  GET_STACK_TRACE_FATAL(second_free_stack->trace[0],
                        second_free_stack->top_frame_bp);
  stack.Print();
  addr_description.Print();
  ReportErrorSummary("double-free", &stack);
}

void ErrorNewDeleteSizeMismatch::Print() {
  Decorator d;
  Printf("%s", d.Warning());
  char tname[128];
  Report(
      "ERROR: AddressSanitizer: new-delete-type-mismatch on %p in thread "
      "T%d%s:\n",
      addr_description.addr, tid,
      ThreadNameWithParenthesis(tid, tname, sizeof(tname)));
  Printf("%s  object passed to delete has wrong type:\n", d.EndWarning());
  Printf(
      "  size of the allocated type:   %zd bytes;\n"
      "  size of the deallocated type: %zd bytes.\n",
      addr_description.chunk_access.chunk_size, delete_size);
  CHECK_GT(free_stack->size, 0);
  scariness.Print();
  GET_STACK_TRACE_FATAL(free_stack->trace[0], free_stack->top_frame_bp);
  stack.Print();
  addr_description.Print();
  ReportErrorSummary("new-delete-type-mismatch", &stack);
  Report(
      "HINT: if you don't care about these errors you may set "
      "ASAN_OPTIONS=new_delete_type_mismatch=0\n");
}

}  // namespace __asan
