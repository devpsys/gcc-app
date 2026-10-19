import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';

/// The basic-phone code. Copy is the action; nothing here places a call.
class VendorUssdCard extends StatelessWidget {
  const VendorUssdCard({
    required this.eyebrow,
    required this.beforeCode,
    required this.code,
    required this.afterCode,
    required this.detail,
    required this.copyLabel,
    required this.onCopy,
    super.key,
  });

  final String eyebrow;
  final String beforeCode;
  final String code;
  final String afterCode;
  final String detail;
  final String copyLabel;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.infoContainer,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.info.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.phone,
                  size: AppDimensions.iconSm,
                  color: colors.info,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    eyebrow.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.info,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(text: beforeCode),
                  TextSpan(
                    text: code,
                    style: AppTextStyles.mono(
                      Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextSpan(text: afterCode),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              detail,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppSecondaryButton(
              label: copyLabel,
              icon: Icons.copy,
              onPressed: onCopy,
            ),
          ],
        ),
      ),
    );
  }
}
