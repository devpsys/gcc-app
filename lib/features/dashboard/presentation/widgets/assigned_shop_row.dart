import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/status_chip.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';

class AssignedShopRow extends StatelessWidget {
  const AssignedShopRow({
    required this.shop,
    this.onPressed,
    this.disabledReason,
    super.key,
  });

  final DashboardShop shop;
  final VoidCallback? onPressed;
  final String? disabledReason;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final status = switch (shop.status) {
      'queued' => l10n.dashboardShopQueued,
      'synced' => l10n.dashboardShopSynced,
      _ => l10n.dashboardShopNotStarted,
    };
    final tone = switch (shop.status) {
      'queued' => StatusTone.info,
      'synced' => StatusTone.success,
      _ => StatusTone.muted,
    };
    final row = _row(context, status, tone);
    final reason = disabledReason;
    if (onPressed != null) {
      return Material(
        type: MaterialType.transparency,
        child: InkWell(onTap: onPressed, child: row),
      );
    }
    if (reason == null || reason.isEmpty) return row;
    return Tooltip(message: reason, child: row);
  }

  Widget _row(BuildContext context, String status, StatusTone tone) {
    final scheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: AppDimensions.skeletonThumb),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final reserved =
                AppSpacing.xxl +
                AppSpacing.sm +
                AppSpacing.xs +
                AppDimensions.iconSm +
                AppSpacing.xxl;
            final maxChip = math.max(1.0, constraints.maxWidth - reserved);
            return Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox.square(
                    dimension: AppSpacing.xxl,
                    child: Center(
                      child: Text(
                        shop.position,
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.labelMedium!
                              .copyWith(letterSpacing: 0),
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
                        shop.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        shop.place,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxChip),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.centerEnd,
                    child: StatusChip(
                      label: status,
                      tone: tone,
                      icon: shop.status == 'synced' ? Icons.check : null,
                      shrinkWrap: true,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: AppDimensions.iconSm,
                  color: scheme.outline,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
