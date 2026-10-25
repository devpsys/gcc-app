import 'package:gcc_app/features/booking/domain/lessee_escrow_hold.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet.dart';
import 'package:gcc_app/features/vendor/domain/vendor_withdrawal_receipt.dart';

/// Lessee ledger (MOB-LSE-14). Shares the vendor wallet shape; labels differ in UI.
abstract class LesseeWalletGateway {
  Future<VendorWallet> load();

  Future<VendorWithdrawalReceipt?> withdraw(int amount);

  List<LesseeEscrowHold> escrowHolds();
}
