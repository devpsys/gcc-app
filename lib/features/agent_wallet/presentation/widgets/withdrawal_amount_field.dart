import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';

/// The withdrawal amount entry, with a max shortcut.
///
/// The warning above it is the design's guardrail frame: it tells the agent the
/// minimum before they type, rather than failing them afterwards.
class WithdrawalAmountField extends StatelessWidget {
  const WithdrawalAmountField({
    required this.warning,
    required this.maxLabel,
    required this.maxAmount,
    required this.amount,
    required this.onChanged,
    required this.onMax,
    required this.submitLabel,
    this.onSubmit,
    super.key,
  });

  /// The guardrail message, or null when the amount is acceptable.
  final String? warning;

  /// e.g. `MAX ₦12,000`.
  final String maxLabel;
  final String maxAmount;

  /// e.g. `10,000`.
  final String amount;
  final ValueChanged<String> onChanged;
  final VoidCallback? onMax;
  final String submitLabel;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final warn = warning;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (warn != null)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: AppSpacing.md,
                  color: colors.warning,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    warn,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: colors.warning),
                  ),
                ),
              ],
            ),
          ),
        Text(
          l10n.walletAmountLabel,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: scheme.onSurfaceVariant,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: onChanged,
                decoration: InputDecoration(
                  prefixText: '₦ ',
                  hintText: '0',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadii.input),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            TextButton(
              onPressed: onMax,
              style: TextButton.styleFrom(
                foregroundColor: scheme.primary,
                minimumSize: const Size(88, AppDimensions.minTouchTarget),
              ),
              child: Text(
                maxLabel,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        AppPrimaryButton(
          label: submitLabel,
          expand: true,
          onPressed: warn != null ? null : onSubmit,
        ),
      ],
    );
  }
}
