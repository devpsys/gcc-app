import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_theme.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/shell_destination.dart';
import 'package:gcc_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/pump_app.dart';

void main() {
  const destinations = [
    ShellDestination(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      location: '/',
    ),
    ShellDestination(
      label: 'Bookings',
      icon: Icons.calendar_today_outlined,
      selectedIcon: Icons.calendar_today,
      location: '/bookings',
    ),
  ];

  testWidgets('uses a bottom bar below the compact breakpoint', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(390, 844),
      child: const AppShell(
        title: 'GCC',
        menuLabel: 'Open navigation menu',
        selectedLocation: '/',
        destinations: destinations,
        child: SizedBox.shrink(),
      ),
    );

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
  });

  testWidgets('uses a drawer between the compact and expanded breakpoints', (
    tester,
  ) async {
    await pumpLocalized(
      tester,
      size: const Size(800, 600),
      child: const AppShell(
        title: 'GCC',
        menuLabel: 'Open navigation menu',
        selectedLocation: '/',
        destinations: destinations,
        child: SizedBox.shrink(),
      ),
    );

    expect(find.byTooltip('Open navigation menu'), findsOneWidget);

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    expect(find.text('Bookings'), findsOneWidget);
  });

  testWidgets('uses a navigation rail from the expanded breakpoint', (
    tester,
  ) async {
    await pumpLocalized(
      tester,
      size: const Size(1280, 800),
      child: const AppShell(
        title: 'GCC',
        menuLabel: 'Open navigation menu',
        selectedLocation: '/',
        destinations: destinations,
        child: SizedBox.shrink(),
      ),
    );

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('a highlighted tab still opens its route from a nested page', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    const tabs = [
      ShellDestination(
        label: 'Catalog',
        icon: Icons.inventory_2_outlined,
        selectedIcon: Icons.inventory_2,
        location: '/vendor/catalog',
      ),
      ShellDestination(
        label: 'Requests',
        icon: Icons.inbox_outlined,
        selectedIcon: Icons.inbox,
        location: '/vendor/requests',
      ),
    ];
    final router = GoRouter(
      initialLocation: '/vendor/catalog/edit/AST-0912',
      routes: [
        GoRoute(
          path: '/vendor/catalog',
          builder: (context, state) => const Scaffold(body: Text('CATALOG')),
        ),
        GoRoute(
          path: '/vendor/requests',
          builder: (context, state) => const Scaffold(body: Text('REQUESTS')),
        ),
        GoRoute(
          path: '/vendor/catalog/edit/:reference',
          builder: (context, state) => const AppShell(
            title: 'AST-0912',
            menuLabel: 'Open navigation menu',
            selectedLocation: '/vendor/catalog',
            destinations: tabs,
            child: Text('EDIT'),
          ),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      MaterialApp.router(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('EDIT'), findsOneWidget);
    await tester.tap(find.text('Catalog'));
    await tester.pumpAndSettle();
    expect(find.text('CATALOG'), findsOneWidget);
  });
}
