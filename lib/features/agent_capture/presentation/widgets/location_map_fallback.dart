import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class LocationMapFallback extends StatelessWidget {
  const LocationMapFallback({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            border: Border.all(color: context.semanticColors.border),
          ),
          child: SizedBox(
            height: AppDimensions.locationMapHeight,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.outlineVariant,
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(
                      width: AppSpacing.xxxl,
                      height: AppSpacing.xxxl,
                      child: Icon(
                        Icons.location_off_outlined,
                        size: AppDimensions.iconMd,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.captureMapDisabledTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    l10n.captureMapDisabledBody,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.capturePinNote,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: scheme.onSurfaceVariant),
        ),
        Align(
          alignment: Alignment.center,
          child: Tooltip(
            message: l10n.dashboardActionUnavailable,
            child: TextButton(
              onPressed: null,
              child: Text(
                l10n.captureEnterCoordinates,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: scheme.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
