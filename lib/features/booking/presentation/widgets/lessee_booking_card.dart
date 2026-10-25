import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_button_frame.dart';
import 'package:gcc_app/core/widgets/app_destructive_button.dart';
import 'package:gcc_app/core/widgets/app_neutral_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/core/widgets/status_chip.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_enums.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_booking_deposit_row.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_date_labels.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_date_short.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

class LesseeBookingCard extends StatelessWidget {
  const LesseeBookingCard({
    required this.booking,
    this.onOpen,
    this.onReviewReturn,
    this.onMessageVendor,
    this.onRate,
    this.onRemove,
    super.key,
  });

  final LesseeBooking booking;
  final VoidCallback? onOpen;
  final VoidCallback? onReviewReturn;
  final VoidCallback? onMessageVendor;
  final VoidCallback? onRate;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final warningEdge = booking.needsAction;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            border: Border.all(color: colors.border),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ColoredBox(
                    color: warningEdge ? colors.warning : colors.border,
                    child: const SizedBox(
                      width: AppDimensions.accentBorderWidth,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.sm,
                        AppSpacing.sm,
                        AppSpacing.sm,
                        AppSpacing.sm,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _topRow(context),
                          const SizedBox(
                            height: AppSpacing.xs + AppSpacing.xxs / 2,
                          ),
                          _timingPriceRow(context),
                          if (_subStatus(context) case final sub?) ...[
                            const SizedBox(
                              height: AppSpacing.xs + AppSpacing.xxs / 2,
                            ),
                            sub,
                          ],
                          if (booking.depositHeld) ...[
                            const SizedBox(
                              height: AppSpacing.xs + AppSpacing.xxs / 2,
                            ),
                            LesseeBookingDepositRow(amount: booking.deposit),
                          ],
                          if (_footer(context) case final footer?) ...[
                            const SizedBox(
                              height: AppSpacing.xs + AppSpacing.xxs / 2,
                            ),
                            footer,
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _topRow(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final mutedTitle = booking.status == LesseeBookingStatus.cancelled;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _thumb(context),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      booking.reference,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.tabular(
                        Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Flexible(
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.centerEnd,
                        child: StatusChip(
                          label: _statusLabel(l10n),
                          tone: _statusTone(),
                          icon: _statusIcon(),
                          shrinkWrap: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxs / 2),
              Text(
                booking.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: mutedTitle ? colors.muted : null,
                ),
              ),
              Text(
                booking.yard,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.muted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _timingPriceRow(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final muted = booking.status == LesseeBookingStatus.cancelled;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.xxs / 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Text(
                _dates(l10n),
                style: AppTextStyles.tabular(
                  Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: colors.muted,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              fullNaira(booking.amount),
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: muted ? colors.muted : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget? _subStatus(BuildContext context) {
    final colors = context.semanticColors;
    final l10n = context.l10n;
    final String? detail;
    final Color color;
    final IconData icon;
    if (booking.depositNeverCharged) {
      detail = l10n.bookingsDepositNeverCharged;
      color = colors.muted;
      icon = Icons.remove_circle_outline;
    } else if (booking.statusDetail != null) {
      detail = booking.statusDetail;
      color = switch (booking.status) {
        LesseeBookingStatus.actionNeeded => colors.warning,
        LesseeBookingStatus.completed => colors.success,
        LesseeBookingStatus.inUse ||
        LesseeBookingStatus.outForDelivery => colors.info,
        LesseeBookingStatus.cancelled => colors.muted,
      };
      icon = switch (booking.status) {
        LesseeBookingStatus.completed => Icons.check_circle_outline,
        LesseeBookingStatus.actionNeeded => Icons.circle,
        _ => Icons.circle,
      };
    } else {
      return null;
    }
    return Row(
      children: [
        Icon(icon, size: AppDimensions.iconSm - 2, color: color),
        const SizedBox(width: AppSpacing.tight),
        Expanded(
          child: Text(
            detail!,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: booking.needsAction
                  ? FontWeight.w500
                  : FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget? _footer(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final unavailable = l10n.dashboardActionUnavailable;
    return switch (booking.status) {
      LesseeBookingStatus.actionNeeded => AppButtonFrame(
        expand: true,
        disabledReason: onReviewReturn == null ? unavailable : null,
        button: OutlinedButton(
          onPressed: onReviewReturn,
          style: OutlinedButton.styleFrom(
            foregroundColor: colors.warning,
            disabledForegroundColor: colors.warning,
            side: BorderSide(
              color: colors.warning,
              width: AppDimensions.focusBorderWidth,
            ),
            minimumSize: const Size(
              AppDimensions.minTouchTarget,
              AppDimensions.buttonHeight,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.button),
            ),
          ),
          child: Text(l10n.bookingsReviewReturn),
        ),
      ),
      LesseeBookingStatus.inUse => AppNeutralButton(
        label: l10n.bookingsMessageVendor,
        onPressed: onMessageVendor,
        disabledReason: onMessageVendor == null ? unavailable : null,
      ),
      LesseeBookingStatus.completed when booking.rating != null => DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: colors.border)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: AppSpacing.tight),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  l10n.bookingsRated(booking.rating!),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.warning,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: onRate,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      l10n.bookingsRateAgain,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: onRate == null
                            ? colors.muted
                            : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      LesseeBookingStatus.cancelled => AppDestructiveButton(
        label: l10n.bookingsRemoveFromList,
        icon: Icons.delete_outline,
        onPressed: onRemove,
        disabledReason: onRemove == null ? unavailable : null,
      ),
      LesseeBookingStatus.outForDelivery ||
      LesseeBookingStatus.completed => booking.rating == null
          ? AppSecondaryButton(
              label: l10n.bookingsDetailRateRental,
              onPressed: onRate,
              disabledReason: onRate == null ? unavailable : null,
            )
          : null,
    };
  }

  Widget _thumb(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.button),
        border: Border.all(color: colors.border),
      ),
      child: SizedBox(
        width: AppDimensions.skeletonThumb,
        height: AppDimensions.skeletonThumb,
        child: Center(
          child: Text(
            booking.mark ?? booking.reference,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }

  String _dates(AppLocalizations l10n) {
    if (booking.status == LesseeBookingStatus.cancelled) {
      return l10n.bookingsCancelledOn(rentalDateShort(booking.from));
    }
    if (booking.tab == LesseeBookingTab.completed) {
      return '${rentalDateShort(booking.from)} → ${rentalDateShort(booking.to)}';
    }
    return '${rentalDateTimeShort(booking.from)} → ${rentalDateTimeShort(booking.to)}';
  }

  String _statusLabel(AppLocalizations l10n) {
    return switch (booking.status) {
      LesseeBookingStatus.actionNeeded => l10n.bookingsActionNeeded,
      LesseeBookingStatus.inUse => l10n.bookingsInUse,
      LesseeBookingStatus.outForDelivery => l10n.bookingsOutForDelivery,
      LesseeBookingStatus.completed => l10n.bookingsCompleted,
      LesseeBookingStatus.cancelled => l10n.bookingsCancelled,
    };
  }

  StatusTone _statusTone() {
    return switch (booking.status) {
      LesseeBookingStatus.actionNeeded => StatusTone.warning,
      LesseeBookingStatus.inUse => StatusTone.info,
      LesseeBookingStatus.outForDelivery => StatusTone.info,
      LesseeBookingStatus.completed => StatusTone.success,
      LesseeBookingStatus.cancelled => StatusTone.muted,
    };
  }

  IconData? _statusIcon() {
    return switch (booking.status) {
      LesseeBookingStatus.actionNeeded => Icons.warning_amber_rounded,
      LesseeBookingStatus.cancelled => Icons.close,
      LesseeBookingStatus.inUse ||
      LesseeBookingStatus.outForDelivery ||
      LesseeBookingStatus.completed => Icons.circle,
    };
  }
}
