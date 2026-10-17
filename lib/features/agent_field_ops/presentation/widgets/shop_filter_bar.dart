import 'package:flutter/material.dart';
import 'package:gcc_app/core/widgets/app_choice_chip.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/warning_filter_chip.dart';

/// One tappable filter in the all-assignment bar.
class ShopFilterChip extends StatelessWidget {
  const ShopFilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    this.warning = false,
    super.key,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  /// Renders in the warning tone, for the needs-attention shortcut.
  final bool warning;

  @override
  Widget build(BuildContext context) {
    if (warning && !selected) {
      return WarningFilterChip(label: label, onSelected: onSelected);
    }
    return AppChoiceChip(
      label: label,
      selected: selected,
      onSelected: onSelected,
    );
  }
}
