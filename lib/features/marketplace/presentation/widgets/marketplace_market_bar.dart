import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Market segmented control: All, Near me, then each seeded market.
class MarketplaceMarketBar extends StatelessWidget {
  const MarketplaceMarketBar({
    required this.markets,
    required this.selected,
    required this.nearMeNotice,
    required this.onAll,
    required this.onNearMe,
    required this.onMarket,
    super.key,
  });

  final List<String> markets;
  final String? selected;
  final bool nearMeNotice;
  final VoidCallback onAll;
  final VoidCallback onNearMe;
  final ValueChanged<String> onMarket;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppRadii.card),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xxs),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _segment(
                    context,
                    label: l10n.marketplaceAll,
                    selected: selected == null && !nearMeNotice,
                    onTap: onAll,
                  ),
                  _segment(
                    context,
                    label: l10n.marketplaceNearMe,
                    selected: nearMeNotice,
                    onTap: onNearMe,
                  ),
                  for (final market in markets)
                    _segment(
                      context,
                      label: market,
                      selected: selected == market && !nearMeNotice,
                      onTap: () => onMarket(market),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (nearMeNotice) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            l10n.marketplaceNearMeBody,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }

  Widget _segment(
    BuildContext context, {
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.xxs),
      child: Material(
        color: selected ? scheme.primary : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.button),
        child: InkWell(
          onTap: selected ? null : onTap,
          borderRadius: BorderRadius.circular(AppRadii.button),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: AppDimensions.minTouchTarget - AppSpacing.xs,
              minWidth: AppSpacing.huge,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: selected ? scheme.onPrimary : scheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
