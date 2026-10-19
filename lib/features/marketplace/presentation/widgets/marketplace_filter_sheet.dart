import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_toggle_switch.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_filters.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_cubit.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_state.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_category_row.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_market_bar.dart';

/// Browse filter sheet body from MOB-VND-03 frame 3.
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
        final min = filters.minRate ?? rateFilterFloor;
        final max = filters.maxRate ?? rateFilterCeiling;
        return ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            0,
            AppSpacing.md,
            AppSpacing.md,
          ),
          children: [
            Text(l10n.marketplaceMarket, style: _section(context)),
            const SizedBox(height: AppSpacing.xs),
            MarketplaceMarketBar(
              markets: state.markets,
              selected: filters.market,
              nearMeNotice: state.nearMeNotice,
              onAll: () => cubit.setMarket(null),
              onNearMe: cubit.selectNearMe,
              onMarket: cubit.setMarket,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.marketplaceAllMarketsResults(state.listings.length),
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: context.semanticColors.muted),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.marketplaceCategory, style: _section(context)),
            for (final facet in state.categoryFacets)
              MarketplaceCategoryRow(
                facet: facet,
                selected: filters.categories.contains(facet.name),
                onTap: () => cubit.toggleCategory(facet.name),
              ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: Text(l10n.marketplaceRate, style: _section(context)),
                ),
                Text(
                  '${fullNaira(min)} – ${fullNaira(max)}',
                  style: AppTextStyles.tabular(
                    Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            RangeSlider(
              values: RangeValues(min.toDouble(), max.toDouble()),
              min: rateFilterFloor.toDouble(),
              max: rateFilterCeiling.toDouble(),
              divisions: 50,
              labels: RangeLabels(fullNaira(min), fullNaira(max)),
              onChanged: (values) {
                cubit.setRateRange(values.start.round(), values.end.round());
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (final mark in const [0, 10000, 25000, 50000])
                  Text(
                    fullNaira(mark),
                    style: AppTextStyles.mono(
                      Theme.of(context).textTheme.labelSmall!
                          .copyWith(color: context.semanticColors.muted),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(l10n.marketplaceOptions, style: _section(context)),
            AppToggleSwitch(
              label: l10n.marketplaceAvailableNow,
              value: filters.availableNow,
              onChanged: (_) => cubit.toggleAvailableNow(),
            ),
            AppToggleSwitch(
              label: l10n.marketplaceWithCertifiedOperator,
              value: filters.withOperator,
              onChanged: (_) => cubit.toggleOperator(),
            ),
            AppToggleSwitch(
              label: l10n.marketplaceDepositUnder(
                fullNaira(depositFilterCeiling),
              ),
              value: filters.depositUnder,
              onChanged: (_) => cubit.toggleDepositUnder(),
            ),
            Text(
              l10n.marketplaceRateDepositConflict,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: state.rateDepositConflict
                    ? context.semanticColors.warning
                    : context.semanticColors.muted,
              ),
            ),
          ],
        );
      },
    );
  }

  TextStyle? _section(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall?.copyWith(
        color: context.semanticColors.muted,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
      );
}
