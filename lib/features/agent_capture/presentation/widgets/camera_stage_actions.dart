import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/camera_action.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/camera_action_button.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/camera_gallery_thumbnail.dart';

/// The gallery thumbnail and the three capture actions along the stage bottom.
///
/// Reads as one translucent pill, as the design draws, so it never competes
/// with the viewfinder for attention.
class CameraStageActions extends StatelessWidget {
  const CameraStageActions({
    required this.actions,
    required this.capturedCount,
    required this.onOpenGallery,
    super.key,
  });

  final List<CameraAction> actions;

  /// Number of items already captured.
  final int capturedCount;
  final VoidCallback onOpenGallery;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CameraGalleryThumbnail(count: capturedCount, onPressed: onOpenGallery),
        Flexible(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0x80000000),
              borderRadius: BorderRadius.circular(AppRadii.pill),
              border: Border.all(color: const Color(0x1AFFFFFF)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              child: Row(
                children: [
                  for (final action in actions)
                    Flexible(
                      child: CameraActionButton(
                        label: action.label,
                        onPressed: action.onPressed,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// The captured-items thumbnail with its count badge.
class GalleryThumbnail extends StatelessWidget {
  const GalleryThumbnail({
    required this.count,
    required this.onPressed,
    super.key,
  });

  final int count;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Semantics(
      button: true,
      label: l10n.captureGalleryThumbnail(count),
      child: SizedBox.square(
        dimension: AppDimensions.minTouchTarget,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2937),
                  borderRadius: BorderRadius.circular(AppRadii.dialog),
                  border: Border.all(color: const Color(0x66FFFFFF)),
                ),
                child: Icon(
                  Icons.image_outlined,
                  size: AppDimensions.iconLg,
                  color: const Color(0x99FFFFFF),
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
