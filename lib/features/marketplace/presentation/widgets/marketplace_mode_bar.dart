import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_state.dart';

class MarketplaceModeBar extends StatelessWidget {
  const MarketplaceModeBar({
    required this.selected,
    required this.labels,
    required this.onSelected,
    super.key,
  });

  final MarketplaceMode selected;
  final Map<MarketplaceMode, String> labels;
  final ValueChanged<MarketplaceMode> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxs),
        child: Row(
          children: [
            for (final mode in MarketplaceMode.values)
              Expanded(child: _choice(context, mode, labels[mode] ?? '')),
          ],
        ),
      ),
    );
  }

  Widget _choice(BuildContext context, MarketplaceMode mode, String label) {
    final scheme = Theme.of(context).colorScheme;
    final selected = mode == this.selected;
    return Material(
      color: selected ? scheme.primary : scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(AppRadii.button),
      child: InkWell(
        onTap: selected ? null : () => onSelected(mode),
        borderRadius: BorderRadius.circular(AppRadii.button),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppDimensions.minTouchTarget,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
              child: FittedBox(
                fit: BoxFit.scaleDown,
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
