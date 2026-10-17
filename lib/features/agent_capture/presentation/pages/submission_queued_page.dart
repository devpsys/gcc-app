import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/daily_milestone_banner.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/submission_detail_list.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/submission_success_mark.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/what_happens_next.dart';

/// What became of a submitted capture.
///
/// [uploaded] is the design's online frame — the bytes have reached review.
/// [queued] is its offline twin, where the capture is safely on the device and
/// will upload itself.
enum SubmissionOutcome { uploaded, queued }

/// Terminal screen of the capture wizard.
///
/// Deliberately carries no danger styling anywhere: nothing has gone wrong, and
/// the bounty is pending rather than held, so there is no lock glyph and no
/// escrow treatment.
///
/// Every exit leaves the wizard rather than stepping back into it. A submitted
/// draft is locked for editing, so stepping "back" to the review screen would
/// offer an agent a resubmit button that cannot work.
class SubmissionQueuedPage extends StatelessWidget {
  const SubmissionQueuedPage({
    this.outcome = SubmissionOutcome.uploaded,
    this.shopsToday = 1,
    this.onCaptureAnother,
    this.onBackToToday,
    this.onViewQueue,
    super.key,
  });

  final SubmissionOutcome outcome;

  /// Shops captured today, shown in the design's milestone frame.
  final int shopsToday;
  final VoidCallback? onCaptureAnother;
  final VoidCallback? onBackToToday;
  final VoidCallback? onViewQueue;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final queued = outcome == SubmissionOutcome.queued;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  if (shopsToday > 1) ...[
                    DailyMilestoneBanner(shopsToday: shopsToday),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  Center(child: const SubmissionSuccessMark()),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    l10n.queuedTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    l10n.queuedShopLine('Kugbo Market', 'Bola Hardware'),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.mono(
                      Theme.of(context).textTheme.bodyMedium!
                          .copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    queued
                        ? l10n.queuedOfflineHeadline
                        : l10n.queuedUploadedHeadline,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    queued
                        ? l10n.queuedStepQueued
                        : l10n.queuedVerificationNote,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  SubmissionDetailList(
                    reference: 'SUB-2214',
                    captured: '13 Oct, 10:42',
                    assets: '3',
                    media: '2 files · 7.6 MB',
                    bounty: '₦5,000',
                    queued: queued,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  WhatHappensNext(queued: queued),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppPrimaryButton(
                    label: l10n.queuedCaptureAnother,
                    expand: true,
                    onPressed:
                        onCaptureAnother ?? () => _captureAnother(context),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  AppSecondaryButton(
                    label: l10n.queuedBackToToday,
                    expand: true,
                    onPressed: onBackToToday ?? () => _leaveWizard(context),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  SizedBox(
                    height: AppDimensions.minTouchTarget,
                    child: TextButton(
                      onPressed: onViewQueue ?? () => _viewQueue(context),
                      child: Text(
                        l10n.queuedViewQueue,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colors.info,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  /// Starts a new capture from step 1.
  ///
  /// `go` rather than `push`: the submitted wizard must not stay on the stack,
  /// or a system back gesture would walk an agent into a locked review screen.
  /// The draft is reset first so step 1 opens empty instead of showing the
  /// shop that was just submitted.
  void _captureAnother(BuildContext context) {
    context.read<CaptureCubit>().startNewCapture();
    GoRouter.maybeOf(context)?.go(RoutePaths.captureShop);
  }

  /// Leaves the wizard for today's work list.
  void _leaveWizard(BuildContext context) {
    GoRouter.maybeOf(context)?.go(RoutePaths.agentToday);
  }

  /// Goes to the offline queue, where this submission is now waiting.
  void _viewQueue(BuildContext context) {
    GoRouter.maybeOf(context)?.go(RoutePaths.agentQueue);
  }
}
