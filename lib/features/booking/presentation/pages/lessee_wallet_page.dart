import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_wallet_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_wallet_state.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_wallet_escrow_section.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry_kind.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_period.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_balance_card.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_empty_ledger.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_entry_row.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_failure_banner.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_figures.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_period_bar.dart';

/// Active, zero, and statement frames for MOB-LSE-14.
class LesseeWalletPage extends StatelessWidget {
  const LesseeWalletPage({
    required this.state,
    required this.onViewBookings,
    this.onWithdraw,
    super.key,
  });

  final LesseeWalletReady state;
  final VoidCallback onViewBookings;
  final VoidCallback? onWithdraw;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LesseeWalletCubit>();
    final l10n = context.l10n;
    final wallet = state.wallet;
    final failure = wallet.failure;
    final visible = state.visible;
    final empty = wallet.availableAmount == 0;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        if (failure != null)
          WalletFailureBanner(
            title: l10n.vendorWalletPayoutFailedBanner(
              failure.reference,
              failure.amount,
            ),
            body: l10n.vendorWalletPayoutFailedBody(failure.bank),
            retryLabel: l10n.vendorWalletRetry,
            onRetry: cubit.retryPayout,
          ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              WalletBalanceCard(
                label: empty
                    ? l10n.lesseeWalletNothingToWithdraw
                    : l10n.lesseeWalletAvailable,
                amount: wallet.available,
                bank: wallet.bank,
                withdrawLabel: l10n.lesseeWalletWithdraw,
                onWithdraw: empty ? null : onWithdraw,
                withdrawReason: empty
                    ? l10n.lesseeWalletZeroCaption
                    : null,
                faded: empty,
              ),
              const SizedBox(height: AppSpacing.md),
              if (empty) ...[
                LesseeWalletEscrowSection(
                  title: l10n.lesseeWalletEscrowTitle,
                  holds: state.escrowHolds,
                ),
                const SizedBox(height: AppSpacing.md),
              ] else ...[
                Text(
                  l10n.lesseeWalletBreakdown,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                WalletFigures(
                  availableLabel: l10n.lesseeWalletAvailableFigure,
                  available: wallet.available,
                  awaitingLabel: l10n.lesseeWalletDepositsHeld,
                  awaitingCaption: l10n.lesseeWalletDepositsHeldCaption,
                  awaiting: wallet.awaiting,
                  heldLabel: l10n.lesseeWalletPendingRefunds,
                  heldCaption: l10n.lesseeWalletPendingRefundsCaption,
                  held: wallet.held,
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              if (wallet.showPeriods) ...[
                WalletPeriodBar(
                  selected: state.period,
                  labels: {
                    VendorWalletPeriod.week: l10n.vendorWalletThisWeek,
                    VendorWalletPeriod.month: l10n.vendorWalletThisMonth,
                    VendorWalletPeriod.year: l10n.vendorWalletThisYear,
                  },
                  onSelected: cubit.selectPeriod,
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              if (!empty)
                Text(
                  l10n.lesseeWalletHistory,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              if (!empty) const SizedBox(height: AppSpacing.sm),
              if (visible.isEmpty)
                WalletEmptyLedger(
                  title: l10n.lesseeWalletEmptyTitle,
                  body: l10n.lesseeWalletEmptyBody,
                  actionLabel: l10n.lesseeWalletViewBookings,
                  onAction: onViewBookings,
                )
              else
                for (final entry in visible) ...[
                  if (entry.heading.isNotEmpty) ...[
                    Text(
                      entry.heading,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                  ],
                  WalletEntryRow(entry: entry, title: _title(context, entry)),
                  const SizedBox(height: AppSpacing.xs),
                ],
            ],
          ),
        ),
      ],
    );
  }

  String _title(BuildContext context, VendorWalletEntry entry) {
    final l10n = context.l10n;
    return switch (entry.kind) {
      VendorWalletEntryKind.release =>
        entry.detail.toLowerCase().contains('vendor approved')
            ? l10n.lesseeWalletRefundReceived(entry.reference)
            : l10n.lesseeWalletBookingReleased(entry.reference),
      VendorWalletEntryKind.depositHeld => l10n.lesseeWalletDepositHeld,
      VendorWalletEntryKind.payoutSent =>
        l10n.lesseeWalletPayoutSent(entry.reference),
      VendorWalletEntryKind.payoutFailed =>
        l10n.lesseeWalletPayoutFailed(entry.reference),
    };
  }
}
