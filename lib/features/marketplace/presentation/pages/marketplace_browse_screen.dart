import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_language_chip.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_cubit.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_state.dart';
import 'package:gcc_app/features/marketplace/presentation/pages/marketplace_browse_page.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_filter_actions.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_filter_sheet.dart';
import 'package:go_router/go_router.dart';

class MarketplaceBrowseScreen extends StatelessWidget {
  const MarketplaceBrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<MarketplaceBrowseCubit, MarketplaceBrowseState>(
      builder: (context, state) {
        final waiting = state is MarketplaceBrowseReady
            ? state.bookingsWaiting
            : 0;
        return AppShell(
          title: l10n.dashboardBrowseEquipment,
          menuLabel: l10n.openNavigationMenu,
          selectedLocation: RoutePaths.browse,
          destinations: DashboardDestinations.lessee(
            l10n,
            bookingsBadge: waiting,
          ),
          actions: const [DashboardLanguageChip()],
          child: switch (state) {
            MarketplaceBrowseLoading() => const Center(
              child: AppLoadingIndicator(),
            ),
            MarketplaceBrowseFailed() => AppEmptyState(
              icon: Icons.cloud_off,
              title: l10n.dashboardLoadFailed,
              actionLabel: l10n.dashboardRetry,
              onAction: () => context.read<MarketplaceBrowseCubit>().load(),
            ),
            MarketplaceBrowseReady() => MarketplaceBrowsePage(
              state: state,
              onOpen: (id) {
                final router = GoRouter.maybeOf(context);
                if (router == null) {
                  return;
                }
                router.push(RoutePaths.marketplaceListingOf(id));
              },
              onOpenFilters: () => _openFilters(context),
            ),
          },
        );
      },
    );
  }

  void _openFilters(BuildContext context) {
    final cubit = context.read<MarketplaceBrowseCubit>();
    showAppSheet<void>(
      context: context,
      title: context.l10n.marketplaceFilters,
      child: BlocProvider.value(
        value: cubit,
        child: const MarketplaceFilterSheet(),
      ),
      footer: BlocProvider.value(
        value: cubit,
        child: MarketplaceFilterActions(
          onClose: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
