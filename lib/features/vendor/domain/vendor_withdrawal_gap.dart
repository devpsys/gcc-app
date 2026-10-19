import 'package:gcc_app/features/vendor/domain/naira_amount.dart';

/// The design opens on ₦250,000 when the balance can cover it.
String openingWithdrawal(int available) {
  const suggested = 250000;
  if (available < suggested) {
    return '';
  }
  return groupNaira(suggested);
}

/// Why a withdrawal cannot be sent. Null means the amount is payable.
enum VendorWithdrawalGap { empty, belowMinimum, aboveAvailable }

/// The smallest payout the design allows.
const int minimumWithdrawal = 10000;

/// A blank field, a sum under ₦10,000, or a sum above what can be withdrawn.
VendorWithdrawalGap? withdrawalGap({
  required int? amount,
  required int available,
}) {
  if (amount == null) {
    return VendorWithdrawalGap.empty;
  }
  if (amount < minimumWithdrawal) {
    return VendorWithdrawalGap.belowMinimum;
  }
  if (amount > available) {
    return VendorWithdrawalGap.aboveAvailable;
  }
  return null;
}
