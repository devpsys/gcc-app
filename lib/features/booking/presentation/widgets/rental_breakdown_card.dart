import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/booking/domain/rental_delivery_mode.dart';
import 'package:gcc_app/features/booking/domain/rental_request.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_rates.dart';

class RentalBreakdownCard extends StatelessWidget {
  const RentalBreakdownCard({required this.request, super.key});

  final RentalRequest request;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final quote = request.quote;
    final insuranceDay = insurancePerDay(request.listing.dailyRate);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.rentalPriceBreakdown,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colors.muted,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            _line(
              context,
              title: l10n.rentalFee,
              detail: l10n.rentalFeeDetail(
                quote.days,
                fullNaira(request.listing.dailyRate),
              ),
              amount: fullNaira(quote.rental),
            ),
            if (request.deliveryMode == RentalDeliveryMode.deliver)
              _line(
                context,
                title: request.deliveryPlace,
                detail: l10n.rentalDelivery,
                amount: fullNaira(quote.delivery),
              ),
            if (request.withInsurance)
              _line(
                context,
                title: l10n.rentalMicroInsurance,
                detail: l10n.rentalInsuranceDetail(
                  fullNaira(insuranceDay),
                  quote.days,
                ),
                amount: fullNaira(quote.insurance),
              ),
            _line(
              context,
              title: l10n.rentalOperator,
              detail: request.withOperator
                  ? l10n.rentalOperatorDetail(
                      quote.days,
                      fullNaira(request.listing.operatorDailyFee),
                    )
                  : l10n.rentalOperatorNotRequested,
              amount: request.withOperator ? fullNaira(quote.operator) : null,
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.rentalChargedToday,
                        style: Theme.of(context).textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        request.withOperator
                            ? l10n.rentalChargedIncludesOperator
                            : l10n.rentalChargedIncludes,
                        style: Theme.of(context).textTheme.labelSmall
                            ?.copyWith(color: colors.muted),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      fullNaira(quote.chargedToday),
                      style: AppTextStyles.tabular(
                        Theme.of(context).textTheme.headlineSmall!
                            .copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _line(
    BuildContext context, {
    required String title,
    required String detail,
    required String? amount,
  }) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    detail,
                    style: AppTextStyles.tabular(
                      Theme.of(context).textTheme.bodySmall!
                          .copyWith(color: colors.muted),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount ?? l10n.rentalAmountDash,
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: amount == null ? colors.muted : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
