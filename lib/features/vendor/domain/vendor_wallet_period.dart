/// How far back the statement list reaches.
enum VendorWalletPeriod { week, month, year }

/// Week is the narrowest window. A week entry is also in the month and the year.
bool walletPeriodIncludes(
  VendorWalletPeriod selected,
  VendorWalletPeriod earliest,
) {
  return switch (selected) {
    VendorWalletPeriod.week => earliest == VendorWalletPeriod.week,
    VendorWalletPeriod.month => earliest != VendorWalletPeriod.year,
    VendorWalletPeriod.year => true,
  };
}
