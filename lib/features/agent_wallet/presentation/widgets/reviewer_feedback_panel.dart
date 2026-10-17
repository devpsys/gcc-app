import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// Reviewer feedback on a rejected submission.
///
/// Rejection is recoverable, so this states what went wrong and offers the way
/// to fix it. It is never a bare "failed" message: the agent is owed an
/// actionable reason.
class ReviewerFeedbackPanel extends StatelessWidget {
  const ReviewerFeedbackPanel({
    required this.reviewer,
    required this.rejectedAt,
    required this.message,
    super.key,
  });

  /// e.g. `Amaka Obi`.
  final String reviewer;

  /// e.g. `13 Oct, 14:15`.
  final String rejectedAt;

  /// Why the submission was refused.
  final String message;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.dangerContainer,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
        border: Border.all(color: colors.dangerBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.rate_review_outlined,
                  size: AppSpacing.md,
                  color: colors.danger,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  l10n.bountyReviewerFeedback,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.danger,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              l10n.bountyReviewerLine(reviewer, rejectedAt),
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.labelSmall!
                    .copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
