import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/shell_app_bar_style.dart';
import 'package:gcc_app/core/widgets/shell_navigation_style.dart';
import 'package:gcc_app/core/widgets/wallet_mode_badge.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_wallet_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_wallet_state.dart';
import 'package:gcc_app/features/booking/presentation/pages/lessee_wallet_page.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet.dart';
import 'package:go_router/go_router.dart';

class LesseeWalletScreen extends StatelessWidget {
  const LesseeWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<LesseeWalletCubit, LesseeWalletState>(
      builder: (context, state) {
        return AppShell(
          title: l10n.dashboardWallet,
          menuLabel: l10n.openNavigationMenu,
          selectedLocation: RoutePaths.wallet,
          navigationStyle: ShellNavigationStyle.topTabs,
          appBarStyle: ShellAppBarStyle.brand,
          destinations: DashboardDestinations.lessee(l10n),
          actions: [
            WalletModeBadge(
              label: l10n.walletModeLessee,
              appBarStyle: ShellAppBarStyle.brand,
            ),
          ],
          child: switch (state) {
            LesseeWalletLoading() => const Center(child: AppLoadingIndicator()),
            LesseeWalletFailed() => AppEmptyState(
              icon: Icons.cloud_off,
              title: l10n.dashboardLoadFailed,
              actionLabel: l10n.dashboardRetry,
              onAction: () => context.read<LesseeWalletCubit>().load(),
            ),
            LesseeWalletReady() => LesseeWalletPage(
              state: state,
              onViewBookings: () => context.go(RoutePaths.bookings),
              onViewStatement: null,
              onWithdraw: () async {
                final updated = await context.push<VendorWallet>(
                  RoutePaths.walletWithdraw,
                );
                if (!context.mounted || updated == null) {
                  return;
                }
                context.read<LesseeWalletCubit>().apply(updated);
              },
            ),
          },
        );
      },
    );
  }
}
