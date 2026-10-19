import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_period.dart';

void main() {
  test('a week entry stays visible in the wider windows', () {
    expect(
      walletPeriodIncludes(VendorWalletPeriod.week, VendorWalletPeriod.week),
      isTrue,
    );
    expect(
      walletPeriodIncludes(VendorWalletPeriod.month, VendorWalletPeriod.week),
      isTrue,
    );
    expect(
      walletPeriodIncludes(VendorWalletPeriod.week, VendorWalletPeriod.month),
      isFalse,
    );
  });
}
