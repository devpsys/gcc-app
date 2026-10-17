import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_wizard_stepper.dart';
import 'package:gcc_app/core/widgets/language_picker_sheet.dart';
import 'package:gcc_app/core/widgets/wizard_step_badge.dart';
import 'package:go_router/go_router.dart';

class CaptureWizardScaffold extends StatelessWidget {
  const CaptureWizardScaffold({
    required this.title,
    required this.stepLabels,
    required this.currentIndex,
    required this.stepEyebrow,
    required this.stepBadge,
    required this.stepBadgeStyle,
    this.children = const [],
    required this.actionBar,
    this.autosaveLabel,
    this.statusLabel,
    this.statusAlert = false,
    this.aboveStage,
    this.stage,
    super.key,
  });

  final String title;
  final List<String> stepLabels;
  final int currentIndex;

  /// Localised eyebrow for the step tracker, e.g. `Step 1 of 4 · Shop details`.
  final String stepEyebrow;

  /// Localised counter-chip text for the step tracker.
  final String stepBadge;

  /// Treatment for [stepBadge].
  final WizardStepBadge stepBadgeStyle;
  final List<Widget> children;
  final Widget actionBar;
  final String? autosaveLabel;
  final String? statusLabel;
  final bool statusAlert;

  /// Pinned between the step tracker and the body — the camera step's
  /// collapsible checklist sits here.
  final Widget? aboveStage;

  /// Replaces the scrolling body with a full-bleed surface. Used by the camera
  /// step, whose viewfinder has to own the whole area under the chrome.
  final Widget? stage;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final saved = autosaveLabel;
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surface,
                border: Border(
                  bottom: BorderSide(color: context.semanticColors.border),
                ),
              ),
              child: SizedBox(
                key: const Key('capture.appBar'),
                height: AppDimensions.topBarHeight,
                child: Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: Row(
                    children: [
                      IconButton(
                        tooltip: context.l10n.authBack,
                        onPressed: () => _back(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          showAppLanguagePicker(
                            context: context,
                            selectedId: 'english',
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: scheme.onSurface,
                          side: BorderSide(color: scheme.outline),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadii.pill),
                          ),
                          minimumSize: const Size(
                            AppDimensions.minTouchTarget,
                            AppDimensions.minTouchTarget - AppSpacing.sm,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(context.l10n.dashboardLanguageShort),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: AppDimensions.iconSm,
                              color: scheme.onSurface,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (saved != null)
            DecoratedBox(
              decoration: BoxDecoration(
                color: statusAlert
                    ? context.semanticColors.dangerContainer
                    : scheme.surfaceContainerLow,
                border: Border(
                  bottom: BorderSide(
                    color: statusAlert
                        ? context.semanticColors.dangerBorder
                        : context.semanticColors.border,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.tight,
                ),
                child: Row(
                  children: [
                    Icon(
                      statusAlert ? Icons.warning_amber_outlined : Icons.check,
                      size: AppDimensions.iconSm,
                      color: statusAlert
                          ? context.semanticColors.danger
                          : context.semanticColors.success,
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    Expanded(
                      child: Text(
                        saved,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: statusAlert
                              ? context.semanticColors.danger
                              : scheme.onSurfaceVariant,
                          fontWeight: statusAlert ? FontWeight.w500 : null,
                        ),
                      ),
                    ),
                    Text(
                      statusLabel ?? context.l10n.captureOfflineReady,
                      style: AppTextStyles.mono(
                        Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: statusAlert
                              ? context.semanticColors.danger
                              : context.semanticColors.muted,
                          fontWeight: statusAlert
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          AppWizardStepper(
            labels: stepLabels,
            currentIndex: currentIndex,
            eyebrow: stepEyebrow,
            badge: stepBadge,
            badgeStyle: stepBadgeStyle,
          ),
          ?aboveStage,
          if (stage != null)
            // The stage owns the remaining space so a full-bleed surface can
            // sit under the chrome without pushing the bar off screen.
            Expanded(child: stage!)
          else
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.xxxl,
                ),
                children: children,
              ),
            ),
          actionBar,
        ],
      ),
    );
  }

  void _back(BuildContext context) {
    final router = GoRouter.maybeOf(context);
    if (router?.canPop() ?? false) {
      router?.pop();
      return;
    }
    router?.go(RoutePaths.agentToday);
  }
}
