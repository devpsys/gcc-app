import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_availability.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_category.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_condition_grade.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_draft.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_draft.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_state.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/shop_category.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/shop_type.dart';
import 'package:gcc_app/features/agent_capture/presentation/gateway/capture_gateway.dart';

class CaptureCubit extends Cubit<CaptureState> {
  CaptureCubit(this._gateway, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now,
      super(const CaptureDrafting());

  final CaptureGateway _gateway;
  final DateTime Function() _clock;

  void editShopName(String value) => _edit(draft.copyWith(shopName: value));

  void editOwnerName(String value) => _edit(draft.copyWith(ownerName: value));

  void editPhone(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    final phone = digits.length > CaptureDraft.phoneLength
        ? digits.substring(0, CaptureDraft.phoneLength)
        : digits;
    _edit(draft.copyWith(phone: phone));
  }

  void selectShopType(ShopType value) => _edit(draft.copyWith(shopType: value));

  void setWhatsAppSameAsPhone({required bool same}) {
    _edit(draft.copyWith(whatsAppSameAsPhone: same));
  }

  void editWhatsApp(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    final phone = digits.length > CaptureDraft.phoneLength
        ? digits.substring(0, CaptureDraft.phoneLength)
        : digits;
    _edit(draft.copyWith(whatsApp: phone));
  }

  void toggleCategory(ShopCategory category) {
    final next = [...draft.categories];
    if (next.contains(category)) {
      next.remove(category);
    } else {
      next.add(category);
    }
    _edit(draft.copyWith(categories: next));
  }

  void editMarket(String value) {
    if (value == draft.market) {
      return;
    }
    _edit(draft.copyWith(market: value, zone: '', line: ''));
  }

  void editZone(String value) {
    if (value == draft.zone) {
      return;
    }
    _edit(draft.copyWith(zone: value, line: ''));
  }

  void editLine(String value) => _edit(draft.copyWith(line: value));

  void editLandmark(String value) => _edit(draft.copyWith(landmark: value));

  void rememberDraft() => _edit(draft);

  void selectAssetCategory(AssetCategory value) =>
      _edit(draft.copyWith(asset: draft.asset.copyWith(category: value)));

  void editAssetMake(String value) =>
      _edit(draft.copyWith(asset: draft.asset.copyWith(make: value)));

  void editAssetCapacity(String value) =>
      _edit(draft.copyWith(asset: draft.asset.copyWith(capacity: value)));

  void editAssetModel(String value) =>
      _edit(draft.copyWith(asset: draft.asset.copyWith(model: value)));

  void editAssetYear(String value) =>
      _edit(draft.copyWith(asset: draft.asset.copyWith(year: value)));

  void editAssetSerial(String value) =>
      _edit(draft.copyWith(asset: draft.asset.copyWith(serial: value)));

  void selectAssetCondition(AssetConditionGrade value) =>
      _edit(draft.copyWith(asset: draft.asset.copyWith(condition: value)));

  void selectAssetAvailability(AssetAvailability value) =>
      _edit(draft.copyWith(asset: draft.asset.copyWith(availability: value)));

  /// Quantity never drops below one — the design's stepper shows a minus and
  /// a plus, but an asset with a quantity of zero is not a capture.
  void changeAssetQuantity(int delta) {
    final next = draft.asset.quantity + delta;
    if (next < 1) {
      return;
    }
    _edit(draft.copyWith(asset: draft.asset.copyWith(quantity: next)));
  }

  /// Opens the asset form from the step's empty state.
  void startAssetForm() => _edit(
    draft.copyWith(
      showAssetForm: true,
      assetAttempted: false,
      // The first asset takes the first reference.
      asset: draft.asset.ordinal == 0
          ? draft.asset.copyWith(ordinal: draft.assets.length + 1)
          : draft.asset,
    ),
  );

  /// Appends the in-progress asset and opens a blank one, so a second asset
  /// starts below the first exactly as the design's second frame shows.
  ///
  /// Returns false and flags [CaptureDraft.assetAttempted] when the asset is
  /// incomplete, which is what reveals the field errors.
  bool addAsset() {
    if (!draft.asset.isComplete) {
      _edit(draft.copyWith(assetAttempted: true));
      return false;
    }
    final appended = draft.asset.copyWith(ordinal: draft.assets.length + 1);
    _edit(
      draft.copyWith(
        assets: [...draft.assets, appended],
        // The next asset claims the following reference straight away, so the
        // in-progress row is numbered before it is appended.
        asset: AssetDraft(ordinal: draft.assets.length + 2),
        showAssetForm: true,
        assetAttempted: false,
      ),
    );
    return true;
  }

  /// Removes an appended asset. The in-progress asset is not in [assets] and
  /// cannot be removed from here — the design states that removing asset 2
  /// leaves asset 1 unchanged, so ordering is preserved rather than renumbered.
  void removeAssetAt(int index) {
    if (index < 0 || index >= draft.assets.length) {
      return;
    }
    final next = [...draft.assets]..removeAt(index);
    _edit(draft.copyWith(assets: next));
  }

  bool attemptShopContinue() {
    final current = state;
    if (current is! CaptureDrafting) {
      return false;
    }
    if (!current.draft.shopIsValid) {
      emit(CaptureDrafting(current.draft.copyWith(shopAttempted: true)));
      return false;
    }
    return true;
  }

  Future<void> submit() async {
    if (state is CaptureSubmitting || state is CaptureSubmitted) {
      return;
    }
    final current = draft;
    emit(CaptureSubmitting(current));
    try {
      await _gateway.submitDraft(current);
      emit(CaptureSubmitted(current));
    } on Failure catch (failure) {
      emit(CaptureFailed(current, failure));
    }
  }

  CaptureDraft get draft => state.draft;

  void _edit(CaptureDraft next) {
    if (state is! CaptureDrafting) {
      return;
    }
    emit(CaptureDrafting(next.copyWith(savedAt: _clock())));
  }
}
