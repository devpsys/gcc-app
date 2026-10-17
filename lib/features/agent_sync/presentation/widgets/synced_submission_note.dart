import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The reassurance shown once a submission is safely on the server.
///
/// States plainly that the data landed and what happens next. The bounty is
/// named but **not** locked: it unlocks on approval, it is not held funds.
class SyncedSubmissionNote extends StatelessWidget {
  const SyncedSubmissionNote({required this.bounty, super.key});

  /// The bounty that will unlock once the shop is approved.
  final String bounty;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.successContainer,
          borderRadius: BorderRadius.circular(AppRadii.cardLarge),
          border: Border.all(color: colors.success.withValues(alpha: 0.25)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.itemSentToReview,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.success,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                l10n.itemSentToReviewBody(bounty),
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
