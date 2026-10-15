import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';

/// One 32 px pill in the wizard step tracker.
///
/// Reached steps are filled brand with white text; upcoming steps are white
/// with an `ink-200` border and `ink-500` text, exactly as drawn in the
/// design. The reached step carries no border — the fill alone marks it.
class WizardStepPill extends StatelessWidget {
  const WizardStepPill({
    required this.label,
    required this.isCurrent,
    super.key,
  });

  final String label;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isCurrent ? scheme.primary : scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: isCurrent
            ? null
            : Border.all(color: context.semanticColors.border),
      ),
      child: SizedBox(
        height: AppDimensions.wizardStepHeight,
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isCurrent ? scheme.onPrimary : scheme.onSurfaceVariant,
              fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
