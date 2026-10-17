import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/bounty_submission.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/audit_timeline.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/bounty_amount_panel.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/bounty_headline.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/bounty_headline_banner.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/rejection_recovery_panel.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/reviewer_feedback_panel.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/submission_fact_grid.dart';

/// One submission's bounty status and audit trail.
///
/// Three frames, matching the designs: awaiting verification, verified, and a
/// recoverable rejection.
///
/// This is the only screen in the app where a lock glyph appears, and only on
/// the awaiting frame — that is when GCC is genuinely holding the money. The
/// lock is derived from the status rather than passed in, so it cannot leak
/// onto the verified or rejected frames where the designs forbid it.
class BountyStatusPage extends StatelessWidget {
  const BountyStatusPage({
    required this.submission,
    this.onResubmit,
    this.onDiscard,
    this.onViewSubmission,
    this.onViewInQueue,
    super.key,
  });

  final BountySubmission submission;
  final VoidCallback? onResubmit;
  final VoidCallback? onDiscard;
  final VoidCallback? onViewSubmission;
  final VoidCallback? onViewInQueue;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final rejected = isRejected(submission.status);
    final headline = submission.headline;

    return Scaffold(
      appBar: AppBar(
        title: Text(submission.reference),
        backgroundColor: scheme.surface,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text(
              submission.shopName.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              submission.assetSummary,
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.bodyMedium!
                    .copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              submission.shopName,
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              submission.location,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 2),
            Text(
              submission.coordinates,
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.labelSmall!
                    .copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
            if (headline != null) ...[
              const SizedBox(height: AppSpacing.sm),
              BountyHeadlineBanner(
                status: submission.status,
                message: headline,
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            BountyAmountPanel(
              status: submission.status,
              amount: submission.bountyAmount,
              note: submission.bountyNote,
              disclaimer: submission.disclaimer,
            ),
            if (rejected && submission.reviewer != null) ...[
              const SizedBox(height: AppSpacing.sm),
              ReviewerFeedbackPanel(
                reviewer: submission.reviewer!,
                rejectedAt: submission.reviewerRejectedAt ?? '',
                message: l10n.bountyReshootCta,
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            AuditTimeline(events: submission.timeline),
            const SizedBox(height: AppSpacing.sm),
            SubmissionFactGrid(
              assetCount: submission.rejectedAssetCount,
              media: '2 files · 7.6 MB',
              reviewer: submission.reviewer ?? 'Ibrahim Musa · AG-0142',
            ),
            const SizedBox(height: AppSpacing.md),
            if (rejected)
              RejectionRecoveryPanel(
                newReference: 'SUB-2231',
                resubmitLabel: l10n.bountyReshootResubmit,
                discardLabel: l10n.bountyDiscardSubmission,
                onResubmit: onResubmit,
                onDiscard: onDiscard,
              )
            else
              Row(
                children: [
                  Expanded(
                    child: AppPrimaryButton(
                      label: l10n.bountyViewSubmission,
                      expand: true,
                      onPressed: onViewSubmission,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: AppSecondaryButton(
                      label: l10n.bountyViewInQueue,
                      expand: true,
                      onPressed: onViewInQueue,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              headlineFor(l10n, submission.status),
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(color: colors.muted),
            ),
          ],
        ),
      ),
    );
  }
}
