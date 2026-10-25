import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_wallet_state.dart';
import 'package:gcc_app/features/booking/presentation/gateway/lessee_wallet_gateway.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry_kind.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_period.dart';

/// The lessee ledger on this device (MOB-LSE-14).
class LesseeWalletCubit extends Cubit<LesseeWalletState> {
  LesseeWalletCubit(this._gateway) : super(const LesseeWalletLoading());

  final LesseeWalletGateway _gateway;

  Future<void> load() async {
    emit(const LesseeWalletLoading());
    try {
      emit(
        LesseeWalletReady(
          wallet: await _gateway.load(),
          escrowHolds: _gateway.escrowHolds(),
        ),
      );
    } on Failure catch (failure) {
      emit(LesseeWalletFailed(failure));
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

  LesseeWalletReady? get _ready {
    final current = state;
    return current is LesseeWalletReady ? current : null;
  }
}
