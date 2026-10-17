import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_cubit.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_state.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/bounty_status_page.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/bounty_not_found_panel.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/agent_shell.dart';

/// The routed bounty status for one submission.
///
/// The reference comes from the route. The route provides [WalletCubit].
class BountyStatusScreen extends StatelessWidget {
  const BountyStatusScreen({required this.reference, super.key});

  final String reference;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AgentShell(
      selectedLocation: RoutePaths.agentQueue,
      title: l10n.bountyTitle,
      child: Scaffold(
        body: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            return switch (state) {
              WalletLoading() => const Center(child: AppLoadingIndicator()),
              WalletBountyReady(:final submission) when submission == null =>
                BountyNotFoundPanel(reference: reference),
              WalletBountyReady(:final submission) => BountyStatusPage(
                submission: submission!,
                onViewSubmission: () =>
                    GoRouter.maybeOf(context)?.push(RoutePaths.agentQueue),
                onViewInQueue: () =>
                    GoRouter.maybeOf(context)?.go(RoutePaths.agentQueue),
              ),
              WalletFailed() => AppEmptyState(
                icon: Icons.cloud_off,
                title: l10n.walletLoadFailed,
                actionLabel: l10n.dashboardRetry,
                onAction: () =>
                    context.read<WalletCubit>().loadBounty(reference),
              ),
              _ => const Center(child: AppLoadingIndicator()),
            };
          },
        ),
      ),
    );
  }
}
