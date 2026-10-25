import 'package:gcc_app/features/booking/domain/lessee_booking_detail.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_detail_phase.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_proof_clip.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_stage_tone.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_timeline_event.dart';
import 'package:gcc_app/features/booking/presentation/gateway/lessee_booking_detail_gateway.dart';

class MockLesseeBookingDetailGateway implements LesseeBookingDetailGateway {
  const MockLesseeBookingDetailGateway();

  static final catalog = <LesseeBookingDetail>[
    LesseeBookingDetail(
      id: 'bk-24817',
      reference: 'BK-24817',
      title: 'Mika 100kVA Diesel Generator Set',
      yardLine: 'Kugbo Generator Yard · Kugbo Market',
      phase: LesseeBookingDetailPhase.reviewPending,
      statusChipLabel: 'Return condition recorded',
      mark: 'MIKA 100',
      stageTones: const [
        LesseeBookingStageTone.complete,
        LesseeBookingStageTone.complete,
        LesseeBookingStageTone.active,
      ],
      timeline: const [
        LesseeBookingTimelineEvent(
          timeLabel: '14 Oct 07:58',
          title: 'Booking requested',
          tone: LesseeBookingStageTone.complete,
        ),
        LesseeBookingTimelineEvent(
          timeLabel: '14 Oct 08:02',
          title: 'Payment received',
          tone: LesseeBookingStageTone.complete,
          detail: '₦164,075 split across 5 accounts',
        ),
        LesseeBookingTimelineEvent(
          timeLabel: '14 Oct 08:15',
          title: 'Equipment dispatched',
          tone: LesseeBookingStageTone.complete,
          detail: 'Condition video recorded at yard',
        ),
        LesseeBookingTimelineEvent(
          timeLabel: '17 Oct 16:40',
          title: 'Return condition recorded',
          tone: LesseeBookingStageTone.active,
          detail: 'Review needed before deposit unlock',
          detailHighlight: true,
        ),
        LesseeBookingTimelineEvent(
          timeLabel: 'Pending',
          title: 'Deposit release',
          tone: LesseeBookingStageTone.pending,
          detail: 'You approve the condition → deposit released',
        ),
      ],
      walletAvailable: 12000,
      heldInEscrow: 164075,
      refundedToDate: 0,
      moneySubtitle: 'Funds release as the rental completes.',
      moneyLinkLabel: 'View payment breakdown',
      proofs: const [
        LesseeBookingProofClip(
          title: 'Check-out · 14 Oct 2026, 08:15',
          subtitle: 'Recorded at the yard · within 120 m of Kugbo Market',
          durationLabel: '00:30',
        ),
        LesseeBookingProofClip(
          title: 'Check-in · 17 Oct 2026, 16:40',
          subtitle: 'Recorded at the yard · within 95 m of Kugbo Market',
          durationLabel: '00:30',
        ),
      ],
      vendorName: 'Alhaji Musa Ibrahim',
      vendorInitials: 'AI',
      vendorYard: 'Kugbo Generator Yard',
      vendorId: 'VND-0341',
    ),
    LesseeBookingDetail(
      id: 'bk-24744',
      reference: 'BK-24744',
      title: '5kW PA Sound System',
      yardLine: 'Deepwell Sound Rentals · Wuse Zone 5',
      phase: LesseeBookingDetailPhase.completed,
      statusChipLabel: 'Completed',
      stageTones: const [
        LesseeBookingStageTone.complete,
        LesseeBookingStageTone.complete,
        LesseeBookingStageTone.complete,
      ],
      timeline: const [
        LesseeBookingTimelineEvent(
          timeLabel: '10 Oct 09:10',
          title: 'Booking requested',
          tone: LesseeBookingStageTone.complete,
        ),
        LesseeBookingTimelineEvent(
          timeLabel: '10 Oct 09:18',
          title: 'Payment received',
          tone: LesseeBookingStageTone.complete,
          detail: '₦42,000 split across 5 accounts',
        ),
        LesseeBookingTimelineEvent(
          timeLabel: '10 Oct 10:00',
          title: 'Equipment dispatched',
          tone: LesseeBookingStageTone.complete,
          detail: 'Condition video recorded at yard',
        ),
        LesseeBookingTimelineEvent(
          timeLabel: '12 Oct 18:00',
          title: 'Return condition recorded',
          tone: LesseeBookingStageTone.complete,
          detail: 'Check-in inspection video uploaded',
        ),
        LesseeBookingTimelineEvent(
          timeLabel: '12 Oct 18:20',
          title: 'Condition approved · deposit released',
          tone: LesseeBookingStageTone.complete,
          detail: '₦15,000 caution deposit credited to wallet',
        ),
      ],
      walletAvailable: 62000,
      heldInEscrow: 0,
      refundedToDate: 15000,
      walletDelta: 15000,
      depositReleasedAmount: 15000,
      moneySubtitle: 'All rental escrow releases are finalized.',
      moneyLinkLabel: 'View settlement receipt',
      proofs: const [
        LesseeBookingProofClip(
          title: 'Check-out · 10 Oct 2026, 10:00',
          subtitle: 'Recorded at the yard · within 80 m of Wuse Zone 5',
          durationLabel: '00:30',
        ),
        LesseeBookingProofClip(
          title: 'Check-in · 12 Oct 2026, 18:00',
          subtitle: 'Recorded at the yard · within 70 m of Wuse Zone 5',
          durationLabel: '00:30',
        ),
      ],
      vendorName: 'Deepwell Sound',
      vendorInitials: 'DS',
      vendorYard: 'Deepwell Sound Rentals',
      vendorId: 'VND-0198',
    ),
    LesseeBookingDetail(
      id: 'bk-24804',
      reference: 'BK-24804',
      title: '60kVA Diesel Generator Set',
      yardLine: 'Wuse Event & Power · Wuse Zone 2',
      phase: LesseeBookingDetailPhase.reviewPending,
      statusChipLabel: 'In use',
      mark: '60kVA',
      stageTones: const [
        LesseeBookingStageTone.complete,
        LesseeBookingStageTone.active,
        LesseeBookingStageTone.pending,
      ],
      timeline: const [
        LesseeBookingTimelineEvent(
          timeLabel: '14 Oct 07:10',
          title: 'Booking requested',
          tone: LesseeBookingStageTone.complete,
        ),
        LesseeBookingTimelineEvent(
          timeLabel: '14 Oct 07:15',
          title: 'Payment received',
          tone: LesseeBookingStageTone.complete,
          detail: '₦96,500 split across 5 accounts',
        ),
        LesseeBookingTimelineEvent(
          timeLabel: '14 Oct 07:40',
          title: 'Equipment dispatched',
          tone: LesseeBookingStageTone.active,
          detail: 'Return due 17 Oct, 09:00',
        ),
        LesseeBookingTimelineEvent(
          timeLabel: 'Pending',
          title: 'Return condition recorded',
          tone: LesseeBookingStageTone.pending,
        ),
        LesseeBookingTimelineEvent(
          timeLabel: 'Pending',
          title: 'Deposit release',
          tone: LesseeBookingStageTone.pending,
        ),
      ],
      walletAvailable: 12000,
      heldInEscrow: 96500,
      refundedToDate: 0,
      moneySubtitle: 'Funds release as the rental completes.',
      moneyLinkLabel: 'View payment breakdown',
      proofs: const [
        LesseeBookingProofClip(
          title: 'Check-out · 14 Oct 2026, 07:40',
          subtitle: 'Recorded at the yard · within 110 m of Wuse Zone 2',
          durationLabel: '00:30',
        ),
      ],
      vendorName: 'Wuse Event & Power',
      vendorInitials: 'WE',
      vendorYard: 'Wuse Event & Power',
      vendorId: 'VND-0288',
    ),
  ];

  @override
  Future<LesseeBookingDetail?> load(String id) async {
    for (final detail in catalog) {
      if (detail.id == id) {
        return detail;
      }
    }
    return null;
  }
}
