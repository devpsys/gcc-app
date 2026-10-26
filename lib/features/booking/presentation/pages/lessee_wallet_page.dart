import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_wallet_state.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_wallet_balance_card.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_wallet_breakdown.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_wallet_empty_ledger.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_wallet_entry_row.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_wallet_escrow_section.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_wallet_zero_card.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry_kind.dart';

/// Active, zero, and statement frames for MOB-LSE-14.
class LesseeWalletPage extends StatelessWidget {
  const LesseeWalletPage({
    required this.state,
    required this.onViewBookings,
    this.onWithdraw,
    this.onViewStatement,
    super.key,
  });

  final LesseeWalletReady state;
  final VoidCallback onViewBookings;
  final VoidCallback? onWithdraw;
  final VoidCallback? onViewStatement;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final wallet = state.wallet;
    final visible = state.visible;
    final empty = wallet.availableAmount == 0;
    final scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        if (empty)
          LesseeWalletZeroCard(
            label: l10n.lesseeWalletNothingToWithdraw,
            amount: wallet.available,
            caption: l10n.lesseeWalletZeroCaption,
          )
        else
          LesseeWalletBalanceCard(
            label: l10n.lesseeWalletAvailable,
            amount: wallet.available,
            bank: wallet.bank,
            verifiedLabel: l10n.lesseeWalletDisbursementVerified,
            withdrawLabel: l10n.lesseeWalletWithdraw,
            onWithdraw: onWithdraw ?? () {},
          ),
        const SizedBox(height: AppSpacing.md),
        if (empty) ...[
          LesseeWalletEscrowSection(
            title: l10n.lesseeWalletEscrowTitle,
            holds: state.escrowHolds,
          ),
          LesseeWalletEmptyLedger(
            title: l10n.lesseeWalletEmptyTitle,
            body: l10n.lesseeWalletEmptyBody,
            actionLabel: l10n.lesseeWalletViewBookings,
            onAction: onViewBookings,
          ),
        ] else ...[
          LesseeWalletBreakdown(
            title: l10n.lesseeWalletBreakdown,
            availableLabel: l10n.lesseeWalletAvailableFigure,
            availableCaption: l10n.lesseeWalletAvailableCaption,
            available: wallet.available,
            availableBadge: l10n.lesseeWalletNoLock,
            depositsLabel: l10n.lesseeWalletDepositsHeld,
            depositsCaption: l10n.lesseeWalletDepositsHeldCaption,
            deposits: wallet.held,
            depositsBadge: l10n.lesseeWalletEscrowBadge,
            pendingLabel: l10n.lesseeWalletPendingRefunds,
            pendingCaption: l10n.lesseeWalletPendingRefundsCaption,
            pending: wallet.awaiting,
            pendingBadge: l10n.lesseeWalletAuditBadge,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.lesseeWalletHistory.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              TextButton(
                onPressed: onViewStatement,
                child: Text(l10n.lesseeWalletViewStatement),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          for (final entry in visible) ...[
            if (entry.heading.isNotEmpty) ...[
              Text(
                entry.heading,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
            ],
            LesseeWalletEntryRow(
              entry: entry,
              title: _title(context, entry),
              status: _status(context, entry),
              refund: _isRefund(entry),
            ),
            const SizedBox(height: AppSpacing.xs),
          ],
        ],
      ],
    );
  }

  bool _isRefund(VendorWalletEntry entry) {
    return entry.kind == VendorWalletEntryKind.release &&
        entry.detail.toLowerCase().contains('vendor approved');
  }

  String _title(BuildContext context, VendorWalletEntry entry) {
    final l10n = context.l10n;
    return switch (entry.kind) {
      VendorWalletEntryKind.release => _isRefund(entry)
          ? l10n.lesseeWalletRefundReceived(entry.reference)
          : l10n.lesseeWalletBookingReleased(entry.reference),
      VendorWalletEntryKind.depositHeld => l10n.lesseeWalletDepositHeld,
      VendorWalletEntryKind.payoutSent =>
        l10n.lesseeWalletPayoutSent(entry.reference),
      VendorWalletEntryKind.payoutFailed =>
        l10n.lesseeWalletPayoutFailed(entry.reference),
    };
  }

  String _status(BuildContext context, VendorWalletEntry entry) {
    final l10n = context.l10n;
    return switch (entry.kind) {
      VendorWalletEntryKind.release => _isRefund(entry)
          ? l10n.lesseeWalletStatusRefunded
          : l10n.lesseeWalletStatusSettled,
      VendorWalletEntryKind.depositHeld => l10n.lesseeWalletStatusHeldByVendor,
      VendorWalletEntryKind.payoutSent => l10n.lesseeWalletStatusCompleted,
      VendorWalletEntryKind.payoutFailed => l10n.lesseeWalletStatusRecredited,
    };
  }
}
