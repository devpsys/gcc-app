import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// One tappable profile row matching MOB-LSE-17 list density.
class LesseeProfileRow extends StatelessWidget {
  const LesseeProfileRow({
    required this.icon,
    required this.label,
    this.value,
    this.badge,
    this.onTap,
    this.iconColor,
    super.key,
  });

  final IconData icon;
  final String label;
  final String? value;
  final String? badge;
  final VoidCallback? onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final valueText = value;
    final badgeText = badge;
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: AppDimensions.minTouchTarget,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: AppDimensions.iconMd,
                color: iconColor ?? scheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (badgeText != null) ...[
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(AppRadii.pill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                      vertical: 2,
                    ),
                    child: Text(
                      badgeText,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
              ] else if (valueText != null) ...[
                Flexible(
                  child: Text(
                    valueText,
                    textAlign: TextAlign.end,
                    style: AppTextStyles.mono(
                      Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
              if (onTap != null)
                Icon(
                  Icons.chevron_right,
                  size: AppDimensions.iconSm,
                  color: scheme.onSurfaceVariant,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
