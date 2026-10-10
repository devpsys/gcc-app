import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class FirstRunStepIndicator extends StatelessWidget {
  const FirstRunStepIndicator({required this.step, super.key});

  static const int stepCount = 3;

  final int step;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label: context.l10n.onboardingStep(step + 1, stepCount),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var index = 0; index < stepCount; index++) ...[
            if (index > 0) const SizedBox(width: AppSpacing.xs),
            DecoratedBox(
              decoration: BoxDecoration(
                color: index <= step ? scheme.primary : scheme.outline,
                shape: BoxShape.circle,
              ),
              child: const SizedBox.square(dimension: AppSpacing.xs),
            ),
          ],
        ],
      ),
    );
  }
}
