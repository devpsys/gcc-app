import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class AgentHerePulse extends StatelessWidget {
  const AgentHerePulse({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.primary.withValues(alpha: 0.18),
          shape: BoxShape.circle,
          border: Border.all(color: scheme.primary.withValues(alpha: 0.4)),
        ),
        child: SizedBox.square(
          dimension: AppSpacing.huge,
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.primary,
                shape: BoxShape.circle,
                border: Border.all(color: scheme.surface, width: 2),
              ),
              child: const SizedBox.square(dimension: AppSpacing.md),
            ),
          ),
        ),
      ),
    );
  }
}
