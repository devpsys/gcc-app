import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/booking/domain/lessee_profile.dart';

/// Initials, name, role, and rental tenure for the lessee profile.
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
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.secondaryContainer,
                shape: BoxShape.circle,
                border: Border.all(color: colors.border),
              ),
              child: SizedBox.square(
                dimension: AppSpacing.max,
                child: Center(
                  child: Text(
                    profile.initials,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                      children: [
                        TextSpan(text: '${profile.kind} · '),
                        TextSpan(
                          text: profile.reference,
                          style: AppTextStyles.mono(
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: scheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    profile.place,
                    style: AppTextStyles.mono(
                      Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    sinceLabel,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
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
