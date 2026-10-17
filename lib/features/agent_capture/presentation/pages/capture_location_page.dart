import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_state.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/gps_helper_sheet.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/gps_helper_view.dart';
import 'package:gcc_app/core/widgets/wizard_step_badge.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/capture_wizard_scaffold.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/location_context_note.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/location_map_fallback.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/location_signal_panel.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/spatial_hierarchy_card.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/spatial_picker_sheet.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/spatial_selector_field.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/wizard_action_bar.dart';
import 'package:intl/intl.dart';

class CaptureLocationPage extends StatelessWidget {
  const CaptureLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaptureCubit, CaptureState>(
      builder: (context, state) {
        final draft = state.draft;
        final l10n = context.l10n;
        final cubit = context.read<CaptureCubit>();
        final savedAt = draft.savedAt;
        final missingLandmark = draft.landmark.trim().isEmpty;
        final assigned =
            draft.market.trim().isNotEmpty &&
            draft.zone.trim().isNotEmpty &&
            draft.line.trim().isNotEmpty;
        final current = draft.spatialCurrentIndex;
        return CaptureWizardScaffold(
          title: l10n.captureLocationTitle,
          stepLabels: [
            l10n.captureStepShop,
            l10n.captureStepLocation,
            l10n.captureStepAssets,
            l10n.captureStepMedia,
          ],
          currentIndex: 1,
          stepEyebrow: l10n.captureStepEyebrow(
            2,
            4,
            l10n.captureSpatialTagging,
          ),
          stepBadge: l10n.captureStepActive(2, 4),
          stepBadgeStyle: WizardStepBadge.active,
          autosaveLabel: savedAt == null
              ? null
              : l10n.captureAutosaved(
                  DateFormat.jm(Localizations.localeOf(context).toString())
                      .format(savedAt),
                ),
          actionBar: WizardActionBar(
            secondaryLabel: l10n.captureSaveDraft,
            primaryLabel: l10n.captureContinue,
            onSecondary: cubit.rememberDraft,
            // The app has no GPS service wired up, so the step is always in
            // the design's no-signal frame. That frame lets the agent continue
            // without a pin and states the admin will verify the location —
            // which is what this reason says.
            onPrimary: missingLandmark
                ? null
                : () =>
                      GoRouter.maybeOf(context)?.push(RoutePaths.captureAssets),
            primaryDisabledReason: missingLandmark
                ? l10n.captureLandmarkRequired
                : l10n.captureContinueWithoutPin,
          ),
          children: [
            SpatialHierarchyCard(
              market: draft.market,
              zone: draft.zone,
              line: draft.line,
              landmark: draft.landmark,
              onLandmarkChanged: cubit.editLandmark,
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.captureSelectorsHeading.toUpperCase(),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: AppTextStyles.eyebrowLetterSpacing,
                    ),
                  ),
                ),
                Text(
                  assigned
                      ? l10n.captureHierarchyAssigned
                      : l10n.captureHierarchyPending,
                  style: AppTextStyles.mono(
                    Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: assigned
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            SpatialSelectorField(
              label: l10n.captureMarket,
              value: draft.market,
              hint: l10n.captureChooseMarket,
              highlighted: current == 0,
              onPressed: () => _pick(
                context,
                title: l10n.captureMarket,
                initial: draft.market,
                onSelected: cubit.editMarket,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            SpatialSelectorField(
              label: l10n.captureZone,
              value: draft.zone,
              hint: l10n.captureChooseZone,
              highlighted: current == 1,
              onPressed: () => _pick(
                context,
                title: l10n.captureZone,
                initial: draft.zone,
                caption: draft.market,
                onSelected: cubit.editZone,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            SpatialSelectorField(
              label: l10n.captureLine,
              value: draft.line,
              hint: l10n.captureChooseLine,
              highlighted: current == 2,
              onPressed: () => _pick(
                context,
                title: l10n.captureLine,
                initial: draft.line,
                caption: [
                  draft.market,
                  draft.zone,
                ].where((part) => part.trim().isNotEmpty).join(' · '),
                onSelected: cubit.editLine,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.captureHierarchyHint,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const LocationSignalPanel(),
            const SizedBox(height: AppSpacing.md),
            LocationMapFallback(
              onEnterCoordinates: () =>
                  showGpsHelper(context, view: GpsHelperView.manualEntry),
            ),
            const LocationContextNote(),
          ],
        );
      },
    );
  }

  Future<void> _pick(
    BuildContext context, {
    required String title,
    required String initial,
    required ValueChanged<String> onSelected,
    String? caption,
  }) async {
    final selected = await showSpatialPicker(
      context: context,
      title: title,
      initial: initial,
      caption: caption,
    );
    if (selected == null || !context.mounted) {
      return;
    }
    onSelected(selected);
  }
}
