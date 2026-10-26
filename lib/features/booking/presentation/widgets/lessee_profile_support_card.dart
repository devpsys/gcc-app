import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// Support line row with Call action (MOB-LSE-17).
class LesseeProfileSupportCard extends StatelessWidget {
  const LesseeProfileSupportCard({
    required this.phone,
    required this.onCall,
    super.key,
  });

  final String phone;
  final VoidCallback? onCall;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
        child: Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.phone_outlined,
                  size: AppDimensions.iconMd,
                  color: scheme.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.lesseeProfileSupport,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        phone,
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: onCall,
              style: TextButton.styleFrom(
                foregroundColor: scheme.primary,
                disabledForegroundColor: scheme.primary,
                visualDensity: VisualDensity.compact,
              ),
              child: Text(
                l10n.lesseeProfileCallSupport,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
