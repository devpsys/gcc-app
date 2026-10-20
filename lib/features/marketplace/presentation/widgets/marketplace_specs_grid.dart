import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_spec.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_spec_kind.dart';

/// Two-column specifications grid from MOB-VND-04.
class MarketplaceSpecsGrid extends StatelessWidget {
  const MarketplaceSpecsGrid({required this.specs, super.key});

  final List<MarketplaceSpec> specs;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.marketplaceSpecs,
            style: Theme.of(context).textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.sm),
          for (var index = 0; index < specs.length; index += 2)
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: colors.border)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Row(
                  children: [
                    Expanded(child: _cell(context, specs[index])),
                    Expanded(
                      child: index + 1 < specs.length
                          ? _cell(context, specs[index + 1])
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _cell(BuildContext context, MarketplaceSpec spec) {
    final colors = context.semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _label(context, spec.kind),
          style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(color: colors.muted),
        ),
        Text(
          spec.value,
          style: AppTextStyles.tabular(
            Theme.of(context).textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  String _label(BuildContext context, MarketplaceSpecKind kind) {
    final l10n = context.l10n;
    return switch (kind) {
      MarketplaceSpecKind.capacity => l10n.marketplaceSpecCapacity,
      MarketplaceSpecKind.fuel => l10n.marketplaceSpecFuel,
      MarketplaceSpecKind.year => l10n.marketplaceSpecYear,
      MarketplaceSpecKind.serial => l10n.marketplaceSpecSerial,
      MarketplaceSpecKind.condition => l10n.marketplaceSpecCondition,
      MarketplaceSpecKind.hours => l10n.marketplaceSpecHours,
    };
  }
}
