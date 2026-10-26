import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_gradients.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// Gradient available-balance card (MOB-LSE-14 frame 1). No lock glyph.
class LesseeWalletBalanceCard extends StatelessWidget {
  const LesseeWalletBalanceCard({
    required this.label,
    required this.amount,
    required this.bank,
    required this.verifiedLabel,
    required this.withdrawLabel,
    required this.onWithdraw,
    super.key,
  });

  final String label;
  final String amount;
  final String bank;
  final String verifiedLabel;
  final String withdrawLabel;
  final VoidCallback onWithdraw;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onCard = scheme.onPrimary;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppGradients.availableBalance,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    label.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: onCard.withValues(alpha: 0.85),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    bank,
                    textAlign: TextAlign.end,
                    style: AppTextStyles.mono(
                      Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: onCard.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxs),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                amount,
                style: AppTextStyles.tabular(
                  Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: onCard,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  size: AppDimensions.iconSm,
                  color: onCard.withValues(alpha: 0.9),
                ),
                const SizedBox(width: AppSpacing.xxs),
                Expanded(
                  child: Text(
                    verifiedLabel,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: onCard.withValues(alpha: 0.9),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton.icon(
              onPressed: onWithdraw,
              icon: Icon(
                Icons.arrow_downward,
                size: AppDimensions.iconSm,
                color: scheme.primary,
              ),
              label: Text(withdrawLabel),
              style: FilledButton.styleFrom(
                backgroundColor: scheme.surface,
                foregroundColor: scheme.primary,
                minimumSize: const Size(
                  double.infinity,
                  AppDimensions.buttonHeight,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.button),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
