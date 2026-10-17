import 'package:flutter/material.dart';

import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_balance.dart';
import 'package:gcc_app/features/agent_wallet/presentation/gateway/wallet_gateway.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/bounty_wallet_page.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/agent_shell.dart';

/// The routed bounty wallet.
///
/// Loads the balance and renders [BountyWalletPage] **inline** inside
/// [AgentShell].
///
/// This previously pushed the page as a new route once the balance arrived. A
/// pushed route sits *above* the shell's whole `Scaffold`, so it covered the
/// bottom navigation and the title bar — the wallet rendered full-screen with no
/// way back to Today. Rendering in place keeps the chrome the designs show under
/// every wallet frame.
///
/// Until a payout ledger exists the gateway reports a zero balance and no runs,
/// so the screen shows its new-agent state. That is the honest reading: the app
/// has no verified bounties to report, and inventing a balance would be
/// inventing a payment.
class AgentWalletScreen extends StatefulWidget {
  const AgentWalletScreen({super.key});

  @override
  State<AgentWalletScreen> createState() => _AgentWalletScreenState();
}

class _AgentWalletScreenState extends State<AgentWalletScreen> {
  Future<WalletBalance>? _balance;

  @override
  void initState() {
    super.initState();
    _balance = getIt<WalletGateway>().loadBalance();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AgentShell(
      selectedLocation: RoutePaths.agentWallet,
      title: l10n.walletTitle,
      child: Scaffold(
        body: FutureBuilder<WalletBalance>(
          future: _balance,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: AppLoadingIndicator());
            }
            return BountyWalletPage(
              balance: snapshot.data!,
              weeks: const [],
              runs: const [],
            );
          },
        ),
      ),
    );
  }
}
