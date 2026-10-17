import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';

class ScannerActionRow extends StatelessWidget {
  const ScannerActionRow({
    required this.dividerLabel,
    required this.actionLabel,
    required this.helpText,
    this.onScan,
    this.disabledReason,
    super.key,
  });

  final String dividerLabel;
  final String actionLabel;
  final String helpText;
  final VoidCallback? onScan;
  final String? disabledReason;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final label = Theme.of(context).textTheme.labelSmall;
    return ColoredBox(
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.sm,
          AppSpacing.sm,
          AppSpacing.sm,
          AppSpacing.md,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Divider(color: scheme.outlineVariant)),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                    child: Text(
                      dividerLabel,
                      textAlign: TextAlign.center,
                      style: label == null ? null : AppTextStyles.mono(label),
                    ),
                  ),
                ),
                Expanded(child: Divider(color: scheme.outlineVariant)),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            AppSecondaryButton(
              label: actionLabel,
              icon: Icons.qr_code_2_outlined,
              onPressed: onScan,
              disabledReason: disabledReason,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              helpText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
