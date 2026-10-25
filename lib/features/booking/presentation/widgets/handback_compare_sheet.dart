import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';
import 'package:gcc_app/features/booking/domain/handback_review.dart';

Future<void> showHandbackCompareSheet({
  required BuildContext context,
  required HandbackReview review,
}) {
  return showAppSheet<void>(
    context: context,
    title: context.l10n.handbackCompareCheckout,
    closeLabel: context.l10n.authClose,
    child: HandbackCompareSheet(review: review),
  );
}

class HandbackCompareSheet extends StatelessWidget {
  const HandbackCompareSheet({required this.review, super.key});

  final HandbackReview review;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.handbackCompareBody,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          _clipCard(
            context,
            badge: l10n.handbackCompareCheckoutBadge,
            when: l10n.handbackCompareCheckoutWhen,
          ),
          const SizedBox(height: AppSpacing.xs),
          _clipCard(
            context,
            badge: l10n.handbackCheckInBadge,
            when: review.recordedAtLabel,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.handbackComparePlaybackUnavailable,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colors.muted,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${review.reference} · ${review.yard}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: scheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _clipCard(
    BuildContext context, {
    required String badge,
    required String when,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.button),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            Icon(
              Icons.videocam_outlined,
              size: AppDimensions.iconMd,
              color: scheme.primary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    badge.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    when,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.muted,
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
