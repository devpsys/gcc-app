import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// A bordered, lettered section on the review screen.
///
/// Sections carry an eyebrow heading and an optional trailing action. Rows
/// inside are supplied by the caller so each section keeps its own layout while
/// sharing the heading treatment.
class ReviewSection extends StatelessWidget {
  const ReviewSection({
    required this.eyebrow,
    required this.children,
    this.actionLabel,
    this.onAction,
    this.alert = false,
    super.key,
  });

  final String eyebrow;
  final List<Widget> children;
  final String? actionLabel;
  final VoidCallback? onAction;

  /// Renders the trailing action as the design's `Fix now` affordance.
  final bool alert;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final action = actionLabel;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
        border: Border.all(
          color: alert ? colors.dangerBorder : context.semanticColors.border,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: context.semanticColors.border),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          eyebrow.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: alert
                                    ? colors.danger
                                    : scheme.onSurfaceVariant,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      if (action != null)
                        TextButton(
                          onPressed: onAction,
                          style: TextButton.styleFrom(
                            minimumSize: const Size(0, 0),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.xs,
                            ),
                            foregroundColor: alert
                                ? colors.danger
                                : scheme.primary,
                          ),
                          child: Text(
                            action,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: alert ? colors.danger : scheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            for (final child in children) child,
            if (alert)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xs),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: AppDimensions.iconSm,
                      color: colors.danger,
                    ),
                    const SizedBox(width: AppSpacing.tight),
                    Expanded(
                      child: Text(
                        l10n.reviewLandmarkMissingWhy,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: colors.danger),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// A label and value pair inside a review section.
class ReviewFieldRow extends StatelessWidget {
  const ReviewFieldRow({
    required this.label,
    required this.value,
    this.mono = false,
    this.muted = false,
    super.key,
  });

  final String label;
  final String value;

  /// Renders the value in monospace, for IDs and coordinates.
  final bool mono;

  /// Dims the value, used for a field that is missing.
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label,
              style: style?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              value,
              style: style?.copyWith(
                color: muted ? scheme.onSurfaceVariant : scheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
