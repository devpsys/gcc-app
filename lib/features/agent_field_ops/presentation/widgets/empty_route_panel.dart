import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

// The empty state for an assignment with no stops on it.
///
/// Separate from the completed panel: no stops assigned is a supervisor's
/// problem to fix, not an achievement.
class EmptyRoutePanel extends StatelessWidget {
  const EmptyRoutePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            shape: BoxShape.circle,
            border: Border.all(color: context.semanticColors.border),
          ),
          child: SizedBox.square(
            dimension: AppDimensions.emptyStateIcon,
            child: Icon(
              Icons.assignment_outlined,
              size: AppDimensions.iconLg * 1.5,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          l10n.shopsEmptyTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.xs),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Text(
            l10n.shopsEmptyDesc,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
