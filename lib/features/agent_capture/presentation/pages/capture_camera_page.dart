import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/wizard_step_badge.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/camera_action.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/camera_stage_state.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/media_pipeline.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_state.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/film_checklist_item.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/compression_sheet.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/camera_failure_banner.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/camera_permission_panel.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/camera_stage.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/camera_stage_actions.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/camera_stage_overlays.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/camera_subject_hint.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/capture_wizard_scaffold.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/film_checklist.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/framing_guides.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/record_control.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/wizard_action_bar.dart';

/// Wizard step 4 — photo and 30 second condition clip.
///
/// Four states, matching the design's four frames: idle, recording, camera
/// permission denied, and a clip that stopped short of the 30 second minimum.
///
/// There is no camera plugin wired up, so the viewfinder is a placeholder and
/// the record control advances a timer. That keeps every reachable state of
/// the design reachable and testable without inventing a capture pipeline.
class CaptureCameraPage extends StatefulWidget {
  const CaptureCameraPage({super.key});

  @override
  State<CaptureCameraPage> createState() => _CaptureCameraPageState();
}

class _CaptureCameraPageState extends State<CaptureCameraPage> {
  CameraStageState _stage = CameraStageState.idle;
  int _elapsed = 0;
  bool _checklistExpanded = false;
  Timer? _timer;

  /// Clip length at which the design reports an incomplete recording.
  static const int _failedAt = 12;

  bool get _recording => _stage == CameraStageState.recording;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleRecording() {
    if (_recording) {
      // The design treats stopping under 30 s as a failure, not a save.
      _timer?.cancel();
      setState(() {
        _stage = _elapsed < RecordControl.maxSeconds
            ? CameraStageState.failed
            : CameraStageState.idle;
        _elapsed = 0;
      });
      return;
    }
    setState(() {
      _stage = CameraStageState.recording;
      _elapsed = 0;
      _checklistExpanded = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _elapsed += 1);
      // Letting the clip run to the minimum returns the stage to idle.
      if (_elapsed >= RecordControl.maxSeconds) {
        timer.cancel();
        setState(() => _stage = CameraStageState.idle);
      }
    });
  }

  void _showPermissionDenied() =>
      setState(() => _stage = CameraStageState.permissionDenied);

  void _setIdle() {
    _timer?.cancel();
    setState(() {
      _stage = CameraStageState.idle;
      _elapsed = 0;
    });
  }

  /// Runs the compression and upload pipeline for the recorded clip, then moves
  /// on to the review step.
  ///
  /// The sheet is awaited before navigating so the push never races the modal
  /// animating out, and so a background option ("upload later", "choose
  /// quality") leaves the agent on this step rather than silently advancing.
  /// Without this the step was a dead end: the sheet popped straight back to
  /// the viewfinder with no route onward to review.
  Future<void> _openPipeline() async {
    _timer?.cancel();
    setState(() => _elapsed = 0);
    final proceed = await showCompressionSheet(
      context,
      stage: MediaPipelineStage.compressing,
    );
    if (proceed != true || !mounted) {
      return;
    }
    GoRouter.maybeOf(context)?.push(RoutePaths.captureReview);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<CaptureCubit>();

    return BlocBuilder<CaptureCubit, CaptureState>(
      builder: (context, state) {
        final checklist = _checklist(state, _recording);
        return CaptureWizardScaffold(
          title: _recording
              ? l10n.captureRecordingTitle
              : l10n.captureMediaTitle,
          stepLabels: [
            l10n.captureStepShop,
            l10n.captureStepLocation,
            l10n.captureStepAssets,
            l10n.captureStepMedia,
          ],
          currentIndex: 3,
          stepEyebrow: l10n.captureMediaStep(4, 4),
          stepBadge: _recording
              ? l10n.captureRecordingBadge
              : l10n.captureStepActive(4, 4),
          stepBadgeStyle: _recording
              ? WizardStepBadge.start
              : WizardStepBadge.active,
          aboveStage: FilmChecklist(
            items: checklist,
            expanded: _checklistExpanded,
            onToggle: () =>
                setState(() => _checklistExpanded = !_checklistExpanded),
          ),
          stage: _body(state, checklist),
          actionBar: WizardActionBar(
            secondaryLabel: l10n.captureRetake,
            primaryLabel: _recording
                ? l10n.captureStopRecording
                : l10n.captureUsePhoto,
            onSecondary: cubit.rememberDraft,
            // A completed clip goes through compression before review.
            onPrimary: _recording ? _toggleRecording : _openPipeline,
          ),
        );
      },
    );
  }

  Widget _body(CaptureState state, List<FilmChecklistItem> checklist) {
    if (_stage == CameraStageState.permissionDenied) {
      return CameraPermissionPanel(onEnable: _setIdle);
    }
    final l10n = context.l10n;
    return CameraStage(
      child: Stack(
        fit: StackFit.expand,
        children: [
          const FramingGuides(),
          Column(
            children: [
              const SizedBox(height: AppSpacing.sm),
              CameraGeofencePill(
                place: state.draft.market.isEmpty
                    ? l10n.captureUnverifiedPlace
                    : state.draft.market,
                accuracyLabel: l10n.captureAccuracyValue(14),
              ),
              const SizedBox(height: AppSpacing.xs),
              CameraSubjectHint(
                text: _recording
                    ? l10n.captureAlmostDone
                    : l10n.captureKeepInFrame,
              ),
              Expanded(
                child: Center(
                  child: RecordControl(
                    recording: _recording,
                    elapsed: _elapsed,
                    onTap: _toggleRecording,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: CameraStageActions(
                  capturedCount: checklist.where((i) => i.done).length,
                  onOpenGallery: _showPermissionDenied,
                  actions: [
                    CameraAction(
                      label: l10n.captureRetake,
                      onPressed: _setIdle,
                    ),
                    CameraAction(
                      label: l10n.captureUsePhoto,
                      onPressed: _openPipeline,
                    ),
                    CameraAction(
                      label: l10n.captureRecordClip,
                      onPressed: _toggleRecording,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
          if (_stage == CameraStageState.failed)
            CameraFailureBanner(
              seconds: _failedAt,
              onRerecord: () => _toggleRecording(),
              onUseAnyway: _setIdle,
            ),
        ],
      ),
    );
  }

  /// The five shots the design asks for.
  ///
  /// The default frame shows two captured; while a clip is running the design
  /// shows all five complete, because filming them is what the clip is for.
  List<FilmChecklistItem> _checklist(CaptureState state, bool recording) {
    final l10n = context.l10n;
    return [
      FilmChecklistItem(label: l10n.captureFilmWholeMachine, done: true),
      FilmChecklistItem(label: l10n.captureFilmExistingDamage, done: true),
      FilmChecklistItem(label: l10n.captureFilmSerialPlate, done: recording),
      FilmChecklistItem(label: l10n.captureFilmFluidLevels, done: recording),
      FilmChecklistItem(label: l10n.captureFilmAccessories, done: recording),
    ];
  }
}
