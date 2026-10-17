import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/capture_review_page.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/submission_queued_page.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/bounty_expectation_panel.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/offline_submit_banner.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/review_section.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/submission_detail_list.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/what_happens_next.dart';

import '../../../../helpers/pump_app.dart';
import '../../fake_capture_gateway.dart';

void main() {
  Future<CaptureCubit> pumpReview(
    WidgetTester tester, {
    bool offline = false,
    bool withLandmark = true,
  }) async {
    final cubit = CaptureCubit(FakeCaptureGateway());
    if (withLandmark) {
      cubit.editLandmark('beside Bola Hardware, near the main gate');
    }
    cubit
      ..editShopName('Bola Hardware')
      ..editOwnerName('Alhaji Musa Ibrahim')
      ..editPhone('8034412290');
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(
        value: cubit,
        child: CaptureReviewPage(offline: offline),
      ),
    );
    return cubit;
  }

  /// The review body scrolls, so later sections only build once dragged in.
  Future<void> scrollBody(WidgetTester tester) async {
    for (var i = 0; i < 6; i++) {
      await tester.drag(find.byType(Scrollable).first, const Offset(0, -300));
      await tester.pumpAndSettle();
    }
  }

  testWidgets('AGT-11 lists every captured section', (tester) async {
    final cubit = await pumpReview(tester);

    expect(find.text('SHOP'), findsOneWidget);
    expect(find.text('LOCATION'), findsOneWidget);
    expect(find.text('Bola Hardware'), findsOneWidget);
    // The location rows sit below the fold at 800 px.
    for (var i = 0; i < 2; i++) {
      await tester.drag(find.byType(Scrollable).first, const Offset(0, -200));
      await tester.pumpAndSettle();
    }
    expect(find.text('beside Bola Hardware, near the main gate'), findsWidgets);
    // Later sections scroll out of the tree, so check them at the bottom.
    await scrollBody(tester);
    expect(find.byType(ReviewSection), findsAtLeastNWidgets(1));
    expect(find.text('MEDIA'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('AGT-11 submits when a landmark exists', (tester) async {
    final cubit = await pumpReview(tester);

    final submit = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Submit'),
    );
    expect(submit.onPressed, isNotNull);
    expect(find.text('Add a landmark description to submit'), findsNothing);

    await cubit.close();
  });

  testWidgets('AGT-11 blocks submission without a landmark', (tester) async {
    final cubit = await pumpReview(tester, withLandmark: false);

    final submit = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Submit'),
    );
    expect(submit.onPressed, isNull);
    expect(find.text('Add a landmark description to submit'), findsOneWidget);
    expect(find.text('[Missing description]'), findsOneWidget);
    expect(find.byType(OfflineSubmitBanner), findsNothing);

    await cubit.close();
  });

  testWidgets('AGT-11 offline keeps Submit enabled', (tester) async {
    final cubit = await pumpReview(tester, offline: true);

    expect(find.byType(OfflineSubmitBanner), findsOneWidget);
    expect(find.text('Offline · this will be queued'), findsWidgets);
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Submit'))
          .onPressed,
      isNotNull,
      reason: 'offline is a supported path, not a degraded one',
    );

    await cubit.close();
  });

  testWidgets('AGT-11 bounty panel never reads as held money', (tester) async {
    final cubit = await pumpReview(tester);

    await scrollBody(tester);
    expect(find.byType(BountyExpectationPanel), findsOneWidget);
    expect(find.text('BOUNTY IF VERIFIED'), findsOneWidget);
    expect(find.text('₦5,000'), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsNothing);
    expect(find.byIcon(Icons.lock_outline), findsNothing);

    await cubit.close();
  });

  testWidgets('AGT-12 confirms the submission', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: const SubmissionQueuedPage(),
    );

    expect(find.text('Shop captured'), findsOneWidget);
    expect(find.text('Bola Hardware · Kugbo Market'), findsOneWidget);
    expect(tester.takeException(), isNull);
    expect(find.text('Uploaded and sent to review'), findsOneWidget);
    expect(find.byType(SubmissionDetailList), findsOneWidget);
    expect(find.text('SUB-2214'), findsOneWidget);
    expect(find.text('Pending verification'), findsOneWidget);
    expect(find.byType(WhatHappensNext), findsOneWidget);
    expect(find.text('Capture another'), findsOneWidget);
    expect(find.text('Back to today'), findsOneWidget);
  });

  testWidgets('AGT-12 never uses danger styling or a lock', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: const SubmissionQueuedPage(),
    );

    // The bounty is pending, not held: no lock, and no danger anywhere.
    expect(find.byIcon(Icons.lock), findsNothing);
    expect(find.byIcon(Icons.lock_outline), findsNothing);
    final errorIcons = tester.widgetList<Icon>(
      find.byIcon(Icons.error_outline),
    );
    expect(errorIcons, isEmpty);
  });

  testWidgets('AGT-12 offline frame names the offline path', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: const SubmissionQueuedPage(outcome: SubmissionOutcome.queued),
    );

    expect(find.text('Saved on this phone'), findsOneWidget);
    expect(
      find.text('Your shop is queued and uploads when you\'re online'),
      findsWidgets,
    );
  });

  testWidgets('AGT-12 shows the daily milestone once past one shop', (
    tester,
  ) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: const SubmissionQueuedPage(shopsToday: 3),
    );

    // The milestone is rich text, so match on its plain text.
    final rich = tester
        .widgetList<RichText>(find.byType(RichText))
        .map((w) => w.text.toPlainText());
    expect(
      rich.any(
        (t) => t.contains('3 shops captured today') && t.contains('₦15,000'),
      ),
      isTrue,
    );
  });

  testWidgets('AGT-12 keeps actions at full touch size', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: const SubmissionQueuedPage(),
    );

    expect(
      tester
          .getSize(find.widgetWithText(FilledButton, 'Capture another'))
          .height,
      greaterThanOrEqualTo(AppDimensions.minTouchTarget),
    );
  });
}
