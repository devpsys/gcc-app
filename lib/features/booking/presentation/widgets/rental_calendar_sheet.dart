import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_date_labels.dart';

Future<void> showRentalCalendarSheet({
  required BuildContext context,
  required String title,
  required String orderReference,
  required DateTime from,
  required DateTime to,
}) {
  return showAppSheet<void>(
    context: context,
    title: context.l10n.rentalStatusAddCalendar,
    closeLabel: context.l10n.authClose,
    child: RentalCalendarSheet(
      title: title,
      orderReference: orderReference,
      from: from,
      to: to,
    ),
  );
}

class RentalCalendarSheet extends StatelessWidget {
  const RentalCalendarSheet({
    required this.title,
    required this.orderReference,
    required this.from,
    required this.to,
    super.key,
  });

  final String title;
  final String orderReference;
  final DateTime from;
  final DateTime to;

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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.rentalCalendarBody,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            orderReference,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colors.muted,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.rentalCalendarFrom(rentalDateTimeLabel(from)),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            l10n.rentalCalendarTo(rentalDateTimeLabel(to)),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppPrimaryButton(
            label: l10n.authClose,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
