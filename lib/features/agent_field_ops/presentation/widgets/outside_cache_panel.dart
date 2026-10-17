import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';

/// The panel shown when the agent has walked out of the downloaded map area.
///
/// Says plainly that nothing will load, names the areas that are downloaded so
/// the agent can navigate back, and explains that the download needs a
/// connection rather than pretending the button will work offline.
class OutsideCachePanel extends StatelessWidget {
  const OutsideCachePanel({
    required this.downloadedAreas,
    required this.downloadedSize,
    this.cacheEdgeArea,
    this.onDownload,
    super.key,
  });

  /// e.g. `Dei-Dei · Kugbo`.
  final List<String> downloadedAreas;

  /// e.g. `6.4 MB`.
  final String downloadedSize;

  /// The cached region the agent has walked out of.
  final String? cacheEdgeArea;

  final VoidCallback? onDownload;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final edge = cacheEdgeArea;
    final areas = downloadedAreas.join(' · ');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.warningContainer,
            shape: BoxShape.circle,
          ),
          child: SizedBox.square(
            dimension: AppDimensions.emptyStateIcon,
            child: Icon(
              Icons.wifi_off_rounded,
              size: AppDimensions.iconLg * 1.5,
              color: colors.warning,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          l10n.mapOutsideCachedTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.mapOutsideCachedBody(areas),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.md),
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppRadii.cardLarge),
            border: Border.all(color: colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (edge != null)
                  _line(
                    context,
                    l10n.mapOutsideCachedEdge(edge),
                    Icons.border_all,
                  ),
                _line(
                  context,
                  l10n.mapOutsideCachedNoVectors,
                  Icons.layers_clear_outlined,
                ),
                _line(
                  context,
                  l10n.mapDownloadedAreas(areas, downloadedSize),
                  Icons.download_done_outlined,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppPrimaryButton(
          label: l10n.mapDownloadThisArea,
          expand: true,
          onPressed: onDownload,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.mapNeedsConnection,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _line(BuildContext context, String text, IconData glyph) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.tight),
      child: Row(
        children: [
          Icon(glyph, size: AppSpacing.md, color: scheme.onSurfaceVariant),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.labelSmall!
                    .copyWith(color: scheme.onSurface),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
