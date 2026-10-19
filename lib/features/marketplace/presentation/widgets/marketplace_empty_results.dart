import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_cubit.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_state.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_popular_category_row.dart';

/// Empty browse frame: message, removable chips, clear, popular categories.
class MarketplaceEmptyResults extends StatelessWidget {
  const MarketplaceEmptyResults({required this.state, super.key});

  final MarketplaceBrowseReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final cubit = context.read<MarketplaceBrowseCubit>();
    final query = state.filters.query.trim();
    final quoted = query.isEmpty ? l10n.marketplaceFilters : '"$query"';
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: SizedBox.square(
              dimension: AppDimensions.emptyStateIcon,
              child: Icon(
                Icons.search_off,
                size: AppDimensions.iconLg,
                color: colors.muted,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.marketplaceEmptyTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            l10n.marketplaceEmptyBody(quoted, state.filters.activeCount),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: colors.muted),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            alignment: WrapAlignment.center,
            children: [
              if (state.filters.market != null)
                _removable(
                  context,
                  label: l10n.marketplaceMarketName(state.filters.market!),
                  onRemove: cubit.clearMarketFilter,
                ),
              if (state.filters.availableNow)
                _removable(
                  context,
                  label: l10n.marketplaceAvailableNow,
                  onRemove: cubit.toggleAvailableNow,
                ),
              if (state.filters.withOperator)
                _removable(
                  context,
                  label: l10n.marketplaceWithOperator,
                  onRemove: cubit.toggleOperator,
                ),
              for (final category in state.filters.categories)
                _removable(
                  context,
                  label: category,
                  onRemove: () => cubit.toggleCategory(category),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppPrimaryButton(
            label: l10n.marketplaceClearFilters,
            onPressed: cubit.clearFilters,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.marketplaceEmptyHint,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: colors.muted),
          ),
          const SizedBox(height: AppSpacing.lg),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.marketplacePopular,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colors.muted,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
              ),
            ),
          ),
          for (final facet in state.categoryFacets)
            if (facet.count > 0)
              MarketplacePopularCategoryRow(
                facet: facet,
                onTap: () {
                  cubit.setQuery('');
                  cubit.clearFilters();
                  cubit.toggleCategory(facet.name);
                },
              ),
        ],
      ),
    );
  }

  Widget _removable(
    BuildContext context, {
    required String label,
    required VoidCallback onRemove,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Material(
      color: scheme.surfaceContainerHighest,
      shape: StadiumBorder(side: BorderSide(color: colors.border)),
      child: InkWell(
        onTap: onRemove,
        customBorder: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(width: AppSpacing.xs),
              Icon(
                Icons.close,
                size: AppDimensions.iconSm,
                color: colors.muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
