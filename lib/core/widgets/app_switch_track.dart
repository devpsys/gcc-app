import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_elevation.dart';
import 'package:gcc_app/core/theme/app_radii.dart';

/// The designed toggle: a 44 x 24 pill track carrying a 20 x 20 white thumb.
///
/// Sized to the track rather than the tap target, so callers own the 48 x 48
/// hit area — that is what keeps the smaller, design-accurate control
/// reachable without changing its proportions at any viewport.
///
/// Prefer [AppToggleSwitch], which composes this with a label and handles
/// disabled reasons.
class AppSwitchTrack extends StatelessWidget {
  const AppSwitchTrack({required this.value, this.onChanged, super.key});

  final bool value;

  /// Null renders the track disabled and greys the fill.
  final ValueChanged<bool>? onChanged;

  /// Resting travel of the thumb from the track's leading edge.
  static const double thumbInset = 2;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final enabled = onChanged != null;

    final track = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: AppDimensions.switchTrackWidth,
      height: AppDimensions.switchTrackHeight,
      padding: const EdgeInsets.only(left: thumbInset),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: value
            ? scheme.primary
            : (enabled ? scheme.outline : scheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: AppDimensions.switchThumbSize,
          height: AppDimensions.switchThumbSize,
          decoration: BoxDecoration(
            color: scheme.surface,
            shape: BoxShape.circle,
            boxShadow: AppElevation.thumb,
          ),
        ),
      ),
    );

    if (!enabled) {
      return Opacity(opacity: 0.5, child: track);
    }
    return Semantics(
      toggled: value,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onChanged!(!value),
        child: track,
      ),
    );
  }
}
