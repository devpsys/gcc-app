import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop_status.dart';

/// The trailing status pill on a map sheet row.
///
/// Verified and synced are success, queued is info, and a lead stays neutral —
/// it is unverified ground, not a problem to flag.
class MapStatusPill extends StatelessWidget {
  const MapStatusPill({required this.status, super.key});
  final MapShopStatus status;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final (label, background, foreground, border) = switch (status) {
      MapShopStatus.verified => (
        l10n.mapFilterVerified,
        colors.successContainer,
        colors.success,
        colors.success,
      ),
      MapShopStatus.synced => (
        l10n.shopsStatusSynced,
        colors.successContainer,
        colors.success,
        colors.success,
      ),
      MapShopStatus.queued => (
        l10n.shopsStatusQueued,
        colors.infoContainer,
        colors.info,
        colors.info,
      ),
      MapShopStatus.lead => (
        l10n.mapLeadStatus,
        scheme.surfaceContainerHighest,
        scheme.onSurfaceVariant,
        colors.border,
      ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.micro),
        border: Border.all(color: border.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: foreground, fontWeight: FontWeight.w600),
      ),
    );
  }
}
