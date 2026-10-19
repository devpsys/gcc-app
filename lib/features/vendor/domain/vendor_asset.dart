import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset_status.dart';
import 'package:gcc_app/features/vendor/domain/vendor_booking_hold.dart';
import 'package:gcc_app/features/vendor/domain/vendor_catalog_kind.dart';

/// One machine or bulk listing in the vendor catalog.
class VendorAsset extends Equatable {
  const VendorAsset({
    required this.reference,
    required this.name,
    required this.ratePerDay,
    required this.place,
    required this.specification,
    required this.status,
    required this.kind,
    this.deposit,
    this.mark,
    this.statusLine,
    this.hold,
    this.scheduledNote,
  });

  /// e.g. `AST-0912`.
  final String reference;
  final String name;

  /// Display rate, e.g. `₦35,000`.
  final String ratePerDay;
  final String place;
  final String specification;

  /// Caution deposit GCC is holding, e.g. `₦50,000`.
  final String? deposit;

  /// Short mark on the thumbnail, e.g. `100kVA`.
  final String? mark;

  /// Server line under the spec, such as a return time.
  final String? statusLine;
  final VendorAssetStatus status;
  final VendorCatalogKind kind;
  final VendorBookingHold? hold;

  /// Set when maintenance waits for the active booking to return.
  final String? scheduledNote;

  bool get bookingActive => hold != null;

  VendorAsset copyWith({
    VendorAssetStatus? status,
    String? ratePerDay,
    String? deposit,
    String? scheduledNote,
    bool clearDeposit = false,
    bool clearScheduledNote = false,
  }) {
    return VendorAsset(
      reference: reference,
      name: name,
      ratePerDay: ratePerDay ?? this.ratePerDay,
      place: place,
      specification: specification,
      deposit: clearDeposit ? null : deposit ?? this.deposit,
      mark: mark,
      statusLine: statusLine,
      status: status ?? this.status,
      kind: kind,
      hold: hold,
      scheduledNote: clearScheduledNote
          ? null
          : scheduledNote ?? this.scheduledNote,
    );
  }

  @override
  List<Object?> get props => [
    reference,
    name,
    ratePerDay,
    place,
    specification,
    deposit,
    mark,
    statusLine,
    status,
    kind,
    hold,
    scheduledNote,
  ];
}
