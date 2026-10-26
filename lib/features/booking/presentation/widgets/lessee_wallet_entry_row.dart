import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry_kind.dart';

/// Statement row with status chip (MOB-LSE-14 transaction feed).
class LesseeWalletEntryRow extends StatelessWidget {
  const LesseeWalletEntryRow({
    required this.entry,
    required this.title,
    required this.status,
    this.refund = false,
    super.key,
  });

  final VendorWalletEntry entry;
  final String title;
  final String status;
  final bool refund;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final kind = entry.kind;
    final escrow = kind == VendorWalletEntryKind.depositHeld;
    final failed = kind == VendorWalletEntryKind.payoutFailed;
    final amountColor = switch (kind) {
      VendorWalletEntryKind.release => colors.success,
      VendorWalletEntryKind.depositHeld => colors.heldFunds,
      VendorWalletEntryKind.payoutSent ||
      VendorWalletEntryKind.payoutFailed => scheme.onSurface,
    };
    final iconColor = switch (kind) {
      VendorWalletEntryKind.release => colors.success,
      VendorWalletEntryKind.depositHeld => colors.heldFunds,
      VendorWalletEntryKind.payoutSent => scheme.onSurfaceVariant,
      VendorWalletEntryKind.payoutFailed => scheme.error,
    };
    final icon = switch (kind) {
      VendorWalletEntryKind.release =>
        refund ? Icons.check : Icons.add,
      VendorWalletEntryKind.depositHeld => Icons.lock,
      VendorWalletEntryKind.payoutSent => Icons.north_east,
      VendorWalletEntryKind.payoutFailed => Icons.priority_high,
    };
    final statusBg = switch (kind) {
      VendorWalletEntryKind.release => colors.successContainer,
      VendorWalletEntryKind.depositHeld => colors.heldFundsContainer,
      VendorWalletEntryKind.payoutSent => scheme.surfaceContainerHighest,
      VendorWalletEntryKind.payoutFailed => scheme.errorContainer,
    };
    final statusFg = switch (kind) {
      VendorWalletEntryKind.release => colors.success,
      VendorWalletEntryKind.depositHeld => colors.heldFunds,
      VendorWalletEntryKind.payoutSent => scheme.onSurfaceVariant,
      VendorWalletEntryKind.payoutFailed => scheme.error,
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: escrow
            ? colors.heldFundsContainer.withValues(alpha: 0.4)
            : failed
            ? scheme.errorContainer.withValues(alpha: 0.35)
            : scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.button),
        border: Border.all(
          color: escrow
              ? colors.heldFunds.withValues(alpha: 0.35)
              : failed
              ? colors.dangerBorder
              : colors.border,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: SizedBox.square(
                dimension: AppSpacing.xl,
                child: Icon(icon, color: iconColor, size: AppDimensions.iconSm),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    entry.detail,
                    style: AppTextStyles.mono(
                      Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: failed
                            ? scheme.error
                            : scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (escrow) ...[
                      Icon(
                        Icons.lock,
                        size: AppDimensions.iconSm,
                        color: colors.heldFunds,
                      ),
                      const SizedBox(width: AppSpacing.xxs),
                    ],
                    Text(
                      entry.amount,
                      style: AppTextStyles.tabular(
                        Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: amountColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxs),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(AppRadii.input),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxs,
                      vertical: 1,
                    ),
                    child: Text(
                      status,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: statusFg,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
