import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/booking/presentation/bloc/handback_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/handback_state.dart';
import 'package:gcc_app/features/booking/presentation/widgets/handback_escrow_strip.dart';
import 'package:gcc_app/features/booking/presentation/widgets/handback_findings_list.dart';
import 'package:gcc_app/features/booking/presentation/widgets/handback_issue_sheet.dart';
import 'package:gcc_app/features/booking/presentation/widgets/handback_review_footer.dart';
import 'package:gcc_app/features/booking/presentation/widgets/handback_video_card.dart';
import 'package:gcc_app/features/booking/presentation/widgets/handback_watch_gate.dart';

class HandbackPage extends StatelessWidget {
  const HandbackPage({required this.state, super.key});

  final HandbackReady state;

  @override
  Widget build(BuildContext context) {
    final review = state.review;
    final cubit = context.read<HandbackCubit>();
    final colors = context.semanticColors;
    return Column(
      children: [
        Expanded(
          child: ListView(
            key: const Key('handback-review-body'),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.xs,
              AppSpacing.md,
              AppSpacing.md,
            ),
            children: [
              Text(
                review.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${review.yard} · ${review.reference}',
                style: AppTextStyles.tabular(
                  Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: colors.muted,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              HandbackVideoCard(
                review: review,
                watched: state.videoWatched,
                onPlay: cubit.completePlayback,
              ),
              const SizedBox(height: AppSpacing.sm),
              HandbackWatchGate(
                durationSeconds: review.durationSeconds,
                videoWatched: state.videoWatched,
                confirmed: state.confirmedWatched,
                onChanged: cubit.setConfirmedWatched,
              ),
              const SizedBox(height: AppSpacing.md),
              HandbackFindingsList(findings: review.findings),
              const SizedBox(height: AppSpacing.sm),
              HandbackEscrowStrip(review: review),
            ],
          ),
        ),
        HandbackReviewFooter(
          canApprove: state.canApprove,
          approving: state.approving,
          onSomethingWrong: () => _openIssue(context),
          onApprove: cubit.approve,
        ),
      ],
    );
  }

  Future<void> _openIssue(BuildContext context) async {
    final cubit = context.read<HandbackCubit>();
    final result = await showHandbackIssueSheet(
      context: context,
      maxClaim: state.review.deposit,
    );
    if (result == null || !context.mounted) {
      return;
    }
    await cubit.submitIssue(
      reason: result.reason,
      note: result.note,
      photoCount: result.photoCount,
      claimAmount: result.claimAmount,
    );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.handbackIssueSubmitted)),
      );
    }
  }
}
