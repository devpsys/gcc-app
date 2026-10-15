import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_choice_chip.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/shop_category.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

class ShopCategoryChips extends StatelessWidget {
  const ShopCategoryChips({
    required this.selected,
    required this.onToggled,
    this.errorText,
    super.key,
  });

  final List<ShopCategory> selected;
  final ValueChanged<ShopCategory> onToggled;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final error = errorText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.captureCategoriesHint,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.sm),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            border: Border.all(color: context.semanticColors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xs),
            child: Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final category in ShopCategory.values)
                  AppChoiceChip(
                    label: _label(l10n, category),
                    selected: selected.contains(category),
                    onSelected: (_) => onToggled(category),
                  ),
              ],
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            error,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  String _label(AppLocalizations l10n, ShopCategory category) {
    return switch (category) {
      ShopCategory.generators => l10n.captureCategoryGenerators,
      ShopCategory.welding => l10n.captureCategoryWelding,
      ShopCategory.waterPumps => l10n.captureCategoryWaterPumps,
      ShopCategory.buildingMaterials => l10n.captureCategoryBuilding,
      ShopCategory.electrical => l10n.captureCategoryElectrical,
      ShopCategory.catering => l10n.captureCategoryCatering,
      ShopCategory.sound => l10n.captureCategorySound,
      ShopCategory.generatorParts => l10n.captureCategoryParts,
      ShopCategory.beverages => l10n.captureCategoryBeverages,
      ShopCategory.lighting => l10n.captureCategoryLighting,
      ShopCategory.compression => l10n.captureCategoryCompression,
      ShopCategory.fertilizer => l10n.captureCategoryFertilizer,
    };
  }
}
