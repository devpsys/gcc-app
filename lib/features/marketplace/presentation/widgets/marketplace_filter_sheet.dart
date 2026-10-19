import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_filters.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_cubit.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_state.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_choice.dart';

const marketplaceRateStops = [10000, 25000, 50000];

/// The browse filters. Near me has no location, so it stays unavailable.
class MarketplaceFilterSheet extends StatelessWidget {
  const MarketplaceFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketplaceBrowseCubit, MarketplaceBrowseState>(
      builder: (context, state) {
        if (state is! MarketplaceBrowseReady) {
          return const SizedBox.shrink();
        }
        final l10n = context.l10n;
        final cubit = context.read<MarketplaceBrowseCubit>();
        final filters = state.filters;
        return ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text(l10n.marketplaceMarket, style: _heading(context)),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              children: [
                MarketplaceChoice(
                  label: l10n.marketplaceAllMarkets,
                  selected: filters.market == null,
                  onSelected: () => cubit.setMarket(null),
                ),
                for (final market in state.markets)
                  MarketplaceChoice(
                    label: market,
                    selected: filters.market == market,
                    onSelected: () => cubit.setMarket(market),
                  ),
                MarketplaceChoice(
                  label: l10n.marketplaceNearMe,
                  selected: false,
                  onSelected: null,
                ),
              ],
            ),
            Text(
              l10n.dashboardActionUnavailable,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.marketplaceCategories, style: _heading(context)),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              children: [
                for (final entry in state.categoryCounts.entries)
                  MarketplaceChoice(
                    label: l10n.marketplaceCategoryCount(
                      entry.key,
                      entry.value,
                    ),
                    selected: filters.categories.contains(entry.key),
                    onSelected: () => cubit.toggleCategory(entry.key),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.marketplaceRate, style: _heading(context)),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              children: [
                MarketplaceChoice(
                  label: l10n.marketplaceAnyRate,
                  selected: filters.maxRate == null,
                  onSelected: () => cubit.setMaxRate(null),
                ),
                for (final rate in marketplaceRateStops)
                  MarketplaceChoice(
                    label: fullNaira(rate),
                    selected: filters.maxRate == rate,
                    onSelected: () => cubit.setMaxRate(rate),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.marketplaceAvailableNow),
              value: filters.availableNow,
              onChanged: (_) => cubit.toggleAvailableNow(),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.marketplaceWithOperator),
              value: filters.withOperator,
              onChanged: (_) => cubit.toggleOperator(),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                l10n.marketplaceDepositUnder(fullNaira(depositFilterCeiling)),
              ),
              value: filters.depositUnder,
              onChanged: (_) => cubit.toggleDepositUnder(),
            ),
            if (state.rateDepositConflict)
              Text(
                l10n.marketplaceRateDepositConflict,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: context.semanticColors.warning),
              ),
          ],
        );
      },
    );
  }

  TextStyle? _heading(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall;
}
