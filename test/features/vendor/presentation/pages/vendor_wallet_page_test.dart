import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_wallet_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_wallet_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/pages/vendor_wallet_screen.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_balance_card.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the three figures and locks only held money', (
    tester,
  ) async {
    await _pump(tester, MockVendorWalletGateway());

    expect(find.text('₦486,200'), findsWidgets);
    expect(find.text('₦92,000'), findsWidgets);
    expect(find.text('₦150,000'), findsWidgets);
    expect(find.textContaining('Never yours to touch'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(WalletBalanceCard),
        matching: find.byIcon(Icons.lock),
      ),
      findsNothing,
    );
    expect(find.byIcon(Icons.lock), findsWidgets);
    final withdraw = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Withdraw to bank'),
    );
    expect(withdraw.onPressed, isNull);

    await tester.drag(find.byType(ListView), const Offset(0, -900));
    await tester.pumpAndSettle();
    expect(find.text('+₦99,900'), findsOneWidget);
  });

  testWidgets('retry keeps the balance and marks the payout sent', (
    tester,
  ) async {
    await _pump(
      tester,
      MockVendorWalletGateway(wallet: MockVendorWalletGateway.failed),
    );

    expect(find.textContaining('returned to your balance'), findsOneWidget);
    expect(find.text('₦486,200'), findsWidgets);

    await tester.tap(find.text('Retry payout'));
    await tester.pumpAndSettle();

    expect(find.textContaining('returned to your balance'), findsNothing);
    await tester.drag(find.byType(ListView), const Offset(0, -900));
    await tester.pumpAndSettle();
    expect(find.text('Payout PAY-8841 sent'), findsOneWidget);
    expect(find.text('−₦250,000'), findsOneWidget);
    expect(find.text('₦486,200'), findsWidgets);
  });

  testWidgets('a zero balance explains that there is nothing to withdraw', (
    tester,
  ) async {
    await _pump(
      tester,
      MockVendorWalletGateway(wallet: MockVendorWalletGateway.empty),
    );

    expect(find.text('₦0'), findsWidgets);
    expect(find.text('Nothing available to withdraw yet'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -1200));
    await tester.pumpAndSettle();
    expect(find.text('No transactions yet'), findsOneWidget);
    final bookings = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'View my bookings'),
    );
    expect(bookings.onPressed, isNotNull);
  });

  testWidgets('wallet lays out at 320×640 with text scale 2', (tester) async {
    await _pump(
      tester,
      MockVendorWalletGateway(),
      size: const Size(320, 640),
      scale: 2,
    );
    await tester.drag(find.byType(ListView), const Offset(0, -1600));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pump(
  WidgetTester tester,
  MockVendorWalletGateway gateway, {
  Size size = const Size(360, 800),
  double scale = 1,
}) async {
  final cubit = VendorWalletCubit(gateway);
  await cubit.load();
  addTearDown(cubit.close);
  await pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: BlocProvider.value(value: cubit, child: const VendorWalletScreen()),
  );
}
