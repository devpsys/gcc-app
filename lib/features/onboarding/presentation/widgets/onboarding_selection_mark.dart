import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';

class OnboardingSelectionMark extends StatelessWidget {
  const OnboardingSelectionMark({required this.selected, super.key});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ExcludeSemantics(
      child: selected
          ? DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.primary,
                shape: BoxShape.circle,
              ),
              child: SizedBox.square(
                dimension: AppDimensions.iconLg,
                child: Icon(
                  Icons.check,
                  size: AppDimensions.iconSm,
                  color: scheme.onPrimary,
                ),
              ),
            )
          : DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: scheme.outline),
              ),
              child: const SizedBox.square(dimension: AppDimensions.iconMd),
            ),
    );
  }
}
