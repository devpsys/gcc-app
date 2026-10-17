import 'package:flutter/material.dart';

import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/notification_channel.dart';
import 'package:gcc_app/features/agent_wallet/presentation/gateway/wallet_gateway.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/notification_channels_page.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/agent_shell.dart';

/// The routed notification channel settings.
///
/// Loads the agent's channels rather than rendering an empty list, and carries
/// the agent navigation so there is a way back to the profile and to Today.
class NotificationChannelsScreen extends StatefulWidget {
  const NotificationChannelsScreen({super.key});

  @override
  State<NotificationChannelsScreen> createState() =>
      _NotificationChannelsScreenState();
}

class _NotificationChannelsScreenState
    extends State<NotificationChannelsScreen> {
  Future<List<NotificationChannel>>? _channels;

  @override
  void initState() {
    super.initState();
    _channels = getIt<WalletGateway>().loadNotificationChannels();
  }

  @override
  Widget build(BuildContext context) {
    return AgentShell(
      selectedLocation: RoutePaths.agentProfile,
      title: context.l10n.notificationsTitle,
      child: Scaffold(
        body: FutureBuilder<List<NotificationChannel>>(
          future: _channels,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: AppLoadingIndicator());
            }
            return NotificationChannelsPage(
              channels: snapshot.data ?? const [],
            );
          },
        ),
      ),
    );
  }
}
