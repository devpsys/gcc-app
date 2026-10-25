import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/booking/domain/rental_request.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_date_short.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

class RentalPaymentDueCard extends StatelessWidget {
  const RentalPaymentDueCard({required this.request, super.key});

  final RentalRequest request;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final quote = request.quote;
    final equipment = quote.rental + quote.delivery + quote.operator;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request.listing.title,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              l10n.rentalPaymentStayMeta(
                request.listing.yard,
                '${rentalDateShort(request.from)} → ${rentalDateShort(request.to)}',
              ),
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.muted),
            ),
            const SizedBox(height: AppSpacing.sm),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                fullNaira(quote.chargedToday),
                style: AppTextStyles.tabular(
                  Theme.of(context).textTheme.headlineMedium!
                      .copyWith(fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Text(
              l10n.rentalPaymentAmountDueNow,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colors.muted,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            _chipRow(
              context,
              label: l10n.rentalPaymentEquipment,
              amount: fullNaira(equipment),
              locked: false,
            ),
            if (quote.insurance > 0)
              _chipRow(
                context,
                label: l10n.rentalPaymentInsurance,
                amount: fullNaira(quote.insurance),
                locked: false,
              ),
            _chipRow(
              context,
              label: l10n.rentalPaymentRefundableDeposit,
              amount: fullNaira(quote.deposit),
              locked: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _chipRow(
    BuildContext context, {
    required String label,
    required String amount,
    required bool locked,
  }) {
    final colors = context.semanticColors;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '· $label',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.muted),
            ),
          ),
          if (locked) ...[
            Icon(
              Icons.lock,
              size: AppDimensions.iconSm,
              color: colors.heldFunds,
            ),
            const SizedBox(width: AppSpacing.xxs),
          ],
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                amount,
                style: AppTextStyles.tabular(
                  Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: locked ? colors.heldFunds : null,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
