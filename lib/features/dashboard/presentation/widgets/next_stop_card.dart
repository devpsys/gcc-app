import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';

class NextStopCard extends StatelessWidget {
  const NextStopCard({
    required this.stop,
    required this.disabledReason,
    this.onStartCapture,
    super.key,
  });

  final DashboardStop? stop;
  final String disabledReason;
  final VoidCallback? onStartCapture;

  @override
  Widget build(BuildContext context) {
    final current = stop;
    return _frame(
      context,
      child: current == null
          ? Text(context.l10n.dashboardAllDone)
          : _stop(context, current),
    );
  }

  Widget _stop(BuildContext context, DashboardStop current) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '${l10n.dashboardNextStop} · ${l10n.dashboardAway(current.distance)}'
                    .toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: colors.warning),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.secondaryContainer,
                borderRadius: BorderRadius.circular(AppRadii.input),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xxs,
                ),
                child: Text(
                  current.route.toUpperCase(),
                  style: AppTextStyles.mono(
                    Theme.of(context).textTheme.labelSmall!
                        .copyWith(color: scheme.secondary, letterSpacing: 0),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(current.name, style: Theme.of(context).textTheme.titleLarge),
        Text(
          current.address,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: scheme.onSurfaceVariant),
        ),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: AppDimensions.iconSm,
              color: scheme.outline,
            ),
            const SizedBox(width: AppSpacing.xxs),
            Expanded(
              child: Text(
                current.coordinates,
                style: AppTextStyles.mono(
                  Theme.of(context).textTheme.bodySmall!
                      .copyWith(color: scheme.onSurfaceVariant),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        AppPrimaryButton(
          label: l10n.dashboardStartCapture,
          icon: Icons.photo_camera_outlined,
          onPressed: onStartCapture,
          disabledReason: onStartCapture == null ? disabledReason : null,
        ),
        Tooltip(
          message: disabledReason,
          child: TextButton.icon(
            onPressed: null,
            style: TextButton.styleFrom(
              foregroundColor: scheme.primary,
              disabledForegroundColor: scheme.primary,
              minimumSize: const Size(
                double.infinity,
                AppDimensions.buttonHeightCompact,
              ),
            ),
            icon: const Icon(Icons.map_outlined, size: AppDimensions.iconSm),
            label: Text(l10n.dashboardGetDirections),
          ),
        ),
      ],
    );
  }

  Widget _frame(BuildContext context, {required Widget child}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: child,
      ),
    );
  }
}
