import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';

/// 16:9 hero, thumb strip, and the condition-video caption.
class MarketplaceListingHero extends StatelessWidget {
  const MarketplaceListingHero({required this.listing, super.key});

  final MarketplaceListing listing;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final l10n = context.l10n;
    final mark = listing.heroMark;
    final tagline = listing.heroTagline;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: DecoratedBox(
            decoration: BoxDecoration(color: scheme.surfaceContainerHighest),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.precision_manufacturing_outlined,
                        size: AppDimensions.iconLg,
                        color: scheme.primary.withValues(alpha: 0.7),
                      ),
                      if (mark != null) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          mark,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ],
                      if (tagline != null)
                        Text(
                          tagline,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: colors.muted,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                              ),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  right: AppSpacing.sm,
                  bottom: AppSpacing.sm,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.onSurface.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(AppRadii.input),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                        vertical: AppSpacing.xxs,
                      ),
                      child: Text(
                        l10n.marketplacePhotos(1, listing.photoCount),
                        style: AppTextStyles.tabular(
                          Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: scheme.surface),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: AppDimensions.marketplaceThumbStrip,
          child: Row(
            children: [
              for (var index = 0; index < listing.photoCount; index++)
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: index == 0
                          ? scheme.secondaryContainer
                          : scheme.surfaceContainerHighest,
                      border: Border.all(
                        color: index == 0 ? scheme.primary : colors.border,
                      ),
                    ),
                    child: Icon(
                      Icons.image_outlined,
                      size: AppDimensions.iconSm,
                      color: colors.muted,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (listing.videoCaption != null)
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: colors.border)),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: AppDimensions.minTouchTarget,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Row(
                  children: [
                    Icon(
                      Icons.play_circle_outline,
                      size: AppDimensions.iconMd,
                      color: colors.muted,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        listing.videoCaption!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (listing.videoCaption != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.xxs,
              AppSpacing.md,
              0,
            ),
            child: Text(
              l10n.marketplaceVideoUnavailable,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.muted),
            ),
          ),
      ],
    );
  }
}
