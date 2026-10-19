import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// A filter option. A null [onSelected] leaves it unavailable.
class MarketplaceChoice extends StatelessWidget {
  const MarketplaceChoice({
    required this.label,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(
        right: AppSpacing.xs,
        bottom: AppSpacing.xs,
      ),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: onSelected == null ? null : (_) => onSelected!(),
        selectedColor: scheme.secondaryContainer,
        showCheckmark: false,
      ),
    );
  }
}
