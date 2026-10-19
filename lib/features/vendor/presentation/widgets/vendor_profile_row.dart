import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// One profile row. A row with no [onTap] shows its value and does not accept a tap.
class VendorProfileRow extends StatelessWidget {
  const VendorProfileRow({
    required this.icon,
    required this.label,
    this.value,
    this.onTap,
    this.mono = false,
    this.verified = false,
    this.destructive = false,
    this.showChevron = true,
    super.key,
  });

  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback? onTap;
  final bool mono;
  final bool verified;
  final bool destructive;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final valueText = value;
    final labelColor = destructive ? colors.danger : scheme.onSurface;
    final iconColor = destructive ? colors.danger : scheme.onSurfaceVariant;
    return Semantics(
      button: onTap != null,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppDimensions.topBarHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: destructive
                        ? colors.dangerContainer
                        : scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppRadii.button),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xxs),
                    child: Icon(
                      icon,
                      size: AppDimensions.iconMd,
                      color: iconColor,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: labelColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (verified) ...[
                  Icon(
                    Icons.check_circle,
                    size: AppDimensions.iconSm,
                    color: colors.success,
                  ),
                  const SizedBox(width: AppSpacing.xxs),
                ],
                if (valueText != null)
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        valueText,
                        style: mono
                            ? AppTextStyles.mono(
                                Theme.of(context).textTheme.bodySmall!
                                    .copyWith(color: scheme.onSurfaceVariant),
                              )
                            : Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ),
                  ),
                if (onTap != null && showChevron) ...[
                  const SizedBox(width: AppSpacing.xxs),
                  Icon(
                    Icons.chevron_right,
                    size: AppDimensions.iconSm,
                    color: scheme.onSurfaceVariant,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
