import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// One tappable settings row: a label, a value, and an optional trailing glyph.
///
/// The whole row is the target, not just the chevron — the designs set a 48 px
/// minimum for every control and this is the most-tapped element on the screen.
class SettingsRow extends StatelessWidget {
  const SettingsRow({
    required this.label,
    this.value,
    this.onTap,
    this.trailing,
    this.detail,
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

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final valueText = value;
    final detailText = detail;

    return Semantics(
      button: onTap != null,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: AppDimensions.minTouchTarget,
          ),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: context.semanticColors.border),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(label, style: Theme.of(context).textTheme.bodyMedium),
                    if (detailText != null)
                      Text(
                        detailText,
                        style: Theme.of(context).textTheme.labelSmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                  ],
                ),
              ),
              if (valueText != null) ...[
                const SizedBox(width: AppSpacing.xs),
                Text(
                  valueText,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ],
              const SizedBox(width: AppSpacing.tight),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}
