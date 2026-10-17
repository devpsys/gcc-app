import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// The captured-items thumbnail with its count badge.
class CameraGalleryThumbnail extends StatelessWidget {
  const CameraGalleryThumbnail({
    required this.count,
    required this.onPressed,
    super.key,
  });

  /// Number of items already captured; the badge is hidden at zero.
  final int count;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: l10n.captureGalleryThumbnail(count),
      child: SizedBox.square(
        dimension: AppDimensions.minTouchTarget,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Material(
                color: scheme.inverseSurface,
                borderRadius: BorderRadius.circular(AppRadii.dialog),
                child: InkWell(
                  onTap: onPressed,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadii.dialog),
                      border: Border.all(
                        color: scheme.surface.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Icon(
                      Icons.image_outlined,
                      size: AppDimensions.iconLg,
                      color: scheme.surface.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ),
            ),
            if (count > 0)
              Positioned(
                top: -AppSpacing.xxs,
                right: -AppSpacing.xxs,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(AppRadii.input),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxs,
                    ),
                    child: Text(
                      l10n.captureGalleryCount(count),
                      style: AppTextStyles.mono(
                        Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
