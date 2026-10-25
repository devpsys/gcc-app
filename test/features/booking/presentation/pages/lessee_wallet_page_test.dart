import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_wallet_cubit.dart';
import 'package:gcc_app/features/booking/presentation/gateway/mock_lessee_wallet_gateway.dart';
import 'package:gcc_app/features/booking/presentation/pages/lessee_wallet_screen.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_balance_card.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows available balance and locks only escrow rows', (
    tester,
  ) async {
    await _pump(tester, MockLesseeWalletGateway());

    expect(find.text('₦486,200'), findsWidgets);
    expect(find.text('₦150,000'), findsWidgets);
    expect(find.text('₦92,000'), findsWidgets);
    expect(find.textContaining('Deposits held by vendors'), findsWidgets);
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
    expect(withdraw.onPressed, isNotNull);

    await tester.drag(find.byType(ListView), const Offset(0, -900));
    await tester.pumpAndSettle();
    expect(find.text('+₦99,900'), findsOneWidget);
  });

  testWidgets('a zero balance shows escrow holds and bookings CTA', (
    tester,
  ) async {
    await _pump(
      tester,
      MockLesseeWalletGateway(wallet: MockLesseeWalletGateway.empty),
    );

    expect(find.text('₦0'), findsWidgets);
    expect(find.textContaining('NOTHING TO WITHDRAW'), findsOneWidget);
    expect(find.textContaining('Held in escrow'), findsOneWidget);
    expect(find.textContaining('BK-24817'), findsWidgets);
    await tester.drag(find.byType(ListView), const Offset(0, -1200));
    await tester.pumpAndSettle();
    expect(find.text('No transactions ready for payout'), findsOneWidget);
    final bookings = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'View my bookings'),
    );
    expect(bookings.onPressed, isNotNull);
  });

  testWidgets('wallet lays out at 320×640 with text scale 2', (tester) async {
    await _pump(
      tester,
      MockLesseeWalletGateway(),
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
  MockLesseeWalletGateway gateway, {
  Size size = const Size(360, 800),
  double scale = 1,
}) async {
  final cubit = LesseeWalletCubit(gateway);
  await cubit.load();
  addTearDown(cubit.close);
  await pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: BlocProvider.value(value: cubit, child: const LesseeWalletScreen()),
  );
}
