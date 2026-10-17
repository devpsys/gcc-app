import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/wizard_step_badge.dart';

/// The trailing counter chip on the wizard step tracker.
///
/// Renders `START` as a plain caption — the designs give it no fill or edge —
/// and `1 / 4 ACTIVE` / `ATTENTION` as filled chips. Text is supplied by the
/// caller so the feature keeps ownership of its own wording.
class WizardStepBadgeChip extends StatelessWidget {
  const WizardStepBadgeChip({
    required this.label,
    required this.style,
    super.key,
  });

  final String label;
  final WizardStepBadge style;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final (background, foreground, edge) = switch (style) {
      WizardStepBadge.start => (null, scheme.onSurfaceVariant, null),
      WizardStepBadge.active => (
        scheme.secondaryContainer,
        scheme.secondary,
        scheme.primaryContainer,
      ),
      WizardStepBadge.attention => (
        colors.dangerContainer,
        colors.danger,
        colors.dangerBorder,
      ),
    };
    final text = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.end,
      style: AppTextStyles.mono(
        Theme.of(context).textTheme.labelSmall!.copyWith(
          color: foreground,
          fontWeight: style == WizardStepBadge.start
              ? FontWeight.w500
              : FontWeight.w600,
        ),
      ),
    );
    final fill = background;
    final border = edge;
    if (fill == null || border == null) {
      return text;
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(AppRadii.input),
        border: Border.all(color: border),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tight,
          vertical: AppSpacing.xxs / 2,
        ),
        child: text,
      ),
    );
  }
}
