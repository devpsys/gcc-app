import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/vendor/domain/naira_amount.dart';
import 'package:gcc_app/features/vendor/domain/vendor_rate_quote.dart';

class EditQuoteCard extends StatelessWidget {
  const EditQuoteCard({required this.quote, super.key});

  final VendorRateQuote quote;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final route = quote.deliveryRoute;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              quote.project
                  ? l10n.editProjectExample
                  : l10n.editExampleTitle(quote.days),
              style: Theme.of(context).textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.xs),
            _line(
              context,
              l10n.editRentalFee,
              fullNaira(quote.rental),
              quote.project
                  ? null
                  : l10n.editRentalDetail(
                      quote.days,
                      compactNaira(quote.dailyRate),
                    ),
            ),
            if (route != null && quote.delivery > 0)
              _line(
                context,
                l10n.editDelivery,
                fullNaira(quote.delivery),
                route,
              ),
            _line(
              context,
              l10n.editInsurance,
              fullNaira(quote.insurance),
              l10n.editInsuranceDetail,
            ),
            _line(
              context,
              l10n.editDeposit,
              fullNaira(quote.deposit),
              null,
              locked: true,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.editBuyerPays,
              style: Theme.of(context).textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            _line(
              context,
              l10n.editBeforeRefund,
              fullNaira(quote.buyerPays),
              null,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.editWalletLanding(fullNaira(quote.vendorReceives)),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _line(
    BuildContext context,
    String label,
    String value,
    String? detail, {
    bool locked = false,
  }) {
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodyMedium),
                if (detail != null)
                  Text(
                    detail,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          if (locked) ...[
            Icon(
              Icons.lock,
              size: AppDimensions.iconSm,
              color: colors.heldFunds,
            ),
            const SizedBox(width: AppSpacing.xxs),
          ],
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: locked ? colors.heldFunds : null,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
