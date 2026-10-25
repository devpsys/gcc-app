import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_split.dart';
import 'package:gcc_app/features/booking/domain/rental_request.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_date_labels.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

class RentalPaymentConfirmedBody extends StatelessWidget {
  const RentalPaymentConfirmedBody({
    required this.request,
    required this.orderReference,
    required this.vendorName,
    required this.split,
    required this.onBrowse,
    required this.onViewBooking,
    super.key,
  });

  final RentalRequest request;
  final String orderReference;
  final String vendorName;
  final RentalPaymentSplit split;
  final VoidCallback onBrowse;
  final VoidCallback onViewBooking;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final unavailable = l10n.dashboardActionUnavailable;
    return ListView(
      key: const Key('rental-payment-status-confirmed'),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Icon(
          Icons.check_circle,
          size: AppDimensions.noticeIcon,
          color: colors.success,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.rentalStatusConfirmedTitle,
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(
          orderReference,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w700, color: scheme.primary),
        ),
        Text(
          l10n.rentalStatusVendorNotified,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: colors.muted),
        ),
        const SizedBox(height: AppSpacing.md),
        _actionRow(
          context,
          icon: Icons.calendar_today,
          title: l10n.rentalStatusAddCalendar,
          detail: rentalDateTimeShort(request.from),
          onPressed: null,
          disabledReason: unavailable,
        ),
        _actionRow(
          context,
          icon: Icons.chat_outlined,
          title: l10n.rentalStatusMessageVendor,
          detail: vendorName,
          onPressed: null,
          disabledReason: unavailable,
        ),
        _actionRow(
          context,
          icon: Icons.precision_manufacturing_outlined,
          title: l10n.rentalStatusViewBooking,
          detail: l10n.rentalStatusTrackMachine,
          onPressed: onViewBooking,
          disabledReason: unavailable,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.rentalStatusSplitTitle,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: colors.muted,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        _splitLine(
          context,
          label: l10n.rentalStatusCommission,
          amount: fullNaira(split.commission),
          locked: false,
        ),
        _splitLine(
          context,
          label: l10n.rentalStatusVendorEscrow,
          amount: fullNaira(split.vendorEarnings),
          locked: false,
          detail: l10n.rentalStatusVendorEscrowDetail(request.listing.yard),
        ),
        _splitLine(
          context,
          label: l10n.rentalStatusDepositLocked,
          amount: fullNaira(split.deposit),
          locked: true,
        ),
        if (split.insurance > 0)
          _splitLine(
            context,
            label: l10n.rentalMicroInsurance,
            amount: fullNaira(split.insurance),
            locked: false,
          ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.rentalStatusTotalCharged,
                style: Theme.of(context).textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              fullNaira(split.chargedToday),
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.titleLarge!
                    .copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.rentalStatusAgentBountyNote(
            fullNaira(split.agentBountyFromCommission),
          ),
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: colors.muted),
        ),
        const SizedBox(height: AppSpacing.md),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.infoContainer.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(AppRadii.card),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.rentalStatusReturnBy(rentalDateTimeLabel(request.to)),
                  style: Theme.of(context).textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  l10n.rentalStatusReturnHint(fullNaira(split.deposit)),
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: colors.muted),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppPrimaryButton(
          label: l10n.rentalStatusBrowseMore,
          onPressed: onBrowse,
        ),
      ],
    );
  }

  Widget _actionRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String detail,
    required VoidCallback? onPressed,
    required String disabledReason,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: AppSecondaryButton(
        label: '$title · $detail',
        icon: icon,
        onPressed: onPressed,
        disabledReason: onPressed == null ? disabledReason : null,
      ),
    );
  }

  Widget _splitLine(
    BuildContext context, {
    required String label,
    required String amount,
    required bool locked,
    String? detail,
  }) {
    final colors = context.semanticColors;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                if (detail != null)
                  Text(
                    detail,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: colors.muted),
                  ),
              ],
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
          Text(
            amount,
            style: AppTextStyles.tabular(
              Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: locked ? colors.heldFunds : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
