import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/vendor/domain/vendor_withdrawal_receipt.dart';

class WithdrawReceiptCard extends StatelessWidget {
  const WithdrawReceiptCard({
    required this.receipt,
    required this.referenceLabel,
    required this.debitedLabel,
    required this.dispatchedLabel,
    required this.arrivalLabel,
    required this.amount,
    required this.checks,
    required this.remainingLabel,
    required this.math,
    required this.remaining,
    super.key,
  });

  final VendorWithdrawalReceipt receipt;
  final String referenceLabel;
  final String debitedLabel;
  final String dispatchedLabel;
  final String arrivalLabel;
  final String amount;
  final List<String> checks;
  final String remainingLabel;
  final String math;
  final String remaining;

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _row(context, referenceLabel, receipt.reference, mono: true),
            _row(context, debitedLabel, amount, mono: false),
            _row(context, dispatchedLabel, receipt.dispatchedAt, mono: true),
            _row(context, arrivalLabel, receipt.arrivesAt, mono: true),
            const SizedBox(height: AppSpacing.xs),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(AppRadii.input),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final check in checks)
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: AppDimensions.iconSm,
                            color: colors.success,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              check,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: colors.success,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.secondaryContainer,
                borderRadius: BorderRadius.circular(AppRadii.input),
                border: Border.all(
                  color: scheme.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xs),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            remainingLabel,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: scheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          Text(
                            math,
                            style: AppTextStyles.tabular(
                              Theme.of(context).textTheme.bodySmall!
                                  .copyWith(color: scheme.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          remaining,
                          style: AppTextStyles.tabular(
                            Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(
    BuildContext context,
    String label,
    String value, {
    required bool mono,
  }) {
    final style = mono
        ? AppTextStyles.mono(Theme.of(context).textTheme.bodySmall!)
        : AppTextStyles.tabular(
            Theme.of(context).textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w700),
          );
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(value, style: style),
            ),
          ),
        ],
      ),
    );
  }
}
