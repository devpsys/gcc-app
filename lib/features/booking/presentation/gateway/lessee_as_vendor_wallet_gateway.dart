import 'package:gcc_app/features/booking/presentation/gateway/lessee_wallet_gateway.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet.dart';
import 'package:gcc_app/features/vendor/domain/vendor_withdrawal_receipt.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_wallet_gateway.dart';

/// Adapts the lessee ledger so withdraw UI can reuse [VendorWithdrawCubit].
final class LesseeAsVendorWalletGateway implements VendorWalletGateway {
  const LesseeAsVendorWalletGateway(this._inner);

  final LesseeWalletGateway _inner;

  @override
  Future<VendorWallet> load() => _inner.load();

  @override
  Future<VendorWithdrawalReceipt?> withdraw(int amount) =>
      _inner.withdraw(amount);
}
