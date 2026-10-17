import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/router/app_router.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_theme.dart';
import 'package:gcc_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../helpers/test_config.dart';

void main() {
  late Directory directory;
  late GoRouter router;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('today_nav_test');
    await configureDependencies(
      config: testConfig,
      storageDirectory: directory.path,
    );
    router = createAppRouter();
  });

  tearDown(() async {
    router.dispose();
    await Hive.close();
    await getIt.reset();
    await directory.delete(recursive: true);
  });

  Future<void> openToday(WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    router.go(RoutePaths.agentToday);
    await tester.pumpWidget(
      MaterialApp.router(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('the sync strip opens the queue', (tester) async {
    await openToday(tester);
    await tester.tap(find.text('Synced').first);
    await tester.pumpAndSettle();
    expect(find.text('Sync queue'), findsOneWidget);
    expect(find.text('Bola Hardware'), findsWidgets);
  });

  testWidgets('see all opens the assigned shops', (tester) async {
    await openToday(tester);
    await tester.scrollUntilVisible(
      find.text('See all 3'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('See all 3'));
    await tester.pumpAndSettle();
    expect(find.text('Assigned shops'), findsOneWidget);
  });

  testWidgets('the bounty snapshot opens the wallet', (tester) async {
    await openToday(tester);
    await tester.scrollUntilVisible(
      find.text('₦48,000'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('₦48,000'));
    await tester.pumpAndSettle();
    expect(find.text('Bounty wallet'), findsWidgets);
  });

  testWidgets('get directions stays unavailable', (tester) async {
    await openToday(tester);
    final button = tester.widget<TextButton>(
      find.widgetWithText(TextButton, 'Get directions'),
    );
    expect(button.onPressed, isNull);
  });
}
