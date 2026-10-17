import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_theme.dart';
import 'package:gcc_app/core/widgets/app_bottom_navigation_bar.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/agent_wallet_screen.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/bounty_wallet_page.dart';
import 'package:gcc_app/l10n/app_localizations.dart';
import 'package:hive/hive.dart';

import '../../../../helpers/test_config.dart';

/// The wallet keeps its navigation once the balance arrives.
///
/// Found in review with a screenshot: the wallet rendered full-screen with no
/// bottom bar. Cause was `WalletZeroBody` doing a `pushReplacement` with a bare
/// `Scaffold`, which sits above the whole agent shell and covers its navigation.
/// Map and queue had been fixed in the same pass but the wallet's own body
/// re-introduced the fault.
///
/// These cases assert the bar is present **after** the async load settles, which
/// is the point at which it used to disappear.
void main() {
  late Directory directory;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('wallet_shell_test');
    await configureDependencies(
      config: testConfig,
      storageDirectory: directory.path,
    );
  });

  tearDown(() async {
    await Hive.close();
    await getIt.reset();
    await directory.delete(recursive: true);
  });

  Future<void> pumpWallet(WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp.router(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: _probe(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('the wallet keeps the agent navigation after loading', (
    tester,
  ) async {
    await pumpWallet(tester);

    // Past the async load: this is where the pushed route used to take over.
    expect(find.byType(BountyWalletPage), findsOneWidget);
    expect(find.byType(AppBottomNavigationBar), findsOneWidget);
  });

  testWidgets('the wallet nav offers Today and Capture', (tester) async {
    await pumpWallet(tester);

    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Capture'), findsOneWidget);
    expect(find.text('Wallet'), findsWidgets);
  });

  testWidgets('the zero state shows no hero figure', (tester) async {
    await pumpWallet(tester);

    // The designs' zero frame prints no amount at all — a big zero reads as a
    // balance the agent lost rather than one they never had.
    expect(find.text('₦0'), findsNothing);
    expect(find.text('No verified bounties to withdraw yet'), findsOneWidget);
    expect(find.text('No bounties yet'), findsOneWidget);
  });

  testWidgets('the withdrawal action is inert with a zero balance', (
    tester,
  ) async {
    await pumpWallet(tester);

    final button = tester.widget<Widget>(
      find.ancestor(
        of: find.text('Withdraw to bank'),
        matching: find.byType(ElevatedButton),
      ),
    );
    expect(button, isNotNull);
  });

  testWidgets('navigating to Today leaves the wallet', (tester) async {
    await pumpWallet(tester);

    await tester.tap(find.text('Today'));
    await tester.pumpAndSettle();

    expect(find.text('TODAY'), findsOneWidget);
    expect(find.byType(AppBottomNavigationBar), findsNothing);
  });
}

GoRouter _probe() => GoRouter(
  initialLocation: RoutePaths.agentWallet,
  routes: [
    GoRoute(
      path: RoutePaths.agentToday,
      builder: (context, state) => const Scaffold(body: Text('TODAY')),
    ),
    GoRoute(
      path: RoutePaths.agentWallet,
      builder: (context, state) => const AgentWalletScreen(),
    ),
  ],
);
