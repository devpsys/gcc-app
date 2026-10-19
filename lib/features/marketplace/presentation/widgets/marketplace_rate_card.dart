import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_rates.dart';

class MarketplaceRateCard extends StatelessWidget {
  const MarketplaceRateCard({required this.daily, super.key});

  final int daily;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.marketplaceRates,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        _row(context, l10n.marketplaceDaily, fullNaira(daily)),
        _row(context, l10n.marketplaceWeekly, fullNaira(weeklyRate(daily))),
        _row(context, l10n.marketplaceMonthly, fullNaira(monthlyRate(daily))),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.marketplaceRateNote,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _row(BuildContext context, String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                amount,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
