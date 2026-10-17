import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// One settings row: icon tile, label, trailing value, and a chevron when it
/// opens something.
///
/// The whole row is the target. The profile design draws these at 56 px inside
/// a grouped card.
class SettingsRow extends StatelessWidget {
  const SettingsRow({
    required this.label,
    this.value,
    this.onTap,
    this.trailing,
    this.detail,
    this.icon,
    this.destructive = false,
    super.key,
  });

  final String label;

  /// e.g. `English`. Omitted when there is nothing to show.
  final String? value;

  /// Second line under the label, e.g. `Map cache: 1.8 GB`.
  final String? detail;

  /// Null leaves the row inert: it still shows, but accepts no tap. A row that
  /// swallows a tap is worse than one that visibly does nothing yet.
  final VoidCallback? onTap;
  final Widget? trailing;
  final IconData? icon;

  /// Danger treatment for leaving the account.
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final valueText = value;
    final detailText = detail;
    final glyph = icon;
    final labelColor = destructive ? colors.danger : scheme.onSurface;
    final mark =
        trailing ??
        (onTap == null
            ? null
            : Icon(
                Icons.chevron_right,
                size: AppDimensions.iconSm,
                color: scheme.onSurfaceVariant,
              ));

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
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Row(
              children: [
                if (glyph != null) ...[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: destructive
                          ? colors.dangerContainer
                          : scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppRadii.button),
                    ),
                    child: SizedBox.square(
                      dimension: AppSpacing.xxl,
                      child: Icon(
                        glyph,
                        size: AppDimensions.iconSm,
                        color: destructive
                            ? colors.danger
                            : scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: labelColor,
                          fontWeight: destructive
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                      if (detailText != null)
                        Text(
                          detailText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                    ],
                  ),
                ),
                if (valueText != null) ...[
                  const SizedBox(width: AppSpacing.xs),
                  Flexible(
                    child: Text(
                      valueText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ),
                ],
                if (mark != null) ...[
                  const SizedBox(width: AppSpacing.xs),
                  mark,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
