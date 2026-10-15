import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_switch_track.dart';

/// Label-and-toggle row.
///
/// The designs draw their own switch rather than the platform control, so
/// this composes [AppSwitchTrack] — a 44 x 24 track with a 20 x 20 thumb —
/// inside a 48 x 48 tap target. The track keeps its designed proportions at
/// every viewport while staying reachable.
class AppToggleSwitch extends StatelessWidget {
  const AppToggleSwitch({
    required this.label,
    required this.value,
    required this.onChanged,
    this.caption,
    this.captionBesideSwitch = false,
    this.disabledReason,
    super.key,
  });

  final String label;
  final String? caption;

  /// Places [caption] on the trailing side of the row instead of under the
  /// label. Used where the design shows a short status word, e.g. "Always allow".
  final bool captionBesideSwitch;
  final bool value;

  /// Null renders the row disabled. Pair with [disabledReason] so the user can
  /// find out why.
  final ValueChanged<bool>? onChanged;
  final String? disabledReason;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final enabled = onChanged != null;
    final control = ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: AppDimensions.minTouchTarget,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: enabled ? scheme.onSurface : scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (caption != null && !captionBesideSwitch)
                  Text(
                    caption!,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
              ],
            ),
          ),
          if (caption != null && captionBesideSwitch) ...[
            Text(
              caption!,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: scheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
          ] else
            const SizedBox(width: AppSpacing.xs),
          SizedBox.square(
            dimension: AppDimensions.minTouchTarget,
            child: Center(
              child: AppSwitchTrack(
                value: value,
                onChanged: enabled ? onChanged : null,
              ),
            ),
          ),
        ],
      ),
    );
    final reason = disabledReason;
    if (enabled || reason == null) {
      return control;
    }
    return Tooltip(message: reason, child: control);
  }
}
