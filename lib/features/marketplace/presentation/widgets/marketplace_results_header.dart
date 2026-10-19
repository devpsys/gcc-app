import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_state.dart';

/// Result count and the inert sort label.
class MarketplaceResultsHeader extends StatelessWidget {
  const MarketplaceResultsHeader({required this.state, super.key});

  final MarketplaceBrowseReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final market = state.filters.market;
    final label = market != null
        ? l10n.marketplaceResultsInMarket(state.visible.length, market)
        : l10n.marketplaceResultsInMarkets(
            state.visible.length,
            state.markets.length,
          );
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.tabular(
                  Theme.of(context).textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Flexible(
              child: Align(
                alignment: Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    l10n.marketplaceSortRelevance,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: colors.muted),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
