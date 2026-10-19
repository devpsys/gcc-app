import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/vendor/domain/vendor_withdrawal_gap.dart';

void main() {
  test('a payout has to sit between the minimum and the available balance', () {
    expect(
      withdrawalGap(amount: null, available: 486200),
      VendorWithdrawalGap.empty,
    );
    expect(
      withdrawalGap(amount: 5000, available: 486200),
      VendorWithdrawalGap.belowMinimum,
    );
    expect(
      withdrawalGap(amount: 500000, available: 486200),
      VendorWithdrawalGap.aboveAvailable,
    );
    expect(withdrawalGap(amount: 250000, available: 486200), isNull);
    expect(openingWithdrawal(486200), '250,000');
    expect(openingWithdrawal(20000), '');
  });
}
