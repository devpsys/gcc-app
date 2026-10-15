import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

class LocationSignalPanel extends StatelessWidget {
  const LocationSignalPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.dangerContainer,
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            border: Border.all(color: colors.dangerBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.error_outline,
                  size: AppDimensions.iconSm,
                  color: colors.danger,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    l10n.captureNoSignalBanner,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.danger,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            border: Border.all(color: colors.danger.withValues(alpha: 0.3)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: AppDimensions.wizardBarHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    child: Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: colors.dangerContainer,
                            shape: BoxShape.circle,
                          ),
                          child: SizedBox(
                            width: AppSpacing.xxxl,
                            height: AppSpacing.xxxl,
                            child: Icon(
                              Icons.gps_off,
                              size: AppDimensions.iconMd,
                              color: colors.danger,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.captureNoSignalTitle,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                l10n.captureNoSignalBody,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: scheme.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '—',
                          style: AppTextStyles.mono(
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: scheme.onSurfaceVariant,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSpacing.xxs,
                  child: ColoredBox(color: scheme.surfaceContainerHighest),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
