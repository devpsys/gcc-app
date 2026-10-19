import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/vendor/domain/naira_amount.dart';
import 'package:gcc_app/features/vendor/domain/vendor_withdrawal_gap.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_withdraw_state.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_wallet_gateway.dart';

/// Sends one payout from the available balance.
class VendorWithdrawCubit extends Cubit<VendorWithdrawState> {
  VendorWithdrawCubit(this._gateway) : super(const VendorWithdrawLoading());

  final VendorWalletGateway _gateway;

  Future<void> load() async {
    emit(const VendorWithdrawLoading());
    try {
      final wallet = await _gateway.load();
      emit(
        VendorWithdrawReady(
          wallet: wallet,
          amountText: openingWithdrawal(wallet.availableAmount),
        ),
      );
    } on Failure catch (failure) {
      emit(VendorWithdrawFailed(failure));
    }
  }

  void amountChanged(String value) => _text(value);

  void choose(int amount) {
    final ready = _ready;
    if (ready == null || ready.receipt != null) {
      return;
    }
    emit(
      ready.copyWith(
        amountText: groupNaira(amount),
        revision: ready.revision + 1,
      ),
    );
  }

  Future<void> submit() async {
    final ready = _ready;
    final amount = ready?.amount;
    if (ready == null || ready.gap != null || amount == null) {
      return;
    }
    final receipt = await _gateway.withdraw(amount);
    if (receipt == null || isClosed) {
      return;
    }
    emit(ready.copyWith(wallet: await _gateway.load(), receipt: receipt));
  }

  void _text(String value) {
    final ready = _ready;
    if (ready == null || ready.receipt != null) {
      return;
    }
    emit(ready.copyWith(amountText: value));
  }

  VendorWithdrawReady? get _ready {
    final current = state;
    return current is VendorWithdrawReady ? current : null;
  }
}
