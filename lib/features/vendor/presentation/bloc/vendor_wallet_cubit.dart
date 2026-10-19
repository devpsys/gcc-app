import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry_kind.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_period.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_wallet_state.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_wallet_gateway.dart';

/// The vendor ledger on this device.
class VendorWalletCubit extends Cubit<VendorWalletState> {
  VendorWalletCubit(this._gateway) : super(const VendorWalletLoading());

  final VendorWalletGateway _gateway;

  Future<void> load() async {
    emit(const VendorWalletLoading());
    try {
      emit(VendorWalletReady(wallet: await _gateway.load()));
    } on Failure catch (failure) {
      emit(VendorWalletFailed(failure));
    }
  }

  void apply(VendorWallet wallet) {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(ready.copyWith(wallet: wallet));
  }

  void selectPeriod(VendorWalletPeriod period) {
    final ready = _ready;
    if (ready == null || ready.period == period) {
      return;
    }
    emit(ready.copyWith(period: period));
  }

  /// Sends the failed payout again. The balance stays put: the money never left.
  void retryPayout() {
    final ready = _ready;
    final wallet = ready?.wallet;
    if (ready == null || wallet == null || wallet.failure == null) {
      return;
    }
    emit(
      ready.copyWith(
        wallet: wallet.copyWith(
          clearFailure: true,
          entries: [
            for (final entry in wallet.entries)
              if (entry.kind == VendorWalletEntryKind.payoutFailed)
                entry.asSent()
              else
                entry,
          ],
        ),
      ),
    );
  }

  VendorWalletReady? get _ready {
    final current = state;
    return current is VendorWalletReady ? current : null;
  }
}
