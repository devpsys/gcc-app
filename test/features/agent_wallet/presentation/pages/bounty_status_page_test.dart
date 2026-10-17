import '../../../../helpers/pump_app.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/audit_event.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/audit_event_state.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/bounty_status.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/bounty_submission.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/bounty_status_page.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/audit_timeline.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/bounty_amount_panel.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/rejection_recovery_panel.dart';

void main() {
  BountySubmission build(BountyStatus status) => BountySubmission(
    reference: 'SUB-2214',
    shopName: 'Bola Hardware',
    assetSummary: '100kVA · Shopfront · 1.4 MB',
    location: 'Kugbo Market · Zone C, Line 4',
    coordinates: '9.0580° N, 7.4100° E · ±12 m',
    bountyAmount: '₦5,000',
    status: status,
    headline: switch (status) {
      BountyStatus.awaitingVerification => 'Pending verification',
      BountyStatus.verified => 'Verified',
      BountyStatus.rejected => 'Reshoot required · Underexposed',
    },
    bountyNote: switch (status) {
      BountyStatus.awaitingVerification => 'Pending',
      BountyStatus.verified => 'Approved 13 Oct',
      BountyStatus.rejected => 'Not payable',
    },
    reviewer: 'Ibrahim Musa · AG-0142',
    reviewerRejectedAt: '13 Oct, 14:15',
    timeline: const [
      AuditEvent(
        label: 'Submitted',
        detail: 'Queued and uploaded',
        state: AuditEventState.done,
        at: '13 Oct, 10:42',
      ),
      AuditEvent(
        label: 'Under review',
        detail: 'Amaka Obi opened it',
        state: AuditEventState.done,
        at: '13 Oct, 11:04',
      ),
      AuditEvent(
        label: 'Paid',
        detail: 'Next run, Mon 12 Oct',
        state: AuditEventState.pending,
        at: '',
      ),
    ],
  );

  Future<void> pump(WidgetTester tester, BountyStatus status) => pumpLocalized(
    tester,
    size: const Size(360, 800),
    child: BountyStatusPage(submission: build(status)),
  );

  testWidgets('AGT-16 awaiting frame locks the bounty as held funds', (
    tester,
  ) async {
    await pump(tester, BountyStatus.awaitingVerification);

    expect(find.text('SUB-2214'), findsOneWidget);
    expect(find.text('BOLA HARDWARE'), findsOneWidget);
    expect(find.text('Pending verification'), findsWidgets);
    expect(find.text('₦5,000'), findsOneWidget);
    expect(find.text('Pending'), findsWidgets);

    // The designs permit exactly one lock in the app: money GCC is holding.
    expect(find.byIcon(Icons.lock), findsOneWidget);
  });

  testWidgets('AGT-16 verified frame has no lock', (tester) async {
    await pump(tester, BountyStatus.verified);

    expect(find.text('Verified'), findsWidgets);
    expect(find.text('Approved 13 Oct'), findsOneWidget);
    expect(find.text('₦5,000'), findsOneWidget);

    // Verified money has moved to the payout run. It is no longer held.
    expect(find.byIcon(Icons.lock), findsNothing);
    expect(find.byIcon(Icons.lock_outline), findsNothing);
  });

  /// Scrolls the page until [text] is built and fully on screen.
  Future<void> reveal(WidgetTester tester, String text) async {
    final target = find.text(text);
    for (var i = 0; i < 8 && target.evaluate().isEmpty; i++) {
      await tester.drag(find.byType(ListView), const Offset(0, -280));
      await tester.pumpAndSettle();
    }
    await tester.ensureVisible(target);
    await tester.pumpAndSettle();
  }

  testWidgets('AGT-16 rejected frame forfeits rather than holds', (
    tester,
  ) async {
    await pump(tester, BountyStatus.rejected);

    expect(find.text('Rejected'), findsWidgets);
    expect(find.text('Not payable'), findsOneWidget);
    await reveal(tester, 'Reshoot & resubmit');
    expect(
      find.textContaining('Resubmitting creates a new submission (SUB-2231)'),
      findsOneWidget,
    );
    expect(find.text('Reshoot & resubmit'), findsOneWidget);
    expect(find.text('Discard submission'), findsOneWidget);

    // Forfeited is not held. No lock, and the escrow hatch must not show.
    expect(find.byIcon(Icons.lock), findsNothing);
    expect(find.byType(RejectionRecoveryPanel), findsOneWidget);
  });

  testWidgets('AGT-16 escrow is derived from status, never passed in', (
    tester,
  ) async {
    // The model, not the widget, decides. That is what stops a lock leaking
    // onto a frame where the designs forbid it.
    expect(build(BountyStatus.awaitingVerification).escrowed, isTrue);
    expect(build(BountyStatus.verified).escrowed, isFalse);
    expect(build(BountyStatus.rejected).escrowed, isFalse);

    expect(isEscrowed(BountyStatus.awaitingVerification), isTrue);
    expect(isEscrowed(BountyStatus.verified), isFalse);
    expect(isEscrowed(BountyStatus.rejected), isFalse);
  });

  testWidgets('AGT-16 panel alone locks only when awaiting', (tester) async {
    for (final (status, expectsLock) in [
      (BountyStatus.awaitingVerification, true),
      (BountyStatus.verified, false),
      (BountyStatus.rejected, false),
    ]) {
      await pumpLocalized(
        tester,
        size: const Size(360, 800),
        child: BountyAmountPanel(status: status, amount: '₦5,000'),
      );
      expect(
        find.byIcon(Icons.lock),
        expectsLock ? findsOneWidget : findsNothing,
        reason: 'lock presence for $status',
      );
    }
  });

  testWidgets('AGT-16 timeline keeps not-yet steps visible', (tester) async {
    await pump(tester, BountyStatus.awaitingVerification);

    expect(find.byType(AuditTimeline), findsOneWidget);
    expect(find.text('Audit timeline'.toUpperCase()), findsOneWidget);
    // A pending step is still listed: an agent chasing a delay needs to see
    // what is still outstanding.
    expect(find.text('Paid'), findsOneWidget);
    expect(find.text('Next run, Mon 12 Oct'), findsOneWidget);
  });

  testWidgets('AGT-16 rejected timeline shows forfeiture, not a pending paid', (
    tester,
  ) async {
    final submission = build(BountyStatus.rejected);
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BountyStatusPage(
        submission: BountySubmission(
          reference: submission.reference,
          shopName: submission.shopName,
          assetSummary: submission.assetSummary,
          location: submission.location,
          coordinates: submission.coordinates,
          bountyAmount: submission.bountyAmount,
          status: submission.status,
          timeline: const [
            AuditEvent(
              label: 'Rejected',
              detail: 'Media quality insufficient',
              state: AuditEventState.rejected,
              at: '13 Oct, 14:15',
            ),
            AuditEvent(
              label: 'Paid',
              detail: 'Not applicable',
              state: AuditEventState.notApplicable,
              at: '',
            ),
          ],
        ),
      ),
    );

    expect(find.text('Media quality insufficient'), findsOneWidget);
    expect(find.text('Not applicable'), findsOneWidget);
    expect(find.text('Bounty forfeited'), findsNothing);
  });

  testWidgets('AGT-16 non-rejected frames offer the queue, not a reshoot', (
    tester,
  ) async {
    await pump(tester, BountyStatus.verified);

    await reveal(tester, 'View submission');
    expect(find.text('View submission'), findsOneWidget);
    expect(find.text('View in queue'), findsOneWidget);
    expect(find.text('Reshoot & resubmit'), findsNothing);
  });
}
