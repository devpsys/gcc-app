import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_gradients.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/booking/domain/lessee_profile.dart';

/// Gradient identity card for MOB-LSE-17.
class LesseeProfileHeader extends StatelessWidget {
  const LesseeProfileHeader({
    required this.profile,
    required this.sinceLabel,
    super.key,
  });

  final LesseeProfile profile;
  final String sinceLabel;

  @override
  Widget build(BuildContext context) {
    final onCard = Theme.of(context).colorScheme.onPrimary;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppGradients.availableBalance,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: onCard.withValues(alpha: 0.92),
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox.square(
                    dimension: AppSpacing.xxxl,
                    child: Icon(
                      Icons.person_outline,
                      color: Theme.of(context).colorScheme.secondary,
                      size: AppDimensions.iconLg,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: onCard,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: AppSpacing.xs,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: onCard.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(
                                AppRadii.input,
                              ),
                              border: Border.all(
                                color: onCard.withValues(alpha: 0.25),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.xs,
                                vertical: 1,
                              ),
                              child: Text(
                                profile.kind,
                                style: AppTextStyles.mono(
                                  Theme.of(context).textTheme.labelSmall!
                                      .copyWith(
                                        color: onCard.withValues(alpha: 0.9),
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '·',
                            style: TextStyle(
                              color: onCard.withValues(alpha: 0.7),
                            ),
                          ),
                          Text(
                            profile.reference,
                            style: AppTextStyles.mono(
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                color: onCard,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Icon(
                  Icons.place_outlined,
                  size: AppDimensions.iconSm,
                  color: onCard.withValues(alpha: 0.85),
                ),
                const SizedBox(width: AppSpacing.xxs),
                Expanded(
                  child: Text(
                    profile.place,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: onCard.withValues(alpha: 0.9),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Divider(height: 1, color: onCard.withValues(alpha: 0.25)),
            const SizedBox(height: AppSpacing.sm),
            Text(
              sinceLabel,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: onCard.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
