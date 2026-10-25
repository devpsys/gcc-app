import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_detail_phase.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_proof_clip.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_stage_tone.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_timeline_event.dart';

/// Full lessee booking detail for MOB-VND-09.
class LesseeBookingDetail extends Equatable {
  const LesseeBookingDetail({
    required this.id,
    required this.reference,
    required this.title,
    required this.yardLine,
    required this.phase,
    required this.statusChipLabel,
    required this.stageTones,
    required this.timeline,
    required this.walletAvailable,
    required this.heldInEscrow,
    required this.refundedToDate,
    required this.moneySubtitle,
    required this.moneyLinkLabel,
    required this.proofs,
    required this.vendorName,
    required this.vendorInitials,
    required this.vendorYard,
    required this.vendorId,
    this.mark,
    this.walletDelta,
    this.depositReleasedAmount,
  });

  final String id;
  final String reference;
  final String title;
  final String yardLine;
  final LesseeBookingDetailPhase phase;
  final String statusChipLabel;
  final List<LesseeBookingStageTone> stageTones;
  final List<LesseeBookingTimelineEvent> timeline;
  final int walletAvailable;
  final int heldInEscrow;
  final int refundedToDate;
  final String moneySubtitle;
  final String moneyLinkLabel;
  final List<LesseeBookingProofClip> proofs;
  final String vendorName;
  final String vendorInitials;
  final String vendorYard;
  final String vendorId;
  final String? mark;
  final int? walletDelta;
  final int? depositReleasedAmount;

  bool get isReviewPending =>
      phase == LesseeBookingDetailPhase.reviewPending;

  @override
  List<Object?> get props => [
    id,
    reference,
    title,
    yardLine,
    phase,
    statusChipLabel,
    stageTones,
    timeline,
    walletAvailable,
    heldInEscrow,
    refundedToDate,
    moneySubtitle,
    moneyLinkLabel,
    proofs,
    vendorName,
    vendorInitials,
    vendorYard,
    vendorId,
    mark,
    walletDelta,
    depositReleasedAmount,
  ];
}
