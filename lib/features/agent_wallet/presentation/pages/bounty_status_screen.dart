import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/bounty_submission.dart';
import 'package:gcc_app/features/agent_wallet/presentation/gateway/wallet_gateway.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/bounty_status_page.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/bounty_not_found_panel.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/agent_shell.dart';

/// The routed bounty status for one submission.
///
/// Wrapped in [AgentShell] because the designs put the agent navigation under
/// this screen and because a bounty screen with no way back is a dead end.
///
/// The reference comes from the route, so this works for any submission rather
/// than a hard-coded one.
class BountyStatusScreen extends StatefulWidget {
  const BountyStatusScreen({required this.reference, super.key});

  final String reference;

  @override
  State<BountyStatusScreen> createState() => _BountyStatusScreenState();
}

class _BountyStatusScreenState extends State<BountyStatusScreen> {
  Future<BountySubmission?>? _submission;

  @override
  void initState() {
    super.initState();
    _submission = getIt<WalletGateway>().loadBountySubmission(widget.reference);
  }

  @override
  Widget build(BuildContext context) {
    return AgentShell(
      selectedLocation: RoutePaths.agentQueue,
      title: context.l10n.bountyTitle,
      child: Scaffold(
        body: FutureBuilder<BountySubmission?>(
          future: _submission,
          builder: (context, snapshot) {
            if (!snapshot.hasData && !snapshot.hasError) {
              return const Center(child: AppLoadingIndicator());
            }
            final submission = snapshot.data;
            if (submission == null) {
              return BountyNotFoundPanel(reference: widget.reference);
            }
            return BountyStatusPage(
              submission: submission,
              onViewSubmission: () =>
                  GoRouter.maybeOf(context)?.push(RoutePaths.agentQueue),
              onViewInQueue: () =>
                  GoRouter.maybeOf(context)?.go(RoutePaths.agentQueue),
            );
          },
        ),
      ),
    );
  }
}
