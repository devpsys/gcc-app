import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The needs-attention shortcut, which reads as a warning even unselected.
///
/// An agent scanning for problems should be able to see the filter that finds
/// them without opening it first.
class WarningFilterChip extends StatelessWidget {
  const WarningFilterChip({
    required this.label,
    required this.onSelected,
    super.key,
  });

  final String label;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    return Semantics(
      button: true,
      selected: false,
      child: InkWell(
        onTap: () => onSelected(true),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        child: Container(
          constraints: const BoxConstraints(minHeight: 36),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          decoration: BoxDecoration(
            color: colors.warningContainer,
            borderRadius: BorderRadius.circular(AppRadii.pill),
            border: Border.all(color: colors.warning),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: AppSpacing.lg,
                color: colors.warning,
              ),
              const SizedBox(width: AppSpacing.tight),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.warning,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
