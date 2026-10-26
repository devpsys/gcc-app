import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Dual-authority prompt with a Switch mode action (MOB-LSE-17).
class LesseeRoleCard extends StatelessWidget {
  const LesseeRoleCard({
    required this.eyebrow,
    required this.body,
    required this.switchLabel,
    required this.onAskSwitch,
    super.key,
  });

  final String eyebrow;
  final String body;
  final String switchLabel;
  final VoidCallback onAskSwitch;

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
        child: Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.55,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eyebrow.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    body,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.9,
              ),
              child: Material(
                color: scheme.secondaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.button),
                  side: BorderSide(
                    color: scheme.primary.withValues(alpha: 0.25),
                  ),
                ),
                child: InkWell(
                  onTap: onAskSwitch,
                  borderRadius: BorderRadius.circular(AppRadii.button),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            switchLabel,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  color: scheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xxs),
                        Icon(
                          Icons.swap_horiz,
                          size: AppDimensions.iconSm,
                          color: scheme.primary,
                        ),
                      ],
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
