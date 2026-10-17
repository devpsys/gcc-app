import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/audit_event.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/bounty_status.dart';

/// One shop submission and its bounty, as the status screen shows it.
class BountySubmission extends Equatable {
  const BountySubmission({
    required this.reference,
    required this.shopName,
    required this.assetSummary,
    required this.location,
    required this.coordinates,
    required this.bountyAmount,
    required this.status,
    required this.timeline,
    this.headline,
    this.bountyNote,
    this.reviewer,
    this.reviewerRejectedAt,
    this.disclaimer,
    this.rejectedAssetCount = 0,
  });

  /// e.g. `SUB-2214`.
  final String reference;
  final String shopName;

  /// e.g. `100kVA · Shopfront · 1.4 MB`.
  final String assetSummary;

  /// e.g. `Kugbo Market · Zone C, Line 4`.
  final String location;

  /// e.g. `9.0580° N, 7.4100° E · ±12 m`.
  final String coordinates;

  /// The bounty on offer, e.g. `₦5,000`. Always shown — this is the screen
  /// where the bounty is the subject.
  final String bountyAmount;
  final BountyStatus status;
  final List<AuditEvent> timeline;

  /// Status line under the shop, e.g. `Reshoot required · Underexposed`.
  final String? headline;

  /// What the bounty line says, e.g. `Approved 13 Oct`.
  final String? bountyNote;

  /// Reviewer name and id, e.g. `Ibrahim Musa · AG-0142`.
  final String? reviewer;
  final String? reviewerRejectedAt;

  /// Long-form note under the bounty, shown when there is one.
  final String? disclaimer;

  /// How many assets were refused, for the reshoot framing.
  final int rejectedAssetCount;

  /// Whether this submission's bounty is held at GCC.
  ///
  /// Read from [status] so a lock can never appear on the wrong frame.
  bool get escrowed => isEscrowed(status);

  @override
  List<Object?> get props => [
    reference,
    shopName,
    assetSummary,
    location,
    coordinates,
    bountyAmount,
    status,
    timeline,
    headline,
    bountyNote,
    reviewer,
    reviewerRejectedAt,
    disclaimer,
    rejectedAssetCount,
  ];
}
