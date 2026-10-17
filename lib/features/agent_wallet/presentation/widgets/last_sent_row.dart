import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/notification_channel.dart';

/// The last send for one channel, and whether it arrived.
///
/// Laid out as two rows rather than one: the timestamp and its delivery state
/// belong together, and cramming label, timestamp, icon and status onto a single
/// line overflows a 360 px screen.
class LastSentRow extends StatelessWidget {
  const LastSentRow({required this.channel, super.key});

  final NotificationChannel channel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final tone = channel.delivered ? colors.success : colors.danger;

    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  l10n.notificationsLastSent,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                channel.lastSentAt,
                style: AppTextStyles.mono(
                  Theme.of(context).textTheme.labelSmall!
                      .copyWith(color: scheme.onSurface),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              // Delivery is stated outright rather than implied by the absence
              // of an error: a channel that silently failed looks identical to
              // one that simply has not spoken.
              Icon(
                channel.delivered ? Icons.check : Icons.close,
                size: AppSpacing.sm,
                color: tone,
              ),
              const SizedBox(width: AppSpacing.xxs),
              Text(
                channel.delivered
                    ? l10n.notificationsDelivered
                    : l10n.notificationsNotDelivered,
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: tone),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
