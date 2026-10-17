import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop_status.dart';

class MapPin extends StatelessWidget {
  const MapPin({super.key, required this.shop, required this.center});
  final MapShop shop;
  final Offset center;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final verified = shop.status == MapShopStatus.verified;
    final lead = shop.status == MapShopStatus.lead;
    final mine = shop.isMine && !verified;
    final dimension = verified || lead
        ? AppSpacing.xl
        : AppSpacing.md + AppSpacing.xxs;
    return Positioned(
      left: center.dx - dimension / 2,
      top: center.dy - dimension,
      child: Semantics(
        label: shop.name,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: lead
                ? scheme.surfaceContainerHighest
                : mine
                ? scheme.onSurface
                : scheme.primary,
            shape: BoxShape.circle,
            border: Border.all(
              color: lead ? scheme.outline : scheme.surface,
              width: 2,
            ),
          ),
          child: SizedBox.square(
            dimension: dimension,
            child: Icon(
              verified
                  ? Icons.check
                  : lead
                  ? Icons.circle_outlined
                  : null,
              size: AppSpacing.sm,
              color: lead ? scheme.onSurfaceVariant : scheme.surface,
            ),
          ),
        ),
      ),
    );
  }
}
