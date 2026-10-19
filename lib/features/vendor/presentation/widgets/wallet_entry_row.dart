import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry_kind.dart';

class WalletEntryRow extends StatelessWidget {
  const WalletEntryRow({required this.entry, required this.title, super.key});

  final VendorWalletEntry entry;
  final String title;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final kind = entry.kind;
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
      VendorWalletEntryKind.release => Icons.add,
      VendorWalletEntryKind.depositHeld => Icons.lock,
      VendorWalletEntryKind.payoutSent => Icons.arrow_downward,
      VendorWalletEntryKind.payoutFailed => Icons.warning_amber_outlined,
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.border),
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
                dimension: AppDimensions.minTouchTarget,
                child: Icon(icon, color: iconColor, size: AppDimensions.iconMd),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: kind == VendorWalletEntryKind.payoutFailed
                          ? scheme.error
                          : scheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    entry.detail,
                    style: AppTextStyles.mono(
                      Theme.of(context).textTheme.bodySmall!
                          .copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  entry.amount,
                  style: AppTextStyles.tabular(
                    Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: amountColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
