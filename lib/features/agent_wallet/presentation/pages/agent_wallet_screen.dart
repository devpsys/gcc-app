import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_cubit.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_state.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/bounty_wallet_page.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/agent_shell.dart';

/// The routed bounty wallet.
///
/// Renders [BountyWalletPage] inside [AgentShell] so the bottom navigation
/// stays available. The route provides [WalletCubit].
class AgentWalletScreen extends StatelessWidget {
  const AgentWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AgentShell(
      selectedLocation: RoutePaths.agentWallet,
      title: l10n.walletTitle,
      child: Scaffold(
        body: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            return switch (state) {
              WalletLoading() => const Center(child: AppLoadingIndicator()),
              WalletOverviewReady() => BountyWalletPage(
                balance: state.balance,
                weeks: state.weeks,
                runs: state.runs,
              ),
              WalletFailed() => AppEmptyState(
                icon: Icons.cloud_off,
                title: l10n.walletLoadFailed,
                actionLabel: l10n.dashboardRetry,
                onAction: () => context.read<WalletCubit>().loadOverview(),
              ),
              _ => const Center(child: AppLoadingIndicator()),
            };
          },
        ),
      ),
    );
  }
}
