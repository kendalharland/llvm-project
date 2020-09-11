//===- CompilerInvocation.cpp ---------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "flang/Frontend/CompilerInvocation.h"
#include "clang/Basic/AllDiagnostics.h"
#include "clang/Basic/DiagnosticDriver.h"
#include "clang/Basic/DiagnosticOptions.h"
#include "clang/Driver/DriverDiagnostic.h"
#include "clang/Driver/Options.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/ADT/StringSwitch.h"
#include "llvm/Option/Arg.h"
#include "llvm/Option/ArgList.h"
#include "llvm/Option/OptTable.h"
#include "llvm/Support/raw_ostream.h"

using namespace Fortran::frontend;

//===----------------------------------------------------------------------===//
// Initialization.
//===----------------------------------------------------------------------===//
CompilerInvocationBase::CompilerInvocationBase()
    : diagnosticOpts_(new clang::DiagnosticOptions()) {}

CompilerInvocationBase::CompilerInvocationBase(const CompilerInvocationBase &x)
    : diagnosticOpts_(new clang::DiagnosticOptions(x.GetDiagnosticOpts())) {}

CompilerInvocationBase::~CompilerInvocationBase() = default;

//===----------------------------------------------------------------------===//
// Deserialization (from args)
//===----------------------------------------------------------------------===//
static InputKind ParseFrontendArgs(FrontendOptions &opts,
    llvm::opt::ArgList &args, clang::DiagnosticsEngine &diags) {
  // Identify the action (i.e. opts.ProgramAction)
  if (const llvm::opt::Arg *a =
          args.getLastArg(clang::driver::options::OPT_Action_Group)) {
    switch (a->getOption().getID()) {
    default: {
      llvm_unreachable("Invalid option in group!");
    }
      // TODO:
      // case clang::driver::options::OPT_E:
      // case clang::driver::options::OPT_emit_obj:
      // case calng::driver::options::OPT_emit_llvm:
      // case clang::driver::options::OPT_emit_llvm_only:
      // case clang::driver::options::OPT_emit_codegen_only:
      // case clang::driver::options::OPT_emit_module:
      // (...)
    }
  }

  opts.showHelp_ = args.hasArg(clang::driver::options::OPT_help);
  opts.showVersion_ = args.hasArg(clang::driver::options::OPT_version);

  // Get the input kind (from the value passed via `-x`)
  InputKind dashX(Language::Unknown);
  if (const llvm::opt::Arg *a =
          args.getLastArg(clang::driver::options::OPT_x)) {
    llvm::StringRef XValue = a->getValue();
    // Principal languages.
    dashX = llvm::StringSwitch<InputKind>(XValue)
                .Case("f90", Language::Fortran)
                .Default(Language::Unknown);

    // Some special cases cannot be combined with suffixes.
    if (dashX.IsUnknown())
      dashX = llvm::StringSwitch<InputKind>(XValue)
                  .Case("ir", Language::LLVM_IR)
                  .Default(Language::Unknown);

    if (dashX.IsUnknown())
      diags.Report(clang::diag::err_drv_invalid_value)
          << a->getAsString(args) << a->getValue();
  }

  return dashX;
}

bool CompilerInvocation::CreateFromArgs(CompilerInvocation &res,
    llvm::ArrayRef<const char *> commandLineArgs,
    clang::DiagnosticsEngine &diags) {

  bool success = true;

  // Parse the arguments
  const llvm::opt::OptTable &opts = clang::driver::getDriverOptTable();
  const unsigned includedFlagsBitmask =
      clang::driver::options::FC1Option;
  unsigned missingArgIndex, missingArgCount;
  llvm::opt::InputArgList args = opts.ParseArgs(
      commandLineArgs, missingArgIndex, missingArgCount, includedFlagsBitmask);

  // Issue errors on unknown arguments
  for (const auto *a : args.filtered(clang::driver::options::OPT_UNKNOWN)) {
    auto argString = a->getAsString(args);
    std::string nearest;
    if (opts.findNearest(argString, nearest, includedFlagsBitmask) > 1)
      diags.Report(clang::diag::err_drv_unknown_argument) << argString;
    else
      diags.Report(clang::diag::err_drv_unknown_argument_with_suggestion)
          << argString << nearest;
    success = false;
  }

  // Parse the frontend args
  ParseFrontendArgs(res.GetFrontendOpts(), args, diags);

  return success;
}
