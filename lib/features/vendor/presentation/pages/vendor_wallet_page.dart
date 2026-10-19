import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry_kind.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_period.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_wallet_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_wallet_state.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_balance_card.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_empty_ledger.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_entry_row.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_failure_banner.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_figures.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_period_bar.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/wallet_release_track.dart';

class VendorWalletPage extends StatelessWidget {
  const VendorWalletPage({
    required this.state,
    required this.onViewBookings,
    super.key,
  });

  final VendorWalletReady state;
  final VoidCallback onViewBookings;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VendorWalletCubit>();
    final l10n = context.l10n;
    final wallet = state.wallet;
    final failure = wallet.failure;
    final visible = state.visible;
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
                label: l10n.vendorWalletAvailable,
                amount: wallet.available,
                bank: wallet.bank,
                withdrawLabel: l10n.vendorWalletWithdraw,
                withdrawReason: wallet.availableAmount == 0
                    ? l10n.vendorWalletNothingToWithdraw
                    : l10n.dashboardActionUnavailable,
                faded: wallet.availableAmount == 0,
              ),
              const SizedBox(height: AppSpacing.md),
              WalletFigures(
                availableLabel: l10n.vendorWalletAvailable,
                available: wallet.available,
                awaitingLabel: l10n.vendorWalletAwaiting,
                awaitingCaption: l10n.vendorWalletAwaitingCaption,
                awaiting: wallet.awaiting,
                heldLabel: l10n.vendorWalletHeld,
                heldCaption: l10n.vendorWalletHeldCaption,
                held: wallet.held,
              ),
              if (wallet.releaseSteps.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                WalletReleaseTrack(
                  steps: wallet.releaseSteps,
                  titles: [
                    l10n.vendorWalletCondition,
                    l10n.vendorWalletCheckIn,
                    l10n.vendorWalletMoney,
                  ],
                  pendingLabel: l10n.vendorWalletPending,
                  note: l10n.vendorWalletReleases(wallet.releaseAmount ?? ''),
                ),
              ],
              if (failure != null) ...[
                const SizedBox(height: AppSpacing.md),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(AppRadii.card),
                    border: Border.all(color: context.semanticColors.border),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: AppDimensions.iconSm,
                          color: scheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            l10n.vendorWalletRetryNote,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (wallet.showPeriods) ...[
                const SizedBox(height: AppSpacing.md),
                WalletPeriodBar(
                  selected: state.period,
                  labels: {
                    VendorWalletPeriod.week: l10n.vendorWalletThisWeek,
                    VendorWalletPeriod.month: l10n.vendorWalletThisMonth,
                    VendorWalletPeriod.year: l10n.vendorWalletThisYear,
                  },
                  onSelected: cubit.selectPeriod,
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              if (visible.isEmpty)
                WalletEmptyLedger(
                  title: l10n.vendorWalletEmptyTitle,
                  body: l10n.vendorWalletEmptyBody,
                  actionLabel: l10n.vendorWalletViewBookings,
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
      VendorWalletEntryKind.release => l10n.vendorWalletBookingReleased(
        entry.reference,
      ),
      VendorWalletEntryKind.depositHeld => l10n.vendorWalletDepositHeld(
        entry.reference,
      ),
      VendorWalletEntryKind.payoutSent => l10n.vendorWalletPayoutSent(
        entry.reference,
      ),
      VendorWalletEntryKind.payoutFailed => l10n.vendorWalletPayoutFailed(
        entry.reference,
      ),
    };
  }
}
