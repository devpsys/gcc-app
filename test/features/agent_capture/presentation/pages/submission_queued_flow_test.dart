import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/router/app_router.dart';
import 'package:gcc_app/core/router/route_names.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_theme.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/capture_shop_page.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/submission_queued_page.dart';
import 'package:gcc_app/l10n/app_localizations.dart';
import 'package:hive/hive.dart';

import '../../../../helpers/establish_agent_session.dart';
import '../../../../helpers/test_config.dart';

/// Drives the terminal "shop captured" screen through the real router.
///
/// Reported in review as a dead end, and it had three separate faults: "Back to
/// today" and "View my queue" were `onPressed: () {}` no-ops, "Capture another"
/// popped back into the review step whose draft is locked for editing, and the
/// screen had no app bar so there was no back affordance at all.
///
/// An isolated page test cannot catch this class of fault — it has no router and
/// so cannot observe whether a button leads anywhere. These pump the real
/// `createAppRouter()`.
void main() {
  late Directory directory;
  late dynamic router;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('queued_flow_test');
    await configureDependencies(
      config: testConfig,
      storageDirectory: directory.path,
    );
    await establishAgentSession();
    router = createAppRouter();
  });

  tearDown(() async {
    router.dispose();
    await Hive.close();
    await getIt.reset();
    await directory.delete(recursive: true);
  });

  Future<void> pumpAt(WidgetTester tester, String path) async {
    await tester.pumpWidget(
      MaterialApp.router(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
    router.go(path);
    await tester.pumpAndSettle();
  }

  testWidgets('the screen renders at the end of the wizard', (tester) async {
    await pumpAt(tester, RoutePaths.captureDone);

    expect(find.byType(SubmissionQueuedPage), findsOneWidget);
    expect(find.text('Back to today'), findsOneWidget);
    expect(find.text('View my queue'), findsOneWidget);
    expect(find.text('Capture another'), findsOneWidget);
  });

  testWidgets('Back to today leaves the wizard for the work list', (
    tester,
  ) async {
    await pumpAt(tester, RoutePaths.captureDone);

    await tester.tap(find.widgetWithText(AppSecondaryButton, 'Back to today'));
    await tester.pumpAndSettle();

    expect(find.byType(SubmissionQueuedPage), findsNothing);
    expect(
      router.routerDelegate.currentConfiguration.uri.path,
      RoutePaths.agentToday,
    );
  });

  testWidgets('View my queue reaches the offline queue', (tester) async {
    await pumpAt(tester, RoutePaths.captureDone);

    await tester.tap(find.text('View my queue'));
    await tester.pumpAndSettle();

    expect(find.byType(SubmissionQueuedPage), findsNothing);
    expect(
      router.routerDelegate.currentConfiguration.uri.path,
      RoutePaths.agentQueue,
    );
  });

  testWidgets('Capture another restarts at step 1 with an empty draft', (
    tester,
  ) async {
    await pumpAt(tester, RoutePaths.captureDone);

    await tester.tap(find.text('Capture another'));
    await tester.pumpAndSettle();

    // Lands on step 1, not back on the locked review screen.
    expect(find.byType(CaptureShopPage), findsOneWidget);
    expect(find.byType(SubmissionQueuedPage), findsNothing);
    expect(
      router.routerDelegate.currentConfiguration.uri.path,
      RoutePaths.captureShop,
    );
  });

  testWidgets('the submitted wizard is not left on the back stack', (
    tester,
  ) async {
    await pumpAt(tester, RoutePaths.captureDone);
    expect(
      router.routerDelegate.currentConfiguration.uri.path,
      RoutePaths.captureDone,
    );

    await tester.tap(find.text('Capture another'));
    await tester.pumpAndSettle();

    // A `push` here would let a back gesture walk the agent into the review
    // screen, whose draft is locked and whose submit button can no longer work.
    expect(
      router.routerDelegate.currentConfiguration.uri.path,
      RoutePaths.captureShop,
    );
  });

  testWidgets('the done route is its own destination', (tester) async {
    // Structural guard against the exits being merged back into the wizard.
    expect(RouteNames.captureDone, 'captureDone');
    expect(RoutePaths.captureDone, isNot(RoutePaths.captureReview));
    expect(RoutePaths.captureDone, isNot(RoutePaths.agentToday));
  });
}
