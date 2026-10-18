import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/vendor/domain/vendor_decline_reason.dart';
import 'package:gcc_app/features/vendor/domain/vendor_request_audit.dart';
import 'package:gcc_app/features/vendor/domain/vendor_request_stage.dart';

/// The inbound booking from MOB-VND-11.
class VendorBookingRequest extends Equatable {
  const VendorBookingRequest({
    required this.reference,
    required this.assetReference,
    required this.assetName,
    required this.mark,
    required this.fuel,
    required this.lessee,
    required this.lesseeInitials,
    required this.phone,
    required this.dates,
    required this.duration,
    required this.rentalDetail,
    required this.rentalFee,
    required this.deliveryDetail,
    required this.deliveryFee,
    required this.netEarning,
    required this.deposit,
    required this.expiresIn,
    required this.expiryProgress,
    required this.receivedAt,
    required this.collectionWindow,
    required this.collectionPlace,
    required this.stage,
    this.acceptedBySms = false,
    this.acceptedAt,
    this.declineReason,
    this.declineNote,
    this.audit = const [],
  });

  final String reference;
  final String assetReference;
  final String assetName;
  final String mark;
  final String fuel;
  final String lessee;
  final String lesseeInitials;
  final String phone;
  final String dates;
  final String duration;
  final String rentalDetail;
  final String rentalFee;
  final String deliveryDetail;
  final String deliveryFee;
  final String netEarning;
  final String deposit;
  final String expiresIn;
  final double expiryProgress;
  final String receivedAt;
  final String collectionWindow;
  final String collectionPlace;
  final VendorRequestStage stage;
  final bool acceptedBySms;
  final String? acceptedAt;
  final VendorDeclineReason? declineReason;
  final String? declineNote;
  final List<VendorRequestAudit> audit;

  VendorBookingRequest copyWith({
    VendorRequestStage? stage,
    bool? acceptedBySms,
    String? acceptedAt,
    VendorDeclineReason? declineReason,
    String? declineNote,
  }) {
    return VendorBookingRequest(
      reference: reference,
      assetReference: assetReference,
      assetName: assetName,
      mark: mark,
      fuel: fuel,
      lessee: lessee,
      lesseeInitials: lesseeInitials,
      phone: phone,
      dates: dates,
      duration: duration,
      rentalDetail: rentalDetail,
      rentalFee: rentalFee,
      deliveryDetail: deliveryDetail,
      deliveryFee: deliveryFee,
      netEarning: netEarning,
      deposit: deposit,
      expiresIn: expiresIn,
      expiryProgress: expiryProgress,
      receivedAt: receivedAt,
      collectionWindow: collectionWindow,
      collectionPlace: collectionPlace,
      stage: stage ?? this.stage,
      acceptedBySms: acceptedBySms ?? this.acceptedBySms,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      declineReason: declineReason ?? this.declineReason,
      declineNote: declineNote ?? this.declineNote,
      audit: audit,
    );
  }

  @override
  List<Object?> get props => [
    reference,
    assetReference,
    assetName,
    mark,
    fuel,
    lessee,
    lesseeInitials,
    phone,
    dates,
    duration,
    rentalDetail,
    rentalFee,
    deliveryDetail,
    deliveryFee,
    netEarning,
    deposit,
    expiresIn,
    expiryProgress,
    receivedAt,
    collectionWindow,
    collectionPlace,
    stage,
    acceptedBySms,
    acceptedAt,
    declineReason,
    declineNote,
    audit,
  ];
}
