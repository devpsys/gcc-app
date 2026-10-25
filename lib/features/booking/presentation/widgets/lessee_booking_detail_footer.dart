import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_detail.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_detail_phase.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

class LesseeBookingDetailFooter extends StatelessWidget {
  const LesseeBookingDetailFooter({
    required this.detail,
    this.onReviewReturn,
    super.key,
  });

  final LesseeBookingDetail detail;
  final VoidCallback? onReviewReturn;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    final unavailable = l10n.dashboardActionUnavailable;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.xs + AppSpacing.xxs / 2,
            AppSpacing.md,
            AppSpacing.xs + AppSpacing.xxs / 2,
          ),
          child: switch (detail.phase) {
            LesseeBookingDetailPhase.reviewPending => AppPrimaryButton(
              label: l10n.bookingsReviewReturn,
              onPressed: onReviewReturn,
              disabledReason: onReviewReturn == null ? unavailable : null,
            ),
            LesseeBookingDetailPhase.completed => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: AppDimensions.iconSm,
                      color: colors.success,
                    ),
                    const SizedBox(width: AppSpacing.tight),
                    Expanded(
                      child: Text(
                        l10n.bookingsDetailDepositReleasedBanner(
                          fullNaira(detail.depositReleasedAmount ?? 0),
                        ),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                AppSecondaryButton(
                  label: l10n.bookingsDetailRateRental,
                  onPressed: null,
                  disabledReason: unavailable,
                ),
              ],
            ),
          },
        ),
      ),
    );
  }
}
