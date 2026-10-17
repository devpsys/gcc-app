import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_cubit.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_state.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/notification_channels_page.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/agent_shell.dart';

/// The routed notification channel settings.
///
/// The route provides [WalletCubit].
class NotificationChannelsScreen extends StatelessWidget {
  const NotificationChannelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AgentShell(
      selectedLocation: RoutePaths.agentProfile,
      title: l10n.notificationsTitle,
      child: Scaffold(
        body: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            return switch (state) {
              WalletLoading() => const Center(child: AppLoadingIndicator()),
              WalletChannelsReady(:final channels) => NotificationChannelsPage(
                channels: channels,
              ),
              WalletFailed() => AppEmptyState(
                icon: Icons.cloud_off,
                title: l10n.walletLoadFailed,
                actionLabel: l10n.dashboardRetry,
                onAction: () => context.read<WalletCubit>().loadChannels(),
              ),
              _ => const Center(child: AppLoadingIndicator()),
            };
          },
        ),
      ),
    );
  }
}
