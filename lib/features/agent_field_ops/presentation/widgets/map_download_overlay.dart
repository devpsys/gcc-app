import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_download_line.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_download_step.dart';

/// The downloading overlay shown while map areas are being fetched.
///
/// Itemised rather than a single spinner: the design's promise is that the
/// download is finite and countable, and a bare spinner denies both.
class MapDownloadOverlay extends StatelessWidget {
  const MapDownloadOverlay({
    required this.progress,
    required this.lines,
    super.key,
  });

  /// Tile download progress, 0 to 1.
  final double progress;

  /// The itemised work in flight.
  final List<MapDownloadLine> lines;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.mapStripOnline,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  '${(progress * 100).round()}%',
                  style: AppTextStyles.tabular(
                    Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: scheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadii.pill),
              child: SizedBox(
                height: AppSpacing.xs,
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: colors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(scheme.primary),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.mapCachedPercent((progress * 100).round()),
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.labelSmall!
                    .copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            for (final line in lines)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.tight),
                child: Row(
                  children: [
                    Icon(
                      switch (line.step) {
                        MapDownloadStep.tile => Icons.grid_on,
                        MapDownloadStep.vectors => Icons.polyline_outlined,
                        MapDownloadStep.boundary => Icons.pentagon_outlined,
                        MapDownloadStep.sync => Icons.save_outlined,
                      },
                      size: AppSpacing.md,
                      color: colors.info,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        line.detail,
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: scheme.onSurface),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
