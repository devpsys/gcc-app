import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_audit_clip.dart';

/// Side-by-side check-out / check-in cards. Playback stays unavailable.
class MarketplaceAuditSection extends StatelessWidget {
  const MarketplaceAuditSection({required this.clips, super.key});

  final List<MarketplaceAuditClip> clips;

  @override
  Widget build(BuildContext context) {
    if (clips.isEmpty) {
      return const SizedBox.shrink();
    }
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.marketplaceAudit,
            style: Theme.of(context).textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var index = 0; index < clips.length; index++) ...[
                if (index > 0) const SizedBox(width: AppSpacing.sm),
                Expanded(child: _card(context, clips[index])),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            l10n.dashboardActionUnavailable,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: colors.muted),
          ),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, MarketplaceAuditClip clip) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppDimensions.marketplaceAuditVideo,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppRadii.card),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.play_circle_fill,
                  size: AppDimensions.iconLg,
                  color: scheme.onSurface.withValues(alpha: 0.35),
                ),
                Positioned(
                  left: AppSpacing.xs,
                  bottom: AppSpacing.xs,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.onSurface.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(AppRadii.input),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                        vertical: AppSpacing.xxs,
                      ),
                      child: Text(
                        clip.time,
                        style: Theme.of(context).textTheme.labelSmall
                            ?.copyWith(color: scheme.surface),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          clip.title,
          style: Theme.of(context).textTheme.titleSmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        if (clip.detail != null)
          Text(
            l10n.marketplaceAuditWithin(clip.detail!),
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: colors.success),
          ),
      ],
    );
  }
}
