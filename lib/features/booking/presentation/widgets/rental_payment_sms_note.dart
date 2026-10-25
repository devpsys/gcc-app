import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class RentalPaymentSmsNote extends StatelessWidget {
  const RentalPaymentSmsNote({required this.orderReference, super.key});

  final String orderReference;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final base = Theme.of(context).textTheme.bodySmall
        ?.copyWith(color: colors.muted);
    final emph = base?.copyWith(
      color: Theme.of(context).colorScheme.onSurface,
      fontWeight: FontWeight.w700,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Text.rich(
        TextSpan(
          style: base,
          children: [
            TextSpan(text: l10n.rentalPaymentSmsLead),
            TextSpan(text: ' 1 ', style: emph),
            TextSpan(text: l10n.rentalPaymentSmsOr),
            TextSpan(text: ' 2', style: emph),
            TextSpan(text: l10n.rentalPaymentSmsMid),
            TextSpan(text: ' *722#', style: emph),
            TextSpan(text: l10n.rentalPaymentSmsTail(orderReference)),
          ],
        ),
      ),
    );
  }
}
