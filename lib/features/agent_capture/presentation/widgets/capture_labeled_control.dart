import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// A label above a control that is not a text field.
///
/// Mirrors the label the capture step puts above its text inputs, so the
/// quantity stepper, condition grade and availability picker all read at the
/// same weight as the fields around them.
class CaptureLabeledControl extends StatelessWidget {
  const CaptureLabeledControl({
    required this.label,
    required this.child,
    this.error,
    super.key,
  });

  final String label;
  final Widget child;

  /// Replaces [label] with an error message in the danger tone, matching how
  /// the capture step surfaces a field problem.
  final String? error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          error ?? label,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: error == null
                ? theme.colorScheme.onSurface
                : theme.colorScheme.error,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        child,
      ],
    );
  }
}
