import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

/// The caution deposit. The lock is only on this amount.
class MarketplaceDepositCard extends StatelessWidget {
  const MarketplaceDepositCard({required this.amount, super.key});

  final int amount;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final l10n = context.l10n;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.heldFundsContainer,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.heldFunds),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lock,
                  size: AppDimensions.iconSm,
                  color: colors.heldFunds,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    l10n.marketplaceDepositTitle,
                    style: Theme.of(context).textTheme.titleSmall
                        ?.copyWith(color: colors.heldFunds),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              fullNaira(amount),
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(color: colors.heldFunds),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(l10n.marketplaceDepositBody),
          ],
        ),
      ),
    );
  }
}
