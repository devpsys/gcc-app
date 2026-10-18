import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/vendor/domain/naira_amount.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset_draft.dart';
import 'package:gcc_app/features/vendor/domain/vendor_charge_basis.dart';
import 'package:gcc_app/features/vendor/domain/vendor_rate_gaps.dart';
import 'package:gcc_app/features/vendor/domain/vendor_rate_quote.dart';

sealed class VendorAssetEditState extends Equatable {
  const VendorAssetEditState();
}

final class VendorAssetEditLoading extends VendorAssetEditState {
  const VendorAssetEditLoading();

  @override
  List<Object?> get props => const [];
}

final class VendorAssetEditMissing extends VendorAssetEditState {
  const VendorAssetEditMissing();

  @override
  List<Object?> get props => const [];
}

final class VendorAssetEditReady extends VendorAssetEditState {
  const VendorAssetEditReady({
    required this.original,
    required this.basis,
    required this.dailyText,
    required this.depositText,
    required this.projectText,
    required this.assignOperator,
    required this.operatorText,
    required this.revision,
  });

  final VendorAssetDraft original;
  final VendorChargeBasis basis;
  final String dailyText;
  final String depositText;
  final String projectText;
  final bool assignOperator;
  final String operatorText;

  /// Bumped when Discard restores the fields, so the inputs reset.
  final int revision;

  int? get daily => parseNairaInput(dailyText);

  int? get deposit => parseNairaInput(depositText);

  int? get project => parseNairaInput(projectText);

  VendorRateGaps get gaps => vendorRateGaps(
    basis: basis,
    daily: daily,
    project: project,
    deposit: deposit,
  );

  VendorRateQuote? get quote => vendorRateQuote(
    basis: basis,
    daily: daily,
    project: project,
    deposit: deposit,
    delivery: original.deliveryFee,
    deliveryRoute: original.deliveryRoute,
  );

  bool get dirty =>
      basis != original.basis ||
      daily != original.dailyRate ||
      deposit != original.deposit ||
      project != original.projectRate ||
      assignOperator != original.assignOperator ||
      (assignOperator && parseNairaInput(operatorText) != original.operatorFee);

  VendorAssetEditReady copyWith({
    VendorAssetDraft? original,
    VendorChargeBasis? basis,
    String? dailyText,
    String? depositText,
    String? projectText,
    bool? assignOperator,
    String? operatorText,
    int? revision,
  }) {
    return VendorAssetEditReady(
      original: original ?? this.original,
      basis: basis ?? this.basis,
      dailyText: dailyText ?? this.dailyText,
      depositText: depositText ?? this.depositText,
      projectText: projectText ?? this.projectText,
      assignOperator: assignOperator ?? this.assignOperator,
      operatorText: operatorText ?? this.operatorText,
      revision: revision ?? this.revision,
    );
  }

  @override
  List<Object?> get props => [
    original,
    basis,
    dailyText,
    depositText,
    projectText,
    assignOperator,
    operatorText,
    revision,
  ];
}

final class VendorAssetEditFailed extends VendorAssetEditState {
  const VendorAssetEditFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

VendorAssetEditReady readyFromDraft(VendorAssetDraft draft) {
  return VendorAssetEditReady(
    original: draft,
    basis: draft.basis,
    dailyText: draft.dailyRate == null ? '' : groupNaira(draft.dailyRate!),
    depositText: draft.deposit == null ? '' : groupNaira(draft.deposit!),
    projectText: draft.projectRate == null
        ? ''
        : groupNaira(draft.projectRate!),
    assignOperator: draft.assignOperator,
    operatorText: draft.operatorFee == null
        ? ''
        : groupNaira(draft.operatorFee!),
    revision: 0,
  );
}
