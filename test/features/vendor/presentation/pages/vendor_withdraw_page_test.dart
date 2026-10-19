import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_withdraw_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_wallet_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/pages/vendor_withdraw_screen.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/withdraw_amount_field.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('opens on ₦250,000 and locks only the held deposits', (
    tester,
  ) async {
    await _pump(tester);

    expect(find.text('250,000'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Withdraw ₦250,000'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Withdraw ₦250,000'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('₦92,000'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.textContaining('₦92,000'), findsOneWidget);
    expect(find.textContaining('₦150,000'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(WithdrawAmountField),
        matching: find.byIcon(Icons.lock),
      ),
      findsNothing,
    );
    expect(find.byIcon(Icons.lock), findsNWidgets(2));
  });

  testWidgets('an empty amount blocks the payout and hides the held notice', (
    tester,
  ) async {
    await _pump(tester);

    await tester.enterText(find.byType(TextField), '');
    await tester.pumpAndSettle();

    expect(find.text('Enter an amount to withdraw'), findsOneWidget);
    expect(find.text('Enter an amount to continue'), findsOneWidget);
    expect(find.textContaining('quarantined for other bookings'), findsNothing);
    final withdraw = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Withdraw'),
    );
    expect(withdraw.onPressed, isNull);
  });

  testWidgets('sending ₦250,000 leaves ₦236,200', (tester) async {
    final gateway = MockVendorWalletGateway();
    await _pump(tester, gateway: gateway);

    await tester.scrollUntilVisible(
      find.text('Withdraw ₦250,000'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Withdraw ₦250,000'));
    await tester.pumpAndSettle();

    expect(find.text('₦250,000 is on its way'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('PAY-8842'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('PAY-8842'), findsOneWidget);
    expect(find.text('₦236,200'), findsOneWidget);
    expect(find.text('₦486,200 − ₦250,000'), findsOneWidget);

    final saved = await gateway.load();
    expect(saved.availableAmount, 236200);
    expect(saved.awaiting, '₦92,000');
    expect(saved.held, '₦150,000');
  });

  testWidgets('withdraw lays out at 320×640 with text scale 2', (tester) async {
    await _pump(tester, size: const Size(320, 640), scale: 2);
    await tester.drag(find.byType(ListView), const Offset(0, -800));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pump(
  WidgetTester tester, {
  MockVendorWalletGateway? gateway,
  Size size = const Size(360, 800),
  double scale = 1,
}) async {
  final cubit = VendorWithdrawCubit(gateway ?? MockVendorWalletGateway());
  await cubit.load();
  addTearDown(cubit.close);
  await pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: BlocProvider.value(
      value: cubit,
      child: const VendorWithdrawScreen(),
    ),
  );
}
