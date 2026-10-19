import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_cubit.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_state.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_choice.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_listing_card.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_mode_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
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
        const SizedBox(height: AppSpacing.sm),
        MarketplaceModeBar(
          selected: state.mode,
          labels: {
            MarketplaceMode.rentals: l10n.marketplaceRentals,
            MarketplaceMode.bulk: l10n.marketplaceBulk,
          },
          onSelected: cubit.setMode,
        ),
        const SizedBox(height: AppSpacing.md),
        if (state.mode == MarketplaceMode.bulk)
          AppEmptyState(
            icon: Icons.inventory_2_outlined,
            title: l10n.marketplaceBulkEmpty,
            message: l10n.marketplaceBulkEmptyBody,
          )
        else ...[
          if (state.recentSearches.isNotEmpty &&
              state.filters.query.isEmpty) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.marketplaceRecent,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: TextButton(
                        onPressed: cubit.clearRecent,
                        child: Text(l10n.marketplaceClearAll),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Wrap(
              children: [
                for (final search in state.recentSearches)
                  MarketplaceChoice(
                    label: search.label,
                    selected: false,
                    onSelected: () => cubit.setQuery(search.query),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          Wrap(
            children: [
              MarketplaceChoice(
                label: state.filters.activeCount == 0
                    ? l10n.marketplaceFilters
                    : l10n.marketplaceFilterCount(state.filters.activeCount),
                selected: state.filters.activeCount > 0,
                onSelected: widget.onOpenFilters,
              ),
              MarketplaceChoice(
                label: l10n.marketplaceAvailableNow,
                selected: state.filters.availableNow,
                onSelected: cubit.toggleAvailableNow,
              ),
              MarketplaceChoice(
                label: l10n.marketplaceWithOperator,
                selected: state.filters.withOperator,
                onSelected: cubit.toggleOperator,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.marketplaceResults(state.visible.length),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      l10n.marketplaceSortRelevance,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (state.visible.isEmpty)
            _empty(context, state)
          else
            for (final listing in state.visible) ...[
              MarketplaceListingCard(
                listing: listing,
                onOpen: () => widget.onOpen(listing.id),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
        ],
      ],
    );
  }

  Widget _empty(BuildContext context, MarketplaceBrowseReady state) {
    final l10n = context.l10n;
    final cubit = context.read<MarketplaceBrowseCubit>();
    final query = state.filters.query.trim();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppEmptyState(
          icon: Icons.search_off,
          title: l10n.marketplaceEmptyTitle,
          message: l10n.marketplaceEmptyBody(
            query.isEmpty ? l10n.marketplaceFilters : '"$query"',
            state.filters.activeCount,
          ),
        ),
        Text(
          l10n.marketplacePopular,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          children: [
            for (final category in state.categoryCounts.keys)
              MarketplaceChoice(
                label: category,
                selected: false,
                onSelected: () {
                  cubit.setQuery('');
                  if (!state.filters.categories.contains(category)) {
                    cubit.toggleCategory(category);
                  }
                },
              ),
          ],
        ),
      ],
    );
  }
}
