import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shop_status.dart';

/// The status pill on a work-list row.
///
/// Queued is info, verified and synced are success, needs-attention is
/// warning, and not-started is muted. There is deliberately no lock glyph
/// anywhere: the design forbids money context on this screen.
class AssignedShopStatusChip extends StatelessWidget {
  const AssignedShopStatusChip({
    required this.label,
    required this.status,
    super.key,
  });

  final String label;
  final AssignedShopStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final (background, foreground, border) = switch (status) {
      AssignedShopStatus.verified => (
        colors.successContainer,
        colors.success,
        colors.success.withValues(alpha: 0.25),
      ),
      AssignedShopStatus.synced => (
        colors.successContainer,
        colors.success,
        colors.success.withValues(alpha: 0.25),
      ),
      AssignedShopStatus.queued => (
        colors.infoContainer,
        colors.info,
        colors.info.withValues(alpha: 0.25),
      ),
      AssignedShopStatus.needsAttention => (
        colors.warningContainer,
        colors.warning,
        colors.warning.withValues(alpha: 0.25),
      ),
      AssignedShopStatus.notStarted => (
        scheme.surfaceContainerHighest,
        scheme.onSurfaceVariant,
        colors.border,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxs + 1,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.input),
        border: Border.all(color: border),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: foreground, fontWeight: FontWeight.w600),
      ),
    );
  }
}
