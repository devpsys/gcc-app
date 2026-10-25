import 'package:gcc_app/features/booking/domain/handback_finding.dart';
import 'package:gcc_app/features/booking/domain/handback_issue_reason.dart';
import 'package:gcc_app/features/booking/domain/handback_review.dart';
import 'package:gcc_app/features/booking/domain/handback_settlement.dart';
import 'package:gcc_app/features/booking/presentation/gateway/handback_gateway.dart';

class MockHandbackGateway implements HandbackGateway {
  const MockHandbackGateway();

  static final catalog = <HandbackReview>[
    HandbackReview(
      id: 'bk-24817',
      reference: 'BK-24817',
      title: 'Mika 100kVA Diesel Generator Set',
      yard: 'Kugbo Generator Yard',
      recordedAtLabel: '17 Oct 2026, 16:40',
      durationSeconds: 30,
      deposit: 50000,
      vendorPayout: 99900,
      vendorName: 'Kugbo Generator Yard',
      listingId: 'mika-100',
      findings: const [
        HandbackFinding(
          timeLabel: '00:07',
          note: 'Coolant seep visible under the radiator cap',
        ),
        HandbackFinding(
          timeLabel: '00:19',
          note: 'Alternator pulley has a visible crack',
        ),
        HandbackFinding(
          timeLabel: '00:24',
          note: 'Damage first visible here — matches your photo',
        ),
      ],
    ),
  ];

  @override
  Future<HandbackReview?> load(String bookingId) async {
    for (final review in catalog) {
      if (review.id == bookingId || review.reference == bookingId) {
        return review;
      }
    }
    return null;
  }

  @override
  Future<HandbackSettlement> approve(String bookingId) async {
    final review = await load(bookingId);
    if (review == null) {
      throw StateError('missing handback $bookingId');
    }
    return HandbackSettlement(
      deposit: review.deposit,
      vendorPayout: review.vendorPayout,
      chargedTotal: review.chargedTotal,
      reference: review.reference,
      settledAtLabel: '17 Oct 2026, 22:40',
      vendorName: review.vendorName,
    );
  }

  @override
  Future<void> submitIssue({
    required String bookingId,
    required HandbackIssueReason reason,
    required String note,
    required int photoCount,
    required int claimAmount,
  }) async {}
}
