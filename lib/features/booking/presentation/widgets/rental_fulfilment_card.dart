import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_toggle_switch.dart';
import 'package:gcc_app/features/booking/domain/rental_delivery_mode.dart';
import 'package:gcc_app/features/booking/domain/rental_request.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_rates.dart';

class RentalFulfilmentCard extends StatelessWidget {
  const RentalFulfilmentCard({
    required this.request,
    required this.onDeliveryMode,
    required this.onToggleOperator,
    required this.onToggleInsurance,
    super.key,
  });

  final RentalRequest request;
  final ValueChanged<RentalDeliveryMode> onDeliveryMode;
  final VoidCallback onToggleOperator;
  final VoidCallback onToggleInsurance;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final insurance = insurancePerDay(request.listing.dailyRate);
    final operatorCaption = request.withOperator
        ? fullNaira(request.quote.operator)
        : fullNaira(request.listing.operatorDailyFee);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppRadii.card),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xxs),
                child: Row(
                  children: [
                    Expanded(
                      child: _segment(
                        context,
                        label: l10n.rentalDeliverToMe,
                        selected:
                            request.deliveryMode == RentalDeliveryMode.deliver,
                        onTap: () => onDeliveryMode(RentalDeliveryMode.deliver),
                      ),
                    ),
                    Expanded(
                      child: _segment(
                        context,
                        label: l10n.rentalCollectFromYard,
                        selected:
                            request.deliveryMode == RentalDeliveryMode.collect,
                        onTap: () => onDeliveryMode(RentalDeliveryMode.collect),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppToggleSwitch(
              label: l10n.rentalAssignOperator,
              value: request.withOperator,
              onChanged: (_) => onToggleOperator(),
              caption: l10n.rentalOperatorDaily(operatorCaption),
              captionBesideSwitch: true,
            ),
            if (request.withOperator) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xs,
                  0,
                  AppSpacing.xs,
                  AppSpacing.xs,
                ),
                child: Text(
                  l10n.rentalOperatorNote,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: colors.muted),
                ),
              ),
            ],
            AppToggleSwitch(
              label: l10n.rentalMicroInsurance,
              value: request.withInsurance,
              onChanged: (_) => onToggleInsurance(),
              caption: l10n.rentalInsurancePerDay(fullNaira(insurance)),
              captionBesideSwitch: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _segment(
    BuildContext context, {
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: selected ? scheme.primary : scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(AppRadii.button),
      child: InkWell(
        onTap: selected ? null : onTap,
        borderRadius: BorderRadius.circular(AppRadii.button),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppDimensions.minTouchTarget - AppSpacing.xs,
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
