import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/shell_navigation_style.dart';
import 'package:gcc_app/core/widgets/wallet_mode_badge.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_wallet_cubit.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_wallet_state.dart';
import 'package:gcc_app/features/vendor/presentation/pages/vendor_wallet_page.dart';
import 'package:go_router/go_router.dart';

class VendorWalletScreen extends StatelessWidget {
  const VendorWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<VendorWalletCubit, VendorWalletState>(
      builder: (context, state) {
        final waiting = state is VendorWalletReady
            ? state.wallet.requestsWaiting
            : 0;
        return AppShell(
          title: l10n.dashboardWallet,
          menuLabel: l10n.openNavigationMenu,
          selectedLocation: RoutePaths.vendorWallet,
          navigationStyle: ShellNavigationStyle.topTabs,
          destinations: DashboardDestinations.vendor(
            l10n,
            requestsBadge: waiting,
          ),
          actions: [WalletModeBadge(label: l10n.walletModeVendor)],
          child: switch (state) {
            VendorWalletLoading() => const Center(child: AppLoadingIndicator()),
            VendorWalletFailed() => AppEmptyState(
              icon: Icons.cloud_off,
              title: l10n.dashboardLoadFailed,
              actionLabel: l10n.dashboardRetry,
              onAction: () => context.read<VendorWalletCubit>().load(),
            ),
            VendorWalletReady() => VendorWalletPage(
              state: state,
              onViewBookings: () => context.go(RoutePaths.vendorRequests),
              onWithdraw: () async {
                final updated = await context.push<VendorWallet>(
                  RoutePaths.vendorWithdraw,
                );
                if (!context.mounted || updated == null) {
                  return;
                }
                context.read<VendorWalletCubit>().apply(updated);
              },
            ),
          },
        );
      },
    );
  }
}
