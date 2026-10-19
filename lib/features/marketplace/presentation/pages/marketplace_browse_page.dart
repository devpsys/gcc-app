import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_cubit.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_state.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_empty_results.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_filter_chip_bar.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_listing_card.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_mode_bar.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_recent_search_row.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_results_header.dart';

class MarketplaceBrowsePage extends StatefulWidget {
  const MarketplaceBrowsePage({
    required this.state,
    required this.onOpen,
    required this.onOpenFilters,
    super.key,
  });

  final MarketplaceBrowseReady state;
  final ValueChanged<String> onOpen;
  final VoidCallback onOpenFilters;

  @override
  State<MarketplaceBrowsePage> createState() => _MarketplaceBrowsePageState();
}

class _MarketplaceBrowsePageState extends State<MarketplaceBrowsePage> {
  late final TextEditingController _query;

  @override
  void initState() {
    super.initState();
    _query = TextEditingController(text: widget.state.filters.query);
  }

  @override
  void didUpdateWidget(MarketplaceBrowsePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final next = widget.state.filters.query;
    if (next != _query.text) {
      _query.text = next;
    }
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final l10n = context.l10n;
    final cubit = context.read<MarketplaceBrowseCubit>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.md,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MarketplaceModeBar(
                selected: state.mode,
                labels: {
                  MarketplaceMode.rentals: l10n.marketplaceRentals,
                  MarketplaceMode.bulk: l10n.marketplaceBulk,
                },
                onSelected: cubit.setMode,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _query,
                decoration: InputDecoration(
                  hintText: l10n.marketplaceSearchHint,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _query.text.isEmpty
                      ? null
                      : IconButton(
                          tooltip: l10n.marketplaceClearSearch,
                          onPressed: () {
                            _query.clear();
                            cubit.setQuery('');
                          },
                          icon: const Icon(Icons.close),
                        ),
                ),
                onChanged: cubit.setQuery,
              ),
            ],
          ),
        ),
        Expanded(
          child: state.mode == MarketplaceMode.bulk
              ? AppEmptyState(
                  icon: Icons.inventory_2_outlined,
                  title: l10n.marketplaceBulkEmpty,
                  message: l10n.marketplaceBulkEmptyBody,
                )
              : ListView(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  children: [
                    if (state.recentSearches.isNotEmpty &&
                        state.filters.query.isEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md,
                          AppSpacing.sm,
                          AppSpacing.md,
                          0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    l10n.marketplaceRecent,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: context.semanticColors.muted,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.6,
                                        ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: cubit.clearRecent,
                                  child: Text(l10n.marketplaceClearAll),
                                ),
                              ],
                            ),
                            for (final search in state.recentSearches)
                              MarketplaceRecentSearchRow(
                                search: search,
                                onTap: () => cubit.setQuery(search.query),
                              ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        AppSpacing.sm,
                        AppSpacing.md,
                        AppSpacing.sm,
                      ),
                      child: MarketplaceFilterChipBar(
                        activeCount: state.filters.activeCount,
                        availableNow: state.filters.availableNow,
                        withOperator: state.filters.withOperator,
                        onOpenFilters: widget.onOpenFilters,
                        onToggleAvailable: cubit.toggleAvailableNow,
                        onToggleOperator: cubit.toggleOperator,
                      ),
                    ),
                    MarketplaceResultsHeader(state: state),
                    if (state.visible.isEmpty)
                      MarketplaceEmptyResults(state: state)
                    else
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Column(
                          children: [
                            for (final listing in state.visible) ...[
                              MarketplaceListingCard(
                                listing: listing,
                                onOpen: () => widget.onOpen(listing.id),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                            ],
                          ],
                        ),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}
