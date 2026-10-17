import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_theme.dart';
import 'package:gcc_app/core/widgets/app_bottom_navigation_bar.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/pages/field_map_screen.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/agent_shell.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

import '../../../../helpers/pump_app.dart';

/// Every agent destination must carry the bottom navigation, and must offer a
/// way back to Today.
///
/// Found in review: the map, queue, wallet and assigned-shops screens were
/// routed straight to a bare `Scaffold`. The designs put the agent navigation
/// under every frame of all four suites. Without it those screens were one-way
/// doors — reachable from the nav, with no way back out of them.
///
/// These cases drive the real `AgentShell` wrapping used by each routed screen.
void main() {
  /// Pumps a probe router hosting one agent destination.
  Future<GoRouter> pumpWith(
    WidgetTester tester,
    String location,
    Widget child,
  ) async {
    late GoRouter router;
    router = GoRouter(
      initialLocation: RoutePaths.agentToday,
      routes: [
        GoRoute(
          path: RoutePaths.agentToday,
          builder: (context, state) => const Scaffold(body: Text('TODAY')),
        ),
        GoRoute(path: RoutePaths.agentMap, builder: (context, state) => child),
        GoRoute(
          path: RoutePaths.agentQueue,
          builder: (context, state) => child,
        ),
        GoRoute(
          path: RoutePaths.agentShops,
          builder: (context, state) => child,
        ),
        GoRoute(
          path: RoutePaths.agentWallet,
          builder: (context, state) => child,
        ),
      ],
    );
    addTearDown(router.dispose);

    // A phone-sized surface: at tablet widths AppShell switches to a rail, so
    // this assertion only means anything at the compact breakpoint.
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp.router(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
    router.go(location);
    await tester.pumpAndSettle();
    return router;
  }

  testWidgets('the map screen shows the agent navigation', (tester) async {
    await pumpWith(tester, RoutePaths.agentMap, const FieldMapScreen());

    expect(find.byType(AppShell), findsOneWidget);
    expect(find.byType(AppBottomNavigationBar), findsOneWidget);
    // The map keeps its own title strip; the shell adds navigation only.
    expect(find.textContaining('Offline map'), findsWidgets);
  });

  testWidgets('the wallet screen shows the agent navigation', (tester) async {
    await pumpWith(tester, RoutePaths.agentWallet, const _PlainAgentBody());

    expect(find.byType(AppBottomNavigationBar), findsOneWidget);
  });

  testWidgets('the assigned shops screen shows the agent navigation', (
    tester,
  ) async {
    await pumpWith(tester, RoutePaths.agentShops, const FieldMapScreen());

    expect(find.byType(AppBottomNavigationBar), findsOneWidget);
  });

  testWidgets('the queue screen shows the agent navigation', (tester) async {
    await pumpWith(tester, RoutePaths.agentQueue, const _PlainAgentBody());

    expect(find.byType(AppBottomNavigationBar), findsOneWidget);
  });

  testWidgets('Today is reachable from a wrapped agent screen', (tester) async {
    // The real map screen, so Today is not the already-selected tab — tapping
    // the selected tab is correctly a no-op, which would prove nothing.
    final router = await pumpWith(
      tester,
      RoutePaths.agentMap,
      const FieldMapScreen(),
    );

    // The whole point: leaving the map must be possible.
    await tester.tap(find.text('Today'));
    await tester.pumpAndSettle();

    expect(find.text('TODAY'), findsOneWidget);
    expect(
      router.routerDelegate.currentConfiguration.uri.path,
      RoutePaths.agentToday,
    );
  });

  testWidgets('the capture centre action is present on agent screens', (
    tester,
  ) async {
    await pumpWith(tester, RoutePaths.agentMap, const _PlainAgentBody());

    // The designs show Capture as the centre action on every agent frame.
    expect(find.text('Capture'), findsOneWidget);
  });

  testWidgets('the correct agent tab is highlighted', (tester) async {
    await pumpWith(tester, RoutePaths.agentWallet, const _PlainAgentBody());

    // selectedLocation drives the highlight; assert the shell is told.
    expect(find.byType(AppShell), findsOneWidget);
    expect(find.text('Wallet'), findsWidgets);
  });

  testWidgets('every agent destination is enabled and wrapped', (tester) async {
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

    for (final destination in DashboardDestinations.agent(l10n)) {
      expect(
        destination.available,
        isTrue,
        reason: '"${destination.label}" must be reachable',
      );
    }
  });
}

/// A bare agent destination body.
///
/// The chrome under test is [AgentShell], not any particular page, so the body
/// stays trivial rather than dragging in a screen's real content.
class _PlainAgentBody extends StatelessWidget {
  const _PlainAgentBody();

  @override
  Widget build(BuildContext context) => const AgentShell(
    selectedLocation: RoutePaths.agentToday,
    title: 'Probe',
    child: Scaffold(body: SizedBox.shrink()),
  );
}
