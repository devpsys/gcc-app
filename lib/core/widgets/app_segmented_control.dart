import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_segment_option.dart';
import 'package:gcc_app/core/widgets/app_segment_style.dart';

class AppSegmentedControl<T> extends StatelessWidget {
  const AppSegmentedControl({
    required this.options,
    required this.onChanged,
    this.selected,
    this.style = AppSegmentStyle.raised,
    super.key,
  });

  final List<AppSegmentOption<T>> options;
  final ValueChanged<T> onChanged;
  final T? selected;

  /// Appearance variant; see [AppSegmentStyle].
  final AppSegmentStyle style;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final filled = style == AppSegmentStyle.filled;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(
          filled ? AppRadii.dialog : AppRadii.input,
        ),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxs),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var index = 0; index < options.length; index++) ...[
                if (index > 0)
                  SizedBox(width: filled ? AppSpacing.xxs : AppSpacing.tight),
                Expanded(child: _segment(context, options[index], scheme)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _segment(
    BuildContext context,
    AppSegmentOption<T> option,
    ColorScheme scheme,
  ) {
    final isSelected = option.value == selected;
    final radius = BorderRadius.circular(AppRadii.input);
    final filled = style == AppSegmentStyle.filled;
    // The design draws the selected segment as a raised white tile with a
    // 2 px brand edge. Unselected segments are bare — no fill, no edge — so
    // the group reads as one control rather than three separate buttons. A
    // null `color`/`border` leaves the track showing through.
    final fill = isSelected
        ? (filled ? scheme.secondaryContainer : scheme.surface)
        : null;
    final edge = isSelected
        ? Border.all(
            color: scheme.primary,
            width: filled
                ? AppDimensions.borderWidth
                : AppDimensions.borderWidth * 2,
          )
        : null;
    return Semantics(
      button: true,
      selected: isSelected,
      label: option.label,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: fill,
          borderRadius: radius,
          border: edge,
        ),
        child: Material(
          type: MaterialType.transparency,
          borderRadius: radius,
          child: InkWell(
            onTap: () => onChanged(option.value),
            customBorder: RoundedRectangleBorder(borderRadius: radius),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: filled
                    ? AppDimensions.minTouchTarget
                    : AppDimensions.minTouchTarget - AppSpacing.xs,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxs,
                  vertical: AppSpacing.xxs,
                ),
                child: Center(
                  child: Text(
                    option.label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: isSelected
                          ? scheme.primary
                          : scheme.onSurfaceVariant,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
