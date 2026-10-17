import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';

/// Primary-and-text footer used by the permission-denied and manual views.
///
/// The text action underneath is deliberately muted rather than brand coloured:
/// in the denied view it is the way past without granting permission.
class GpsHelperPrimaryActions extends StatelessWidget {
  const GpsHelperPrimaryActions({
    required this.primaryLabel,
    required this.onPrimary,
    required this.textLabel,
    required this.onText,
    super.key,
  });

  final String primaryLabel;
  final VoidCallback onPrimary;
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
              AppPrimaryButton(
                label: primaryLabel,
                expand: true,
                onPressed: onPrimary,
              ),
              const SizedBox(height: AppSpacing.xxs),
              TextButton(
                onPressed: onText,
                style: TextButton.styleFrom(
                  minimumSize: const Size(
                    double.infinity,
                    AppDimensions.buttonHeightCompact,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.button),
                  ),
                ),
                child: Text(
                  textLabel,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
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
