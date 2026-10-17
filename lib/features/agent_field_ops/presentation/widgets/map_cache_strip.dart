import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The strip under the app bar that says what the map has available.
///
/// Three honest states: cached and offline, refreshing right now, and out of
/// the cached region. The copy never claims tiles exist when they do not.
class MapCacheStrip extends StatelessWidget {
  const MapCacheStrip({
    required this.label,
    required this.onAction,
    required this.actionLabel,
    this.tone,
    super.key,
  });

  final String label;
  final String actionLabel;
  final VoidCallback? onAction;

  /// Overrides the tone; null picks the warning tone the design uses.
  final Color? tone;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final resolved = tone ?? colors.warning;
    return Container(
      color: colors.warningContainer,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          Icon(Icons.cloud_off_outlined, size: AppSpacing.lg, color: resolved),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              label,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: resolved, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: AppDimensions.buttonHeightCompact,
            child: TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(foregroundColor: resolved),
              child: Text(
                actionLabel,
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: resolved, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
