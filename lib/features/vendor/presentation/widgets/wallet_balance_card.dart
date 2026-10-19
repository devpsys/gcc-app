import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_gradients.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// Money the vendor can move. No lock: this is not held by GCC.
class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({
    required this.label,
    required this.amount,
    required this.bank,
    required this.withdrawLabel,
    required this.withdrawReason,
    required this.faded,
    super.key,
  });

  final String label;
  final String amount;
  final String bank;
  final String withdrawLabel;
  final String withdrawReason;
  final bool faded;

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
            Text(
              label.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: onCard.withValues(alpha: 0.7),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                amount,
                style: AppTextStyles.tabular(
                  Theme.of(context).textTheme.headlineMedium!
                      .copyWith(color: onCard, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Text(
              bank,
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.bodySmall!
                    .copyWith(color: onCard.withValues(alpha: 0.7)),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Divider(color: onCard.withValues(alpha: 0.2), height: 1),
            const SizedBox(height: AppSpacing.sm),
            FilledButton(
              onPressed: null,
              style: FilledButton.styleFrom(
                disabledBackgroundColor: scheme.surface.withValues(
                  alpha: faded ? 0.4 : 1,
                ),
                disabledForegroundColor: scheme.primary,
                minimumSize: const Size(
                  double.infinity,
                  AppDimensions.buttonHeight,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.button),
                ),
              ),
              child: Text(withdrawLabel),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              withdrawReason,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: onCard.withValues(alpha: 0.85)),
            ),
          ],
        ),
      ),
    );
  }
}
