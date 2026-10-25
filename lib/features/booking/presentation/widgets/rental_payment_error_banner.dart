import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class RentalPaymentErrorBanner extends StatelessWidget {
  const RentalPaymentErrorBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.dangerContainer,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.danger.withValues(alpha: 0.4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: colors.danger,
              size: AppDimensions.iconMd,
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                l10n.rentalPaymentCheckCard,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: colors.danger),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
