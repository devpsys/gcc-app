import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_switch_track.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/notification_channel.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/last_sent_row.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/settings_row.dart';

/// Which channels an agent hears from, and when each last spoke.
///
/// Reports the last send and whether it landed, so a channel that is switched on
/// but silently failing is visible rather than silently wrong.
class NotificationChannelsPage extends StatelessWidget {
  const NotificationChannelsPage({
    required this.channels,
    this.onChanged,
    super.key,
  });

  final List<NotificationChannel> channels;
  final void Function(String id, bool enabled)? onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notificationsTitle),
        backgroundColor: scheme.surface,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            for (final channel in channels) ...[
              SettingsRow(
                label: _labelFor(context, channel.id),
                detail: channel.detail,
                trailing: AppSwitchTrack(
                  value: channel.enabled,
                  onChanged: onChanged == null
                      ? null
                      : (value) => onChanged!(channel.id, value),
                ),
              ),
              if (channel.lastSentAt.isNotEmpty) LastSentRow(channel: channel),
            ],
          ],
        ),
      ),
    );
  }

  String _labelFor(BuildContext context, String id) => switch (id) {
    'sms' => context.l10n.notificationsChannelSms,
    'push' => context.l10n.notificationsChannelPush,
    _ => context.l10n.notificationsChannelEmail,
  };
}
