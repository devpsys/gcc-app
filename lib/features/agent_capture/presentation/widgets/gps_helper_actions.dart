import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';

/// Footer for the GPS helper's weak and acquired views.
///
/// The design stacks a bordered action above a brand text action, so this is a
/// column rather than the side-by-side row the wizard bar uses.
class GpsHelperActions extends StatelessWidget {
  const GpsHelperActions({
    required this.secondaryLabel,
    required this.onSecondary,
    required this.textLabel,
    required this.onText,
    super.key,
  });

  final String secondaryLabel;
  final VoidCallback onSecondary;
  final String textLabel;
  final VoidCallback onText;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(top: BorderSide(color: context.semanticColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSecondaryButton(
                label: secondaryLabel,
                expand: true,
                onPressed: onSecondary,
              ),
              const SizedBox(height: AppSpacing.xs),
              TextButton(
                onPressed: onText,
                style: TextButton.styleFrom(
                  foregroundColor: scheme.primary,
                  minimumSize: const Size(
                    double.infinity,
                    AppDimensions.minTouchTarget,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.button),
                  ),
                ),
                child: Text(
                  textLabel,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
