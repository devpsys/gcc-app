import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset_status.dart';
import 'package:gcc_app/features/vendor/domain/vendor_charge_basis.dart';

/// The editable rate card for one catalog asset.
class VendorAssetDraft extends Equatable {
  const VendorAssetDraft({
    required this.reference,
    required this.name,
    required this.place,
    required this.status,
    required this.basis,
    required this.assignOperator,
    this.mark,
    this.dailyRate,
    this.deposit,
    this.operatorFee,
    this.projectRate,
    this.deliveryFee = 0,
    this.deliveryRoute,
    this.savedAt,
    this.photos = const [],
    this.videoWhen,
    this.videoDetail,
  });

  final String reference;
  final String name;
  final String place;
  final String? mark;
  final VendorAssetStatus status;
  final VendorChargeBasis basis;
  final int? dailyRate;
  final int? deposit;
  final bool assignOperator;
  final int? operatorFee;
  final int? projectRate;
  final int deliveryFee;
  final String? deliveryRoute;
  final String? savedAt;
  final List<String> photos;
  final String? videoWhen;
  final String? videoDetail;

  VendorAssetDraft copyWith({
    VendorChargeBasis? basis,
    int? dailyRate,
    int? deposit,
    bool? assignOperator,
    int? operatorFee,
    int? projectRate,
    bool clearDaily = false,
    bool clearDeposit = false,
    bool clearOperator = false,
    bool clearProject = false,
  }) {
    return VendorAssetDraft(
      reference: reference,
      name: name,
      place: place,
      mark: mark,
      status: status,
      basis: basis ?? this.basis,
      dailyRate: clearDaily ? null : dailyRate ?? this.dailyRate,
      deposit: clearDeposit ? null : deposit ?? this.deposit,
      assignOperator: assignOperator ?? this.assignOperator,
      operatorFee: clearOperator ? null : operatorFee ?? this.operatorFee,
      projectRate: clearProject ? null : projectRate ?? this.projectRate,
      deliveryFee: deliveryFee,
      deliveryRoute: deliveryRoute,
      savedAt: savedAt,
      photos: photos,
      videoWhen: videoWhen,
      videoDetail: videoDetail,
    );
  }

  @override
  List<Object?> get props => [
    reference,
    name,
    place,
    mark,
    status,
    basis,
    dailyRate,
    deposit,
    assignOperator,
    operatorFee,
    projectRate,
    deliveryFee,
    deliveryRoute,
    savedAt,
    photos,
    videoWhen,
    videoDetail,
  ];
}
