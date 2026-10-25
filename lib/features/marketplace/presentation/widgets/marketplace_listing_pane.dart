import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/booking/presentation/rental_book_flow.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_listing_cubit.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_listing_state.dart';
import 'package:gcc_app/features/marketplace/presentation/pages/marketplace_listing_page.dart';
import 'package:go_router/go_router.dart';

/// Listing detail body for phone pages and tablet master-detail panes.
class MarketplaceListingPane extends StatelessWidget {
  const MarketplaceListingPane({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<MarketplaceListingCubit, MarketplaceListingState>(
      builder: (context, state) {
        return switch (state) {
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
            onBookNow: () => startRentalRequest(
              context: context,
              listingId: state.listing.id,
            ),
          ),
        };
      },
    );
  }
}
