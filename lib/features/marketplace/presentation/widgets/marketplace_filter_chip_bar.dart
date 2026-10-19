import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Horizontal filter chips under the search field.
class MarketplaceFilterChipBar extends StatelessWidget {
  const MarketplaceFilterChipBar({
    required this.activeCount,
    required this.availableNow,
    required this.withOperator,
    required this.onOpenFilters,
    required this.onToggleAvailable,
    required this.onToggleOperator,
    super.key,
  });

  final int activeCount;
  final bool availableNow;
  final bool withOperator;
  final VoidCallback onOpenFilters;
  final VoidCallback onToggleAvailable;
  final VoidCallback onToggleOperator;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _chip(
            context,
            label: l10n.marketplaceFilters,
            selected: activeCount > 0,
            trailing: activeCount > 0 ? '$activeCount' : null,
            onTap: onOpenFilters,
            leading: Icons.filter_list,
          ),
          const SizedBox(width: AppSpacing.xs),
          _chip(
            context,
            label: l10n.marketplaceAvailableNow,
            selected: availableNow,
            onTap: onToggleAvailable,
          ),
          const SizedBox(width: AppSpacing.xs),
          _chip(
            context,
            label: l10n.marketplaceWithOperator,
            selected: withOperator,
            onTap: onToggleOperator,
          ),
        ],
      ),
    );
  }

  Widget _chip(
    BuildContext context, {
    required String label,
    required bool selected,
    required VoidCallback onTap,
    IconData? leading,
    String? trailing,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Material(
      color: selected ? scheme.secondaryContainer : scheme.surface,
      shape: StadiumBorder(
        side: BorderSide(color: selected ? scheme.primary : colors.border),
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppDimensions.minTouchTarget - AppSpacing.xs,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leading != null) ...[
                  Icon(
                    leading,
                    size: AppDimensions.iconSm,
                    color: selected ? scheme.primary : scheme.onSurface,
                  ),
                  const SizedBox(width: AppSpacing.xxs),
                ],
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: selected ? scheme.primary : scheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: AppSpacing.xs),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xxs),
                      child: Text(
                        trailing,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: scheme.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
