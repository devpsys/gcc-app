import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/widgets/held_funds_indicator.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/vendor_earnings_panel.dart';

import '../../../../helpers/pump_app.dart';
import '../dashboard_fixtures.dart';

void main() {
  testWidgets('uses held-funds styling only on the two locked amounts', (
    tester,
  ) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: const Material(
        child: VendorEarningsPanel(
          earnings: vendorEarnings,
          availableLabel: 'Available to withdraw',
          awaitingLabel: 'Awaiting condition check',
          depositsLabel: 'Held as caution deposits',
          withdrawLabel: 'Withdraw to bank',
          walletLabel: 'Open wallet',
          emptyLabel: 'No earnings to show yet.',
          disabledReason: "This isn't available in the app yet.",
        ),
      ),
    );

    expect(find.byType(HeldFundsIndicator), findsNWidgets(2));
    expect(find.text('Awaiting condition check'), findsOneWidget);
    expect(find.text('Held as caution deposits'), findsOneWidget);
    expect(
      find.ancestor(
        of: find.text('Available to withdraw'),
        matching: find.byType(HeldFundsIndicator),
      ),
      findsNothing,
    );
  });
}
