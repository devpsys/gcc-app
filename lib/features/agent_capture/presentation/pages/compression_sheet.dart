import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';
import 'package:gcc_app/l10n/app_localizations.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/media_pipeline.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/compression_quality_selector.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/compression_video_preview.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/pipeline_note_panel.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/pipeline_step_list.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/storage_breakdown_panel.dart';

/// Presents the media pipeline over the capture flow.
///
/// The design's five frames — compressing, queued, uploading, storage low and
/// battery low — are one sheet with one shared body, because an agent must
/// never have to re-enter a flow to find out why a clip has not uploaded.
///
/// Resolves to `true` when the agent chooses to carry on to review, and `false`
/// when they pick a background option instead. The caller awaits the dismissal
/// before navigating, so a push never races the sheet animating out.
Future<bool?> showCompressionSheet(
  BuildContext context, {
  MediaPipelineStage stage = MediaPipelineStage.compressing,
  CompressionQuality initialQuality = CompressionQuality.smallest,
}) {
  final l10n = context.l10n;
  return showAppSheet<bool>(
    context: context,
    title: stage == MediaPipelineStage.uploading
        ? l10n.compressTitleUploading
        : l10n.compressTitle,
    child: CompressionSheet(stage: stage, initialQuality: initialQuality),
  );
}

/// Compression and upload status for the condition clip.
///
/// Nothing here is a money state. The design is explicit that a pending bounty
/// is not held funds, so no row, chip or badge may carry a lock glyph — that
/// rule is why [MediaPipelineStage] has no held-money variant.
class CompressionSheet extends StatelessWidget {
  const CompressionSheet({
    required this.stage,
    this.initialQuality = CompressionQuality.smallest,
    this.onFinished,
    super.key,
  });

  final MediaPipelineStage stage;
  final CompressionQuality initialQuality;

  /// Overrides what the actions do. Used by tests to observe the choice
  /// without popping a real route; the default pops with the decision.
  final ValueChanged<bool>? onFinished;

  static const int _compressPercent = 65;
  static const int _compressSeconds = 8;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CompressionVideoPreview(),
                  const SizedBox(height: AppSpacing.sm),
                  PipelineStepList(steps: _steps(l10n)),
                  const SizedBox(height: AppSpacing.sm),
                  if (stage == MediaPipelineStage.storageLow)
                    StorageBreakdownPanel(
                      requiredLabel: '180 MB',
                      freeLabel: '60 MB',
                      usages: StorageBreakdownPanel.defaultUsages,
                    )
                  else
                    PipelineNotePanel(stage: stage),
                  const SizedBox(height: AppSpacing.md),
                  CompressionQualitySelector(
                    selected: initialQuality,
                    onChanged: (_) {},
                  ),
                ],
              ),
            ),
          ),
          _actions(context),
        ],
      ),
    );
  }

  /// The design's step list for the current stage.
  List<PipelineStep> _steps(AppLocalizations l10n) => [
    PipelineStep(
      label: l10n.compressStepOptimised,
      state: PipelineStepState.done,
      sizePair: ('30.4 MB', '6.2 MB'),
    ),
    switch (stage) {
      MediaPipelineStage.compressing => PipelineStep(
        label: l10n.compressStepCompressing(_compressSeconds),
        state: PipelineStepState.running,
        detail: l10n.compressProgress(_compressPercent),
        progress: _compressPercent / 100,
      ),
      MediaPipelineStage.uploading => PipelineStep(
        label: l10n.compressUploadingDetail('3.2 MB', '6.2 MB'),
        state: PipelineStepState.running,
        detail: l10n.compressProgress(52),
        progress: 0.52,
      ),
      MediaPipelineStage.batteryLow => PipelineStep(
        label: l10n.compressStepPaused,
        state: PipelineStepState.waiting,
        detail: l10n.compressBatteryBadge,
      ),
      MediaPipelineStage.queued ||
      MediaPipelineStage.storageLow => PipelineStep(
        label: l10n.compressStepQueued,
        state: PipelineStepState.waiting,
        detail: l10n.compressQueuedBadge,
      ),
    },
    if (stage == MediaPipelineStage.batteryLow)
      PipelineStep(
        label: l10n.compressStepSaved,
        state: PipelineStepState.done,
      ),
    if (stage == MediaPipelineStage.compressing)
      PipelineStep(
        label: l10n.compressStepUploading,
        state: PipelineStepState.pending,
      ),
  ];

  Widget _actions(BuildContext context) {
    final l10n = context.l10n;
    // `true` carries the agent on to review; `false` is a background path that
    // deliberately leaves them on this step.
    void finish(bool proceed) {
      final handler = onFinished;
      if (handler != null) {
        handler(proceed);
        return;
      }
      Navigator.of(context).pop(proceed);
    }

    if (stage == MediaPipelineStage.storageLow) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppPrimaryButton(
            label: l10n.compressFreeUpSpace,
            expand: true,
            onPressed: () => finish(true),
          ),
          const SizedBox(height: AppSpacing.xs),
          TextButton(
            onPressed: () => finish(false),
            style: TextButton.styleFrom(
              minimumSize: const Size(
                double.infinity,
                AppDimensions.minTouchTarget,
              ),
            ),
            child: Text(l10n.compressUploadLater),
          ),
        ],
      );
    }
    final uploading = stage == MediaPipelineStage.uploading;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppPrimaryButton(
          label: uploading ? l10n.compressWaitForUpload : l10n.compressContinue,
          expand: true,
          onPressed: () => finish(true),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextButton(
          onPressed: () => finish(false),
          style: TextButton.styleFrom(
            minimumSize: const Size(
              double.infinity,
              AppDimensions.minTouchTarget,
            ),
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: Text(
            uploading
                ? l10n.compressContinueBackground
                : l10n.compressChooseQuality,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
