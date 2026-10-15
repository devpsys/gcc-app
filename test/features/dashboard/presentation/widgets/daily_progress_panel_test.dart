import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/daily_progress_panel.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('names the ring with the captured and target counts', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: const DailyProgressPanel(
        assigned: 8,
        captured: 3,
        target: 8,
        pendingBounty: '₦15,000',
      ),
    );

    expect(
      find.bySemanticsLabel('3 of 8 shops captured today'),
      findsOneWidget,
    );
    expect(find.text('Daily target: 8'), findsOneWidget);
    semantics.dispose();
  });
}
