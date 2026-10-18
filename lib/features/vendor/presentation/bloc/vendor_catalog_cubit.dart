import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/vendor/domain/catalog_status_effect.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset_status.dart';
import 'package:gcc_app/features/vendor/domain/vendor_catalog_kind.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_catalog_state.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_catalog_gateway.dart';

/// Drives the vendor catalog.
///
/// Status changes stay on this device until a catalog API exists. A rented
/// asset opens the booking sheet instead of changing immediately.
class VendorCatalogCubit extends Cubit<VendorCatalogState> {
  VendorCatalogCubit(this._gateway) : super(const VendorCatalogLoading());

  final VendorCatalogGateway _gateway;

  Future<void> load() async {
    emit(const VendorCatalogLoading());
    try {
      final assets = await _gateway.loadAssets();
      final waiting = await _gateway.loadRequestsWaiting();
      emit(VendorCatalogReady(assets: assets, requestsWaiting: waiting));
    } on Failure catch (failure) {
      emit(VendorCatalogFailed(failure));
    }
  }

  void selectKind(VendorCatalogKind kind) {
    final ready = _ready;
    if (ready == null || ready.kind == kind) {
      return;
    }
    emit(ready.copyWith(kind: kind, clearFilter: true));
  }

  void selectFilter(VendorAssetStatus? status) {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(
      status == null
          ? ready.copyWith(clearFilter: true)
          : ready.copyWith(filter: status),
    );
  }

  void requestStatus(String reference, VendorAssetStatus next) {
    final ready = _ready;
    final asset = ready?.assetBy(reference);
    if (ready == null || asset == null) {
      return;
    }
    switch (catalogStatusEffect(
      current: asset.status,
      next: next,
      bookingActive: asset.bookingActive,
    )) {
      case CatalogStatusEffect.ignored:
        return;
      case CatalogStatusEffect.blocked:
        emit(ready.copyWith(blockedReference: reference));
      case CatalogStatusEffect.apply:
        _replace(ready, asset, next, rememberUndo: true);
    }
  }

  void scheduleAfterReturn() {
    final ready = _ready;
    final asset = ready?.assetBy(ready.blockedReference);
    final when = asset?.hold?.resumesAt;
    if (ready == null || asset == null || when == null) {
      return;
    }
    emit(
      ready.copyWith(
        assets: _mapped(
          ready.assets,
          asset.reference,
          asset.copyWith(scheduledNote: when),
        ),
        clearBlocked: true,
      ),
    );
  }

  void applyBlockedNow() {
    final ready = _ready;
    final asset = ready?.assetBy(ready.blockedReference);
    if (ready == null || asset == null) {
      return;
    }
    _replace(
      ready.copyWith(clearBlocked: true),
      asset,
      VendorAssetStatus.maintenance,
      rememberUndo: true,
    );
  }

  void dismissBlock() {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(ready.copyWith(clearBlocked: true));
  }

  void undo() {
    final ready = _ready;
    final reference = ready?.undoReference;
    final previous = ready?.undoStatus;
    final asset = ready?.assetBy(reference);
    if (ready == null || asset == null || previous == null) {
      return;
    }
    emit(
      ready.copyWith(
        assets: _mapped(
          ready.assets,
          asset.reference,
          asset.copyWith(status: previous, clearScheduledNote: true),
        ),
        clearUndo: true,
      ),
    );
  }

  void _replace(
    VendorCatalogReady ready,
    VendorAsset asset,
    VendorAssetStatus next, {
    required bool rememberUndo,
  }) {
    emit(
      ready.copyWith(
        assets: _mapped(
          ready.assets,
          asset.reference,
          asset.copyWith(status: next, clearScheduledNote: true),
        ),
        undoReference: rememberUndo ? asset.reference : null,
        undoStatus: rememberUndo ? asset.status : null,
        clearUndo: !rememberUndo,
      ),
    );
  }

  List<VendorAsset> _mapped(
    List<VendorAsset> assets,
    String reference,
    VendorAsset next,
  ) {
    return [
      for (final asset in assets)
        if (asset.reference == reference) next else asset,
    ];
  }

  VendorCatalogReady? get _ready {
    final current = state;
    return current is VendorCatalogReady ? current : null;
  }
}
