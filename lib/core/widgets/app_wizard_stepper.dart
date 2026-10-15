import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/wizard_step_badge.dart';
import 'package:gcc_app/core/widgets/wizard_step_badge_chip.dart';
import 'package:gcc_app/core/widgets/wizard_step_pill.dart';

/// Compact pill-segmented step tracker.
///
/// Reproduces the design's "Compact Pill-Segmented Step Tracker Card Group":
/// a surface band holding an `ink-50` card that carries a
/// `STEP n OF m · <detail>` eyebrow, a trailing counter chip, and one 32 px
/// pill per step.
///
/// This is the single step tracker for every multi-step flow in the app. An
/// earlier thin progress-bar stepper and a capture-private copy both lived
/// here and were removed, so the pills cannot drift between flows.
class AppWizardStepper extends StatelessWidget {
  const AppWizardStepper({
    required this.labels,
    required this.currentIndex,
    required this.eyebrow,
    required this.badge,
    required this.badgeStyle,
    super.key,
  });

  /// Step names, in order. Four entries for the capture wizard.
  final List<String> labels;

  /// Index of the step the agent is currently on.
  final int currentIndex;

  /// Localised eyebrow, e.g. `Step 1 of 4 · Shop details`. Rendered uppercase.
  final String eyebrow;

  /// Localised text for the trailing counter chip.
  final String badge;

  /// Treatment for [badge].
  final WizardStepBadge badgeStyle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      container: true,
      label: context.l10n.captureWizardSummary(
        currentIndex + 1,
        labels.length,
        labels[currentIndex],
      ),
      child: ExcludeSemantics(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surface,
            border: Border(
              bottom: BorderSide(color: context.semanticColors.border),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(AppRadii.cardLarge),
                border: Border.all(color: context.semanticColors.border),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xs),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            eyebrow.toUpperCase(),
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        WizardStepBadgeChip(label: badge, style: badgeStyle),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.tight),
                    Row(
                      children: [
                        for (var index = 0; index < labels.length; index++) ...[
                          if (index > 0)
                            const SizedBox(width: AppSpacing.tight),
                          Expanded(
                            child: WizardStepPill(
                              label: labels[index],
                              isCurrent: index == currentIndex,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
