import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_segment_option.dart';
import 'package:gcc_app/core/widgets/app_segmented_control.dart';

/// Which slice of the assignment the agent is looking at.
///
/// Today is the default because that is what a field agent opens the app for;
/// All widens to the whole assignment.
class ShopScopeBar extends StatelessWidget {
  const ShopScopeBar({
    required this.todayLabel,
    required this.allLabel,
    required this.onChanged,
    this.selected,
    super.key,
  });

  final String todayLabel;
  final String allLabel;
  final ValueChanged<bool> onChanged;

  /// `true` for today's route, `false` for the whole assignment.
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: AppSegmentedControl<bool>(
        options: [
          AppSegmentOption(value: true, label: todayLabel),
          AppSegmentOption(value: false, label: allLabel),
        ],
        selected: selected,
        onChanged: onChanged,
      ),
    );
  }
}
