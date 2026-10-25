import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_proof_clip.dart';

class LesseeBookingDetailProofs extends StatelessWidget {
  const LesseeBookingDetailProofs({required this.proofs, super.key});

  final List<LesseeBookingProofClip> proofs;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.bookingsDetailProofsEyebrow.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: colors.muted,
            fontWeight: FontWeight.w600,
            letterSpacing: AppTextStyles.eyebrowLetterSpacing,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            border: Border.all(color: colors.border),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            child: Column(
              children: [
                for (var i = 0; i < proofs.length; i++) ...[
                  if (i > 0)
                    ColoredBox(
                      color: colors.border,
                      child: const SizedBox(
                        height: AppDimensions.borderWidth,
                        width: double.infinity,
                      ),
                    ),
                  _clip(context, proofs[i]),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _clip(BuildContext context, LesseeBookingProofClip clip) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ColoredBox(
            color: scheme.onSurface,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.play_circle_fill,
                  size: AppDimensions.iconLg * 1.5,
                  color: scheme.surface.withValues(alpha: 0.85),
                ),
                Positioned(
                  right: AppSpacing.xs,
                  bottom: AppSpacing.xs,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.onSurface.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(AppRadii.input),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.tight,
                        vertical: AppSpacing.xxs / 2,
                      ),
                      child: Text(
                        clip.durationLabel,
                        style: AppTextStyles.tabular(
                          Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: scheme.surface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.sm,
            AppSpacing.xs + AppSpacing.xxs / 2,
            AppSpacing.sm,
            AppSpacing.xs + AppSpacing.xxs / 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                clip.title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs / 2),
              Text(
                '✓ ${clip.subtitle}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.muted,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                l10n.bookingsProofPlaybackUnavailable,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.muted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
