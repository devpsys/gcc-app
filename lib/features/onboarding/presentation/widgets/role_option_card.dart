import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/onboarding/presentation/widgets/onboarding_selection_mark.dart';

class RoleOptionCard extends StatelessWidget {
  const RoleOptionCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String title;
  final String description;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final descriptionStyle = Theme.of(context).textTheme.bodySmall
        ?.copyWith(color: selected ? scheme.onSurface : null);
    return Semantics(
      selected: selected,
      button: true,
      label: title,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.dialog),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: selected ? scheme.secondaryContainer : scheme.surface,
              borderRadius: BorderRadius.circular(AppRadii.dialog),
              border: Border.all(
                color: selected ? scheme.primary : scheme.outline,
                width: selected
                    ? AppDimensions.emphasisBorderWidth
                    : AppDimensions.borderWidth,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        icon,
                        size: AppDimensions.iconLg,
                        color: selected
                            ? scheme.primary
                            : scheme.onSurfaceVariant,
                      ),
                      const Spacer(),
                      OnboardingSelectionMark(selected: selected),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.sm),
                  Text(description, style: descriptionStyle),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
