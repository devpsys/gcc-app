import 'package:gcc_app/features/vendor/domain/vendor_wallet.dart';
import 'package:gcc_app/features/vendor/domain/vendor_withdrawal_receipt.dart';

/// The vendor's ledger until a wallet API exists.
abstract interface class VendorWalletGateway {
  Future<VendorWallet> load();

  /// Debits [amount] from the available balance and returns the receipt.
  ///
  /// Null when the amount is not payable. Held deposits are left alone.
  Future<VendorWithdrawalReceipt?> withdraw(int amount);
}
