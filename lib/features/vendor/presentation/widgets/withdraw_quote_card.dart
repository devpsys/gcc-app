import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// Fee and arrival for a payable amount. The fee in this design is free.
class WithdrawQuoteCard extends StatelessWidget {
  const WithdrawQuoteCard({
    required this.amountLabel,
    required this.amount,
    required this.feeLabel,
    required this.freeLabel,
    required this.netLabel,
    required this.arrivesTitle,
    required this.arrivesBody,
    super.key,
  });

  final String amountLabel;
  final String amount;
  final String feeLabel;
  final String freeLabel;
  final String netLabel;
  final String arrivesTitle;
  final String arrivesBody;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          children: [
            _line(context, amountLabel, amount, strong: false),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Expanded(child: Text(feeLabel)),
                Flexible(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.successContainer,
                      borderRadius: BorderRadius.circular(AppRadii.input),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xxs,
                        vertical: AppSpacing.xxs,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          freeLabel,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: colors.success,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Divider(height: AppDimensions.borderWidth, color: colors.border),
            const SizedBox(height: AppSpacing.xs),
            _line(context, netLabel, amount, strong: true),
            const SizedBox(height: AppSpacing.xs),
            Divider(height: AppDimensions.borderWidth, color: colors.border),
            const SizedBox(height: AppSpacing.xs),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.schedule,
                  size: AppDimensions.iconSm,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        arrivesTitle,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        arrivesBody,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _line(
    BuildContext context,
    String label,
    String amount, {
    required bool strong,
  }) {
    final style = AppTextStyles.tabular(
      Theme.of(context).textTheme.bodyMedium!
          .copyWith(fontWeight: strong ? FontWeight.w800 : FontWeight.w600),
    );
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: strong ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(amount, style: style),
          ),
        ),
      ],
    );
  }
}
