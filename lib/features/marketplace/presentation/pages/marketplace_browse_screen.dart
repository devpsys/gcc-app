import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_breakpoints.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/master_detail_split.dart';
import 'package:gcc_app/core/widgets/shell_navigation_style.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_language_chip.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_cubit.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_state.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_listing_cubit.dart';
import 'package:gcc_app/features/marketplace/presentation/pages/marketplace_browse_page.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_filter_actions.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_filter_sheet.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_listing_pane.dart';
import 'package:go_router/go_router.dart';

class MarketplaceBrowseScreen extends StatefulWidget {
  const MarketplaceBrowseScreen({super.key});

  @override
  State<MarketplaceBrowseScreen> createState() =>
      _MarketplaceBrowseScreenState();
}

class _MarketplaceBrowseScreenState extends State<MarketplaceBrowseScreen> {
  String? _selectedId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<MarketplaceBrowseCubit, MarketplaceBrowseState>(
      builder: (context, state) {
        final waiting = state is MarketplaceBrowseReady
            ? state.bookingsWaiting
            : 0;
        if (state is MarketplaceBrowseReady &&
            _selectedId != null &&
            state.visible.every((item) => item.id != _selectedId)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() => _selectedId = null);
            }
          });
        }
        return AppShell(
          title: l10n.dashboardBrowseEquipment,
          menuLabel: l10n.openNavigationMenu,
          selectedLocation: RoutePaths.browse,
          navigationStyle: ShellNavigationStyle.topTabs,
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
            MarketplaceBrowseReady() => MasterDetailSplit(
              master: MarketplaceBrowsePage(
                state: state,
                selectedId: _selectedId,
                onOpen: (id) => _openListing(context, id),
                onOpenFilters: () => _openFilters(context),
              ),
              detail: _detail(context),
            ),
          },
        );
      },
    );
  }

  Widget _detail(BuildContext context) {
    final l10n = context.l10n;
    final id = _selectedId;
    if (id == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Text(
            l10n.marketplaceTabletSelectListing,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: context.semanticColors.muted,
            ),
          ),
        ),
      );
    }
    return BlocProvider(
      key: ValueKey(id),
      create: (_) => getIt<MarketplaceListingCubit>(param1: id)..load(),
      child: const MarketplaceListingPane(),
    );
  }

  void _openListing(BuildContext context, String id) {
    final width = MediaQuery.sizeOf(context).width;
    if (AppBreakpoints.isTablet(width)) {
      setState(() => _selectedId = id);
      return;
    }
    GoRouter.maybeOf(context)?.push(RoutePaths.marketplaceListingOf(id));
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
