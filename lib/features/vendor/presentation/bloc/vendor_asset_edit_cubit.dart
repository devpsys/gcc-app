import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/vendor/domain/naira_amount.dart';
import 'package:gcc_app/features/vendor/domain/vendor_charge_basis.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_asset_edit_state.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_asset_edit_gateway.dart';

/// Edits one asset's rate, deposit, and operator fee on this device.
class VendorAssetEditCubit extends Cubit<VendorAssetEditState> {
  VendorAssetEditCubit(this._gateway, this.reference)
    : super(const VendorAssetEditLoading());

  final VendorAssetEditGateway _gateway;
  final String reference;

  Future<void> load() async {
    emit(const VendorAssetEditLoading());
    try {
      final draft = await _gateway.load(reference);
      emit(
        draft == null ? const VendorAssetEditMissing() : readyFromDraft(draft),
      );
    } on Failure catch (failure) {
      emit(VendorAssetEditFailed(failure));
    }
  }

  void selectBasis(VendorChargeBasis basis) {
    final ready = _ready;
    if (ready == null || ready.basis == basis) {
      return;
    }
    emit(ready.copyWith(basis: basis));
  }

  void dailyChanged(String value) =>
      _text((ready) => ready.copyWith(dailyText: value));

  void depositChanged(String value) =>
      _text((ready) => ready.copyWith(depositText: value));

  void projectChanged(String value) =>
      _text((ready) => ready.copyWith(projectText: value));

  void operatorFeeChanged(String value) =>
      _text((ready) => ready.copyWith(operatorText: value));

  void operatorChanged(bool value) {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(ready.copyWith(assignOperator: value));
  }

  void discard() {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    final restored = readyFromDraft(ready.original);
    emit(restored.copyWith(revision: ready.revision + 1));
  }

  void save() {
    final ready = _ready;
    if (ready == null || !ready.gaps.clear) {
      return;
    }
    final operator = parseNairaInput(ready.operatorText);
    emit(
      ready.copyWith(
        original: ready.original.copyWith(
          basis: ready.basis,
          dailyRate: ready.daily,
          deposit: ready.deposit,
          projectRate: ready.project,
          assignOperator: ready.assignOperator,
          operatorFee: operator,
          clearDaily: ready.daily == null,
          clearDeposit: ready.deposit == null,
          clearProject: ready.project == null,
          clearOperator: operator == null,
        ),
      ),
    );
  }

  void _text(VendorAssetEditReady Function(VendorAssetEditReady ready) change) {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(change(ready));
  }

  VendorAssetEditReady? get _ready {
    final current = state;
    return current is VendorAssetEditReady ? current : null;
  }
}
