import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop_status.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_status_glyph.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_status_pill.dart';

/// One shop in the map's sheet list.
///
/// The status glyph leads rather than trailing, because a map list is scanned
/// by shape first. Rows are separated by a hairline, as the design does.
class MapShopRow extends StatelessWidget {
  const MapShopRow({required this.shop, this.onTap, super.key});
  final MapShop shop;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final verified = shop.status == MapShopStatus.verified;
    final lead = shop.status == MapShopStatus.lead;
    final mine = shop.isMine && !verified;
    final provenance = shop.provenance;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.semanticColors.border),
        ),
      ),
      child: Semantics(
        button: onTap != null,
        label: l10n.mapOpensShop(shop.name),
        child: InkWell(
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(minHeight: 64),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            child: Row(
              children: [
                MapStatusGlyph(verified: verified, lead: lead, mine: mine),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        shop.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        // Positional order follows the generated parameter
                        // names (alphabetical), not the message order.
                        l10n.mapShopMeta(
                          shop.distanceLabel,
                          shop.line,
                          shop.zone,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: mine
                                ? scheme.primary
                                : scheme.onSurfaceVariant,
                            fontWeight: mine ? FontWeight.w600 : null,
                          ),
                        ),
                      ),
                      if (provenance != null)
                        Text(
                          provenance,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                MapStatusPill(status: shop.status),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
