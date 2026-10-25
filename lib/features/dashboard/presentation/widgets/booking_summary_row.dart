import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/mono_identifier.dart';
import 'package:gcc_app/core/widgets/status_chip.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';

class BookingSummaryRow extends StatelessWidget {
  const BookingSummaryRow({
    required this.booking,
    required this.disabledReason,
    this.onOpen,
    super.key,
  });

  final DashboardBooking booking;
  final String disabledReason;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tone = switch (booking.status) {
      'due' => StatusTone.info,
      'completed' => StatusTone.muted,
      'disputed' => StatusTone.danger,
      _ => StatusTone.info,
    };
    final label = switch (booking.status) {
      'due' => l10n.dashboardStatusDue,
      'completed' => l10n.dashboardStatusCompleted,
      'disputed' => l10n.dashboardStatusDisputed,
      _ => l10n.dashboardStatusInUse,
    };
    return Tooltip(
      message: onOpen == null ? disabledReason : '',
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MonoIdentifier(value: booking.reference),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    booking.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    booking.detail,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            StatusChip(label: label, tone: tone),
            Icon(
              Icons.chevron_right,
              size: AppDimensions.iconSm,
              color: Theme.of(context).colorScheme.outline,
            ),
          ],
        ),
        ),
      ),
    );
  }
}
