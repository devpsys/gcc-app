import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/booking/domain/handback_review.dart';

class HandbackVideoCard extends StatelessWidget {
  const HandbackVideoCard({
    required this.review,
    required this.watched,
    required this.onPlay,
    super.key,
  });

  final HandbackReview review;
  final bool watched;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final l10n = context.l10n;
    final duration = _mmss(review.durationSeconds);
    final position = watched ? duration : '00:00';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.onSurface,
              borderRadius: BorderRadius.circular(AppRadii.dialog),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadii.dialog),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: onPlay,
                      child: Center(
                        child: Icon(
                          watched
                              ? Icons.replay_circle_filled
                              : Icons.play_circle_fill,
                          size: AppDimensions.emptyStateIcon / 2,
                          color: scheme.surface.withValues(alpha: 0.9),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: AppSpacing.xs,
                    top: AppSpacing.xs,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: scheme.onSurface.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(AppRadii.input),
                        border: Border.all(
                          color: scheme.surface.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                          vertical: AppSpacing.xxs / 2,
                        ),
                        child: Text(
                          l10n.handbackCheckInBadge.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: scheme.surface,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              ),
                        ),
                      ),
                    ),
                  ),
                  if (watched)
                    Positioned(
                      right: AppSpacing.xs,
                      top: AppSpacing.xs,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.success,
                          borderRadius: BorderRadius.circular(AppRadii.input),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                            vertical: AppSpacing.xxs / 2,
                          ),
                          child: Text(
                            l10n.handbackWatchedBadge(duration),
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: scheme.onPrimary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                ),
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    left: AppSpacing.xs,
                    right: AppSpacing.xs,
                    bottom: AppSpacing.xs,
                    child: Text(
                      '$position / $duration',
                      style: AppTextStyles.tabular(
                        Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: scheme.surface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.handbackRecordedBy(review.recordedAtLabel),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colors.muted,
          ),
        ),
        if (watched) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            l10n.handbackVideoComplete(duration),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colors.success,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  String _mmss(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}
