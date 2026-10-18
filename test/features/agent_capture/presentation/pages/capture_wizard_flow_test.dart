import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/router/app_router.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_theme.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/capture_camera_page.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/capture_review_page.dart';
import 'package:gcc_app/l10n/app_localizations.dart';
import 'package:hive/hive.dart';

import '../../../../helpers/establish_agent_session.dart';
import '../../../../helpers/test_config.dart';

/// Drives the media step through the **real** router.
///
/// Every wizard step had its own passing test and step 4 was still a dead end:
/// `captureReview` was registered as a route but never navigated to, so the
/// compression sheet popped straight back to the viewfinder and the wizard could
/// never be completed. An isolated step test cannot catch that — it has no
/// router and so cannot observe whether the step led anywhere. These cases pump
/// the actual app router and assert where the agent ends up.
void main() {
  late Directory directory;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('capture_flow_test');
    await configureDependencies(
      config: testConfig,
      storageDirectory: directory.path,
    );
    await establishAgentSession();
  });

  tearDown(() async {
    await Hive.close();
    await getIt.reset();
    await directory.delete(recursive: true);
  });

  testWidgets('step 4 hands off to the review step', (tester) async {
    final router = createAppRouter();
    addTearDown(router.dispose);

    await tester.pumpWidget(
      MaterialApp.router(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );

    router.go(RoutePaths.captureMedia);
    await tester.pumpAndSettle();

    expect(find.byType(CaptureCameraPage), findsOneWidget);
    expect(find.byType(CaptureReviewPage), findsNothing);

    // The agent's way onward: the media step's primary action.
    await tester.tap(find.widgetWithText(AppPrimaryButton, 'Use photo').last);
    await tester.pumpAndSettle();

    // The pipeline sheet, then its primary action.
    expect(find.text('Continue'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // This is the assertion that matters: the step must actually lead onward.
    expect(find.byType(CaptureReviewPage), findsOneWidget);
  });
}
