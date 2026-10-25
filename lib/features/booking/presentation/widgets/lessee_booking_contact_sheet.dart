import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';

Future<void> showLesseeBookingContactSheet({
  required BuildContext context,
  required String vendorName,
  required String vendorId,
  required String yard,
}) {
  return showAppSheet<void>(
    context: context,
    title: context.l10n.bookingsContactVendorTitle,
    closeLabel: context.l10n.authClose,
    child: LesseeBookingContactSheet(
      vendorName: vendorName,
      vendorId: vendorId,
      yard: yard,
    ),
  );
}

class LesseeBookingContactSheet extends StatelessWidget {
  const LesseeBookingContactSheet({
    required this.vendorName,
    required this.vendorId,
    required this.yard,
    super.key,
  });

  final String vendorName;
  final String vendorId;
  final String yard;

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
            l10n.bookingsContactVendorBody,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            vendorName,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            yard,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colors.muted,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.bookingsContactVendorId(vendorId),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
