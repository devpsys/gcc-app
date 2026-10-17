import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_balance.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/weekly_earning.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/available_balance_card.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/earnings_summary_row.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/paid_this_year_row.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/payout_run_card.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/pending_escrow_card.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/wallet_zero_state.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/weekly_bar_chart.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/withdrawal_amount_field.dart';

/// The agent's bounty wallet.
///
/// Three frames, matching the designs: an active balance, the new-agent zero
/// state, and the insufficient-balance guardrail.
///
/// The escrow rule is the load-bearing detail: money in the gradient balance
/// card is the agent's to withdraw and carries **no** lock, while the pending
/// strip beside it is held at GCC and carries the lock and amber hatch. Those
/// two must never be confused, which is why they are separate widgets rather
/// than one balance with a flag.
class BountyWalletPage extends StatefulWidget {
  const BountyWalletPage({
    required this.balance,
    required this.weeks,
    required this.runs,
    this.onWithdraw,
    this.onStartCapturing,
    this.onPreviousPeriod,
    this.nextRunNote,
    super.key,
  });

  final WalletBalance balance;
  final List<WeeklyEarning> weeks;
  final List<PayoutRun> runs;
  final VoidCallback? onWithdraw;
  final VoidCallback? onStartCapturing;
  final VoidCallback? onPreviousPeriod;

  /// e.g. `Next payout schedule: Mon 12 Oct · 09:00`.
  final String? nextRunNote;

  @override
  State<BountyWalletPage> createState() => _BountyWalletPageState();
}

class _BountyWalletPageState extends State<BountyWalletPage> {
  /// Whether the withdrawal form is open. Only the guardrail frame opens it.
  bool _withdrawing = false;

  String _amount = '';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.walletTitle),
        backgroundColor: scheme.surface,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            AvailableBalanceCard(
              amount: widget.balance.isEmpty ? '₦0' : widget.balance.available,
              bankLabel: widget.balance.bankLabel ?? '',
              availableLabel: l10n.walletAvailableLabel,
              withdrawLabel: l10n.walletWithdrawToBank,
              isZero: widget.balance.isEmpty,
              onWithdraw: widget.balance.isEmpty
                  ? null
                  : () => setState(() => _withdrawing = true),
            ),
            if (widget.balance.isEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              WalletZeroState(onStartCapturing: widget.onStartCapturing),
            ] else ...[
              const SizedBox(height: AppSpacing.sm),
              PendingEscrowCard(
                amount: widget.balance.pendingVerification,
                label: l10n.walletPendingLabel,
                note: l10n.walletVerificationTakesADay,
              ),
              const SizedBox(height: AppSpacing.sm),
              PaidThisYearRow(total: widget.balance.paidThisYear),
              if (_withdrawing) ...[
                const SizedBox(height: AppSpacing.sm),
                WithdrawalAmountField(
                  warning: _warning(context),
                  maxLabel: l10n.walletMaxAmount(widget.balance.available),
                  maxAmount: widget.balance.available,
                  amount: _amount,
                  onChanged: (value) => setState(() => _amount = value),
                  onMax: () =>
                      setState(() => _amount = widget.balance.available),
                  submitLabel: l10n.walletWithdrawToBank,
                  onSubmit: widget.onWithdraw,
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              WeeklyBarChart(
                weeks: widget.weeks,
                title: l10n.walletLastSixWeeks,
                previousLabel: l10n.walletPreviousPeriod,
                onPreviousPeriod: widget.onPreviousPeriod,
              ),
              const SizedBox(height: AppSpacing.sm),
              EarningsSummaryRow(weeks: widget.weeks),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.walletPayoutHistory,
                style: Theme.of(context).textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                l10n.walletPayoutSchedule,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.sm),
              for (final run in widget.runs) ...[
                PayoutRunCard(run: run),
                const SizedBox(height: AppSpacing.sm),
              ],
              if (widget.nextRunNote != null)
                Text(
                  widget.nextRunNote!,
                  style: AppTextStyles.mono(
                    Theme.of(context).textTheme.labelSmall!
                        .copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  /// The guardrail: below the minimum, the form says so up front.
  String? _warning(BuildContext context) {
    final parsed = double.tryParse(_amount.replaceAll(RegExp(r'[^0-9.]'), ''));
    if (parsed == null) {
      return context.l10n.walletMinimumWarning(
        context.l10n.walletMinimumAmount,
      );
    }
    if (parsed < _minimum) {
      return context.l10n.walletMinimumWarning(
        context.l10n.walletMinimumAmount,
      );
    }
    return null;
  }

  static const double _minimum = 10000;
}
