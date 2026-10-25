import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// Filter chip for the bookings suite, with an optional counter badge.
class LesseeBookingsFilterChip extends StatelessWidget {
  const LesseeBookingsFilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    this.count,
    super.key,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final int? count;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final semanticsLabel = count == null ? label : '$label $count';
    return Semantics(
      button: true,
      selected: selected,
      label: semanticsLabel,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => onSelected(!selected),
          customBorder: const StadiumBorder(),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: AppDimensions.minTouchTarget,
              minWidth: AppDimensions.minTouchTarget,
            ),
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: selected ? scheme.primaryContainer : scheme.surface,
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                  border: Border.all(
                    color: selected
                        ? scheme.primary.withValues(alpha: 0.35)
                        : scheme.outline,
                  ),
                ),
                child: SizedBox(
                  height: AppDimensions.wizardStepHeight + AppSpacing.xxs,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          label,
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: selected
                                    ? scheme.secondary
                                    : scheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                        ),
                        if (count != null) ...[
                          const SizedBox(width: AppSpacing.tight),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: scheme.primary,
                              borderRadius: BorderRadius.circular(
                                AppRadii.pill,
                              ),
                            ),
                            child: SizedBox(
                              height: 18,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.xxs + 1,
                                ),
                                child: Center(
                                  child: Text(
                                    '$count',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.tabular(
                                      Theme.of(context).textTheme.labelSmall!
                                          .copyWith(
                                            color: scheme.onPrimary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                            height: 1,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
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
