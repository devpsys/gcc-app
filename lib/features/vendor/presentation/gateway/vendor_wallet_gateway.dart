import 'package:gcc_app/features/vendor/domain/vendor_wallet.dart';

/// The vendor's ledger until a wallet API exists.
abstract interface class VendorWalletGateway {
  Future<VendorWallet> load();
}
