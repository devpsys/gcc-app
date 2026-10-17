import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shop_status.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/assigned_shop_status_chip.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

/// One stop on the work list.
///
/// Name leads, status pill opposite it, then location, then coordinates. A shop
/// that needs attention swaps the coordinate line for its reason — the agent
/// needs to know what went wrong before they set out, not just where it is.
class AssignedShopRow extends StatelessWidget {
  const AssignedShopRow({required this.shop, this.onTap, super.key});

  final AssignedShop shop;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final reason = shop.attentionReason;
    final note = shop.note;

    return Semantics(
      button: onTap != null,
      label: l10n.shopsStatusAt(shop.name, _statusLabel(l10n)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 88),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: colors.border)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            shop.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  height: 20 / 16,
                                ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        AssignedShopStatusChip(
                          label: _statusLabel(l10n),
                          status: shop.status,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      shop.location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    if (reason != null)
                      Text(
                        reason,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.warning,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    else if (note != null)
                      Text(
                        note,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      )
                    else if (shop.coordinates != null)
                      Text(
                        l10n.shopsCoords(
                          shop.coordinates!,
                          shop.distance ?? '',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: scheme.onSurface),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Icon(
                Icons.chevron_right,
                color: scheme.onSurfaceVariant,
                size: AppSpacing.xl,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _statusLabel(AppLocalizations l10n) => switch (shop.status) {
    AssignedShopStatus.verified => l10n.shopsStatusVerified,
    AssignedShopStatus.queued => l10n.shopsStatusQueued,
    AssignedShopStatus.synced => l10n.shopsStatusSynced,
    AssignedShopStatus.needsAttention => l10n.shopsStatusNeedsAttention,
    AssignedShopStatus.notStarted => l10n.shopsStatusNotStarted,
  };
}
