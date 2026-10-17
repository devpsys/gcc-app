import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/connection_quality.dart';

/// The app-bar strip showing connection at a glance.
class SyncStatusStrip extends StatelessWidget {
  const SyncStatusStrip({required this.connection, super.key});
  final ConnectionQuality connection;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final (label, tone) = switch (connection) {
      ConnectionQuality.offline => (l10n.syncStripOffline, colors.warning),
      ConnectionQuality.capped => (l10n.syncStripDataLimit, colors.danger),
      ConnectionQuality.syncing => (
        l10n.syncStripSyncing('3', '7'),
        colors.warning,
      ),
      ConnectionQuality.weak => (l10n.syncConnectionWeak, colors.warning),
      ConnectionQuality.online => (l10n.syncConnectionOnline, colors.success),
    };
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadii.input),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: tone, fontWeight: FontWeight.w700),
      ),
    );
  }
}
