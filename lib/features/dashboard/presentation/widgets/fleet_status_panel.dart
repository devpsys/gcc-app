import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/status_chip.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_text_link.dart';

class FleetStatusPanel extends StatelessWidget {
  const FleetStatusPanel({
    required this.fleet,
    required this.disabledReason,
    super.key,
  });

  final DashboardFleet? fleet;
  final String disabledReason;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final current = fleet;
    return _frame(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.dashboardYourEquipment,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Flexible(
                child: DashboardTextLink(
                  label: l10n.dashboardManage,
                  disabledReason: disabledReason,
                  chevron: true,
                  alignment: Alignment.centerRight,
                ),
              ),
            ],
          ),
          if (current == null)
            Text(l10n.dashboardNoFleet)
          else
            _fleet(context, current),
        ],
      ),
    );
  }

  Widget _fleet(BuildContext context, DashboardFleet current) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final segments = [
      (l10n.dashboardReadyForWork, current.ready, colors.success),
      (l10n.dashboardRentedOut, current.rented, colors.info),
      (l10n.dashboardInMaintenance, current.maintenance, colors.warning),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.pill),
          child: SizedBox(
            height: AppSpacing.sm,
            child: Row(
              children: [
                for (final segment in segments)
                  Expanded(
                    flex: segment.$2 == 0 ? 1 : segment.$2,
                    child: ColoredBox(color: segment.$3),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final segment in segments)
          Semantics(
            label: l10n.dashboardFleetSegment(segment.$1, segment.$2),
            container: true,
            child: ExcludeSemantics(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: AppSpacing.xxxl),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: context.semanticColors.border),
                    ),
                  ),
                  child: Row(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: segment.$3,
                          shape: BoxShape.circle,
                        ),
                        child: const SizedBox.square(dimension: AppSpacing.xs),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(child: Text(segment.$1)),
                      Text(
                        '${segment.$2}',
                        style: AppTextStyles.tabular(
                          Theme.of(context).textTheme.bodyMedium!,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.dashboardAssetsSummary(
            current.listed,
            current.pendingVerification,
          ),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        for (final item in current.attention) ...[
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber,
                size: AppDimensions.iconSm,
                color: colors.warning,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      item.detail,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              StatusChip(
                label: item.status,
                tone: item.tone == 'info'
                    ? StatusTone.info
                    : StatusTone.warning,
              ),
              Icon(
                Icons.chevron_right,
                size: AppDimensions.iconSm,
                color: Theme.of(context).colorScheme.outline,
              ),
            ],
          ),
        ],
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
