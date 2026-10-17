import '../../../../helpers/pump_app.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run_shop.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run_state.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_balance.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/weekly_earning.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/bounty_wallet_page.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/available_balance_card.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/payout_run_card.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/pending_escrow_card.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/wallet_zero_state.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/weekly_bar_chart.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/withdrawal_amount_field.dart';

void main() {
  const active = WalletBalance(
    available: '₦48,000',
    pendingVerification: '₦27,000',
    paidThisYear: '₦312,500',
    bankLabel: 'Providus Bank •••• 9034',
  );

  const empty = WalletBalance(
    available: '₦0',
    pendingVerification: '₦0',
    paidThisYear: '₦0',
    bankLabel: 'Providus Bank •••• 9034',
  );

  final weeks = [
    const WeeklyEarning(weekEnding: '30 AUG', amount: '₦15K'),
    const WeeklyEarning(weekEnding: '07 SEP', amount: '₦20K'),
    const WeeklyEarning(weekEnding: '14 SEP', amount: '₦10K'),
    const WeeklyEarning(weekEnding: '21 SEP', amount: '₦25K'),
    const WeeklyEarning(weekEnding: '28 SEP', amount: '₦30K'),
    const WeeklyEarning(weekEnding: '05 OCT', amount: '₦27K'),
  ];

  final runs = [
    const PayoutRun(
      reference: 'Run of 5 Oct',
      subtitle: '13 shops · 6 agents · paid 5 Oct',
      state: PayoutRunState.paid,
      shopCount: 13,
      total: '₦68,500',
      shops: [
        PayoutRunShop(
          name: 'Kugbo Generator Yard',
          subtitle: 'Zone C · Line 4 · AG-0142',
          amount: '₦5,000',
        ),
      ],
    ),
    const PayoutRun(
      reference: 'Run of 12 Oct',
      subtitle: '7 shops',
      state: PayoutRunState.open,
      shopCount: 7,
      total: '₦35,000',
      closingNote: 'Closes Sun 11 Oct · Processing next Mon',
      expectedNote: '₦35,000 expected if all 7 are verified.',
    ),
  ];

  Future<void> pumpWallet(
    WidgetTester tester, {
    WalletBalance balance = active,
    List<PayoutRun> data = const [],
  }) => pumpLocalized(
    tester,
    size: const Size(360, 800),
    child: BountyWalletPage(
      balance: balance,
      weeks: weeks,
      runs: data.isEmpty ? runs : data,
    ),
  );

  /// Scrolls until [text] is built and fully on screen.
  Future<void> reveal(WidgetTester tester, String text) async {
    final target = find.text(text);
    for (var i = 0; i < 8 && target.evaluate().isEmpty; i++) {
      await tester.drag(find.byType(ListView), const Offset(0, -280));
      await tester.pumpAndSettle();
    }
    await tester.ensureVisible(target);
    await tester.pumpAndSettle();
  }

  testWidgets('AGT-15 active frame splits available from held funds', (
    tester,
  ) async {
    await pumpWallet(tester);

    expect(find.text('Bounty wallet'), findsOneWidget);
    expect(find.text('₦48,000'), findsOneWidget);
    expect(find.text('Providus Bank •••• 9034'), findsOneWidget);
    expect(find.byType(PendingEscrowCard), findsOneWidget);
    expect(find.text('₦27,000'), findsOneWidget);
    expect(find.text('₦312,500'), findsOneWidget);
  });

  testWidgets('AGT-15 locks held funds and never the withdrawable balance', (
    tester,
  ) async {
    await pumpWallet(tester);

    // Exactly one lock: the pending strip. The designs reserve the lock for
    // money GCC is holding, never for money the agent can already move.
    expect(find.byIcon(Icons.lock), findsOneWidget);

    // The balance card itself must be lock-free.
    final card = find.byType(AvailableBalanceCard);
    expect(
      find.descendant(of: card, matching: find.byIcon(Icons.lock)),
      findsNothing,
      reason: 'the withdrawable balance is not escrowed',
    );
  });

  testWidgets('AGT-15 new agent sees a zero state, not a zero balance', (
    tester,
  ) async {
    await pumpWallet(tester, balance: empty);

    expect(find.byType(WalletZeroState), findsOneWidget);
    expect(find.text('No verified bounties to withdraw yet'), findsOneWidget);
    expect(
      find.text('Earn ₦5,000 each time a shop you map is verified.'),
      findsOneWidget,
    );
    expect(find.text('Start capturing'), findsOneWidget);
    expect(find.text('No payout runs yet'), findsOneWidget);

    // Nothing is held, so nothing is locked.
    expect(find.byIcon(Icons.lock), findsNothing);
    expect(find.byType(WeeklyBarChart), findsNothing);
    expect(find.byType(PayoutRunCard), findsNothing);
  });

  testWidgets('AGT-15 guardrail blocks withdrawal below the minimum', (
    tester,
  ) async {
    await pumpWallet(tester);

    await tester.tap(find.text('Withdraw to bank').first);
    await tester.pumpAndSettle();

    expect(find.byType(WithdrawalAmountField), findsOneWidget);
    await reveal(tester, 'WITHDRAWAL AMOUNT');
    expect(find.text('WITHDRAWAL AMOUNT'), findsOneWidget);
    // The minimum is stated before the agent types, not after they fail.
    expect(
      find.textContaining('Minimum withdrawal is ₦10,000'),
      findsOneWidget,
    );
  });

  testWidgets('AGT-15 max shortcut fills the available balance', (
    tester,
  ) async {
    await pumpWallet(tester);

    await tester.tap(find.text('Withdraw to bank').first);
    await tester.pumpAndSettle();

    await reveal(tester, 'MAX ₦48,000');
    expect(find.text('MAX ₦48,000'), findsOneWidget);

    await tester.tap(find.text('MAX ₦48,000'));
    await tester.pumpAndSettle();

    // Above the minimum, so the guardrail clears.
    expect(find.textContaining('Minimum withdrawal'), findsNothing);
  });

  testWidgets('AGT-15 chart labels every week without interaction', (
    tester,
  ) async {
    await pumpWallet(tester);

    // 'Last 6 weeks' appears twice (chart title and the period control), so
    // anchor on the first week label instead.
    await reveal(tester, '30 AUG');
    expect(find.byType(WeeklyBarChart), findsOneWidget);
    for (final week in weeks) {
      expect(find.text(week.weekEnding), findsOneWidget);
      expect(find.text(week.amount), findsOneWidget);
    }
    expect(find.textContaining('earned over 6 weeks'), findsOneWidget);
  });

  testWidgets('AGT-15 payout history separates paid runs from open ones', (
    tester,
  ) async {
    await pumpWallet(tester);

    await reveal(tester, 'Run of 5 Oct');
    expect(find.text('₦68,500'), findsOneWidget);
    expect(find.text('Kugbo Generator Yard'), findsOneWidget);
    expect(find.text('Zone C · Line 4 · AG-0142'), findsOneWidget);

    await reveal(tester, 'Run of 12 Oct');
    // An open run states an expectation, which is not money in hand.
    expect(
      find.text('₦35,000 expected if all 7 are verified.'),
      findsOneWidget,
    );
    expect(
      find.text('Closes Sun 11 Oct · Processing next Mon'),
      findsOneWidget,
    );
  });

  testWidgets('AGT-15 payout run pills never carry a lock', (tester) async {
    for (final run in runs) {
      await pumpLocalized(
        tester,
        size: const Size(360, 800),
        child: PayoutRunCard(run: run),
      );
      // A run is a schedule, not an escrow.
      expect(find.byIcon(Icons.lock), findsNothing);
    }
  });
}
