import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';

/// Shown when camera access has been denied.
///
/// The design is explicit that this is not a dead end: the agent can still
/// submit the shop with photos and no clip, because the clip only becomes
/// required at verification.
class CameraPermissionPanel extends StatelessWidget {
  const CameraPermissionPanel({required this.onEnable, super.key});

  final VoidCallback onEnable;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: scheme.surfaceContainerLow,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.lg),
            Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                  border: Border.all(color: context.semanticColors.border),
                ),
                child: SizedBox.square(
                  dimension: AppDimensions.noticeIcon * 1.5,
                  child: Icon(
                    Icons.photo_camera_back_outlined,
                    size: AppDimensions.iconLg * 1.5,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.capturePermissionTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.capturePermissionBody,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.lg),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(AppRadii.cardLarge),
                border: Border.all(color: context.semanticColors.border),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.capturePermissionHowTo.toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    for (final step in [
                      l10n.gpsAllowStep1,
                      l10n.gpsAllowStep2,
                      l10n.capturePermissionStep3,
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: Row(
                          children: [
                            Icon(
                              Icons.chevron_right,
                              size: AppDimensions.iconSm,
                              color: scheme.primary,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: Text(
                                step,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppPrimaryButton(
              label: l10n.captureTurnOnCamera,
              expand: true,
              onPressed: onEnable,
            ),
            const SizedBox(height: AppSpacing.xs),
            AppSecondaryButton(
              label: l10n.captureContinueWithoutVideo,
              expand: true,
              onPressed: onEnable,
            ),
          ],
        ),
      ),
    );
  }
}
