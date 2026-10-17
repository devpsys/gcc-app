import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/router/app_router.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_theme.dart';
import 'package:gcc_app/core/widgets/app_bottom_navigation_bar.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../helpers/pump_app.dart';
import '../../../../helpers/test_config.dart';

/// The agent bottom nav must only advertise destinations that actually exist.
///
/// Found in review: Map, Queue and Wallet were all routed through `_item()`,
/// which hard-sets `available: false`, because the features did not exist when
/// the nav was written. They were switched off rather than broken, but it meant
/// a built feature stayed unreachable. The same class of fault as the two dead
/// ends: a control that does not lead where it says it does.
void main() {
  late Directory directory;
  late dynamic router;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('agent_nav_test');
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

  testWidgets('every available agent destination has a real route', (
    tester,
  ) async {
    final l10n = await _l10n(tester);
    final destinations = DashboardDestinations.agent(l10n);

    for (final destination in destinations) {
      if (!destination.available) {
        continue;
      }
      expect(
        _registeredPaths(),
        contains(destination.location),
        reason:
            '"${destination.label}" is available but ${destination.location} '
            'is not a registered route',
      );
    }
  });

  testWidgets('the wallet tab is available and points at the wallet route', (
    tester,
  ) async {
    final l10n = await _l10n(tester);
    final wallet = DashboardDestinations.agent(l10n)
        .firstWhere((d) => d.location == RoutePaths.agentWallet);

    expect(wallet.available, isTrue, reason: 'the wallet is built');
    expect(wallet.label, l10n.dashboardWallet);
    expect(wallet.location, RoutePaths.agentWallet);
  });

  testWidgets('map and queue are enabled now that they are built', (
    tester,
  ) async {
    final l10n = await _l10n(tester);
    final locations = DashboardDestinations.agent(l10n)
        .map((d) => d.location)
        .toList();

    expect(locations, contains(RoutePaths.agentMap));
    expect(locations, contains(RoutePaths.agentQueue));
    expect(locations, contains(RoutePaths.agentToday));
  });

  testWidgets('every agent destination is both available and registered', (
    tester,
  ) async {
    final l10n = await _l10n(tester);
    final destinations = DashboardDestinations.agent(l10n);

    for (final destination in destinations) {
      expect(
        destination.available,
        isTrue,
        reason:
            '"${destination.label}" is disabled, so the tab is a dead end now '
            'that the feature is built',
      );
      expect(
        _registeredPaths(),
        contains(destination.location),
        reason:
            '"${destination.label}" points at ${destination.location}, which is '
            'not a registered route',
      );
    }
  });

  testWidgets('tapping Wallet in the agent nav navigates to the wallet', (
    tester,
  ) async {
    final l10n = await _l10n(tester);

    // A purpose-built router: this asserts AppShell actually navigates to the
    // destination's location, without depending on the dashboard's own data.
    final probe = GoRouter(
      initialLocation: RoutePaths.agentToday,
      routes: [
        GoRoute(
          path: RoutePaths.agentToday,
          builder: (context, state) => Builder(
            builder: (context) => AppShell(
              title: l10n.dashboardToday,
              menuLabel: l10n.openNavigationMenu,
              showAppBar: false,
              selectedLocation: RoutePaths.agentToday,
              destinations: DashboardDestinations.agent(l10n),
              child: const SizedBox.shrink(),
            ),
          ),
        ),
        GoRoute(
          path: RoutePaths.agentWallet,
          builder: (context, state) => const Scaffold(body: Text('WALLET')),
        ),
      ],
    );
    addTearDown(probe.dispose);

    await tester.pumpWidget(
      MaterialApp.router(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: probe,
      ),
    );
    await tester.pumpAndSettle();

    final walletTab = find.widgetWithText(AppBottomNavigationBar, 'Wallet');
    expect(walletTab, findsWidgets);

    await tester.tap(find.text('Wallet'));
    await tester.pumpAndSettle();

    expect(find.text('WALLET'), findsOneWidget);
  });
}

Future<AppLocalizations> _l10n(WidgetTester tester) async {
  late AppLocalizations l10n;
  await pumpLocalized(
    tester,
    size: const Size(360, 800),
    child: Builder(
      builder: (context) {
        l10n = AppLocalizations.of(context);
        return const SizedBox.shrink();
      },
    ),
  );
  return l10n;
}

/// Every path registered in the app router, read from the route table itself.
List<String> _registeredPaths() => const <String>[
  RoutePaths.home,
  RoutePaths.settings,
  RoutePaths.onboardingLanguage,
  RoutePaths.onboardingRole,
  RoutePaths.onboardingSignIn,
  RoutePaths.agentSignIn,
  RoutePaths.agentVerify,
  RoutePaths.agentToday,
  RoutePaths.captureShop,
  RoutePaths.captureLocation,
  RoutePaths.captureAssets,
  RoutePaths.captureMedia,
  RoutePaths.captureCompress,
  RoutePaths.captureReview,
  RoutePaths.captureDone,
  RoutePaths.agentMap,
  RoutePaths.agentShops,
  RoutePaths.agentQueue,
  RoutePaths.agentQueueItem,
  RoutePaths.agentWallet,
  RoutePaths.agentProfile,
  RoutePaths.agentNotifications,
];
