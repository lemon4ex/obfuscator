// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple riscv32 -target-feature +experimental-zbb -verify %s -o -

int orc_b_64(int a) {
  return __builtin_riscv_orc_b_64(a); // expected-error {{builtin requires 'RV64' extension support to be enabled}}
}
