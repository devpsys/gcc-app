import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/shell_destination.dart';

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
}
