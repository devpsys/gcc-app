import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/fleet_status_panel.dart';

import '../../../../helpers/pump_app.dart';
import '../dashboard_fixtures.dart';

void main() {
  testWidgets('exposes each fleet segment and its count', (tester) async {
    final semantics = tester.ensureSemantics();
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: const FleetStatusPanel(
        fleet: vendorFleet,
        disabledReason: "This isn't available in the app yet.",
      ),
    );

    expect(find.text('Ready for work'), findsOneWidget);
    expect(find.text('18'), findsOneWidget);
    expect(find.text('Rented out'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('In maintenance'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.bySemanticsLabel('Ready for work: 18'), findsOneWidget);
    expect(find.bySemanticsLabel('Rented out: 5'), findsOneWidget);
    expect(find.bySemanticsLabel('In maintenance: 1'), findsOneWidget);
    semantics.dispose();
  });
}
