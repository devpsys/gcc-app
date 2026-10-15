import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/status_chip.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_thumb.dart';

class EquipmentResultRow extends StatelessWidget {
  const EquipmentResultRow({
    required this.listing,
    required this.availableLabel,
    required this.perDay,
    required this.disabledReason,
    super.key,
  });

  final DashboardEquipment listing;
  final String availableLabel;
  final String perDay;
  final String disabledReason;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final price = Theme.of(context).textTheme.bodyMedium
        ?.copyWith(fontWeight: FontWeight.w600);
    return Tooltip(
      message: disabledReason,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DashboardThumb(),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.title,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    listing.place,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    listing.specification,
                    style: AppTextStyles.mono(
                      Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: scheme.onSurfaceVariant,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  StatusChip(
                    label: listing.available
                        ? availableLabel
                        : listing.availability,
                    tone: listing.available
                        ? StatusTone.success
                        : StatusTone.info,
                    icon: listing.available ? Icons.check : null,
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    listing.price,
                    textAlign: TextAlign.end,
                    style: price == null ? null : AppTextStyles.tabular(price),
                  ),
                  Text(
                    perDay,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
