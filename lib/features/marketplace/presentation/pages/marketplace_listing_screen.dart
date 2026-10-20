import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_listing_cubit.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_listing_state.dart';
import 'package:gcc_app/features/marketplace/presentation/pages/marketplace_listing_page.dart';
import 'package:go_router/go_router.dart';

class MarketplaceListingScreen extends StatelessWidget {
  const MarketplaceListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<MarketplaceListingCubit, MarketplaceListingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.dashboardBrowseEquipment),
            actions: [
              IconButton(
                tooltip: l10n.marketplaceShare,
                onPressed: null,
                icon: const Icon(Icons.ios_share_outlined),
              ),
              IconButton(
                tooltip: l10n.marketplaceMore,
                onPressed: null,
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          body: switch (state) {
            MarketplaceListingLoading() => const Center(
              child: AppLoadingIndicator(),
            ),
            MarketplaceListingFailed() => AppEmptyState(
              icon: Icons.cloud_off,
              title: l10n.dashboardLoadFailed,
              actionLabel: l10n.dashboardRetry,
              onAction: () => context.read<MarketplaceListingCubit>().load(),
            ),
            MarketplaceListingMissing() => AppEmptyState(
              icon: Icons.search_off,
              title: l10n.marketplaceMissing,
            ),
            MarketplaceListingReady() => MarketplaceListingPage(
              state: state,
              onOpen: (id) {
                final router = GoRouter.maybeOf(context);
                if (router == null) {
                  return;
                }
                router.push(RoutePaths.marketplaceListingOf(id));
              },
            ),
          },
        );
      },
    );
  }
}
