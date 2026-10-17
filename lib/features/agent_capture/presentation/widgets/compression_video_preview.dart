import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// The 16:9 preview of the condition clip, with its duration and format
/// badges.
///
/// Stands in for a real video player — there is no media pipeline yet — so it
/// is decorative and excluded from the semantics tree; the clip's duration is
/// announced by the sheet's own copy.
class CompressionVideoPreview extends StatelessWidget {
  const CompressionVideoPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ExcludeSemantics(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.inverseSurface,
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            border: Border.all(color: context.semanticColors.border),
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  Icons.play_circle_outline,
                  size: AppDimensions.iconLg * 2,
                  color: scheme.surface.withValues(alpha: 0.8),
                ),
              ),
              Positioned(
                left: AppSpacing.xs,
                bottom: AppSpacing.xs,
                child: CompressionPreviewBadge(
                  label: l10n.compressDuration,
                  emphasise: true,
                ),
              ),
              Positioned(
                right: AppSpacing.xs,
                bottom: AppSpacing.xs,
                child: CompressionPreviewBadge(label: l10n.compressFormat),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A monospace badge on the preview's corner.
class CompressionPreviewBadge extends StatelessWidget {
  const CompressionPreviewBadge({
    required this.label,
    this.emphasise = false,
    super.key,
  });

  final String label;

  /// Brightens and emboldens the badge for the duration stamp.
  final bool emphasise;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxs / 2,
      ),
      decoration: BoxDecoration(
        color: scheme.scrim,
        borderRadius: BorderRadius.circular(AppRadii.input),
      ),
      child: Text(
        label,
        style: AppTextStyles.mono(
          Theme.of(context).textTheme.labelSmall!.copyWith(
            color: emphasise ? scheme.surface : scheme.outlineVariant,
            fontWeight: emphasise ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
