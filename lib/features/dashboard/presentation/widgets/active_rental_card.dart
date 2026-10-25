import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_button_styles.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_button_frame.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/held_funds_indicator.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_text_link.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_thumb.dart';

class ActiveRentalCard extends StatelessWidget {
  const ActiveRentalCard({
    required this.rental,
    required this.onDisabled,
    this.place,
    this.lastRental,
    this.onBrowse,
    this.onReviewReturn,
    this.onMessageVendor,
    this.onViewWallet,
    this.onRate,
    super.key,
  });

  final DashboardRental? rental;
  final String onDisabled;
  final String? place;
  final String? lastRental;
  final VoidCallback? onBrowse;
  final VoidCallback? onReviewReturn;
  final VoidCallback? onMessageVendor;
  final VoidCallback? onViewWallet;
  final VoidCallback? onRate;

  @override
  Widget build(BuildContext context) {
    final current = rental;
    if (current == null) {
      return _empty(context);
    }
    return _frame(
      context,
      child: current.released
          ? _released(context, current)
          : _active(context, current),
    );
  }

  Widget _empty(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final knownPlace = place;
    final previous = lastRental;
    return _frame(
      context,
      color: scheme.surfaceContainerLow,
      accent: false,
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surface,
              shape: BoxShape.circle,
              border: Border.all(color: context.semanticColors.border),
            ),
            child: SizedBox.square(
              dimension: AppDimensions.noticeIcon,
              child: Icon(
                Icons.event_busy,
                color: scheme.outline,
                size: AppDimensions.iconLg,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.dashboardNoActiveBookings,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            knownPlace == null
                ? l10n.dashboardNoActiveBookingsBody
                : l10n.dashboardNoActiveBookingsPlace(knownPlace),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.md),
          AppPrimaryButton(
            label: l10n.dashboardBrowseEquipment,
            onPressed: onBrowse,
            disabledReason: onBrowse == null ? onDisabled : null,
          ),
          if (previous != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.dashboardLastRental(previous),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.labelMedium!
                    .copyWith(color: scheme.outline),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _active(BuildContext context, DashboardRental current) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _heading(context, current),
        const SizedBox(height: AppSpacing.md),
        _steps(context, released: false),
        const SizedBox(height: AppSpacing.sm),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: colors.border)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    l10n.dashboardReturnBy(current.returnBy),
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: AppDimensions.iconSm,
                  color: scheme.outline,
                ),
                if (current.remaining.isNotEmpty)
                  Flexible(
                    child: Text(
                      current.remaining,
                      textAlign: TextAlign.end,
                      style: AppTextStyles.mono(
                        Theme.of(context).textTheme.labelMedium!
                            .copyWith(color: scheme.outline),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        HeldFundsIndicator(
          label: l10n.dashboardDepositLabel,
          amount: current.depositAmount,
          caption: l10n.dashboardEscrow,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButtonFrame(
          disabledReason: onReviewReturn == null ? onDisabled : null,
          button: OutlinedButton(
            onPressed: onReviewReturn,
            style: AppButtonStyles.secondary(scheme).copyWith(
              foregroundColor: WidgetStatePropertyAll(colors.heldFunds),
              side: WidgetStatePropertyAll(
                BorderSide(
                  color: colors.heldFunds,
                  width: AppDimensions.emphasisBorderWidth,
                ),
              ),
            ),
            child: Text(l10n.dashboardReviewReturn),
          ),
        ),
        DashboardTextLink(
          label: l10n.dashboardMessageVendor,
          onPressed: onMessageVendor,
          disabledReason: onDisabled,
          chevron: true,
        ),
      ],
    );
  }

  Widget _released(BuildContext context, DashboardRental current) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _heading(context, current),
        const SizedBox(height: AppSpacing.md),
        _steps(context, released: true),
        const SizedBox(height: AppSpacing.sm),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.successContainer,
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(color: colors.success.withValues(alpha: 0.3)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check,
                      size: AppDimensions.iconSm,
                      color: colors.success,
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    Expanded(
                      child: Text(
                        l10n.dashboardDepositReleased,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    DashboardTextLink(
                      label: l10n.dashboardViewWallet,
                      onPressed: onViewWallet,
                      disabledReason: onDisabled,
                      chevron: true,
                      color: colors.success,
                      underline: true,
                    ),
                  ],
                ),
                Text(l10n.dashboardDepositReleasedBody(current.depositAmount)),
              ],
            ),
          ),
        ),
        if (current.releasedDetail.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.dashboardRefundableDeposit(current.depositAmount),
                  style: AppTextStyles.tabular(
                    Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: scheme.outline,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Flexible(
                child: Text(
                  current.releasedDetail,
                  textAlign: TextAlign.end,
                  style: AppTextStyles.mono(
                    Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: scheme.onSurfaceVariant,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        AppButtonFrame(
          disabledReason: onRate == null ? onDisabled : null,
          button: OutlinedButton(
            onPressed: onRate,
            style: AppButtonStyles.neutral(scheme).copyWith(
              minimumSize: const WidgetStatePropertyAll(
                Size(
                  AppDimensions.minTouchTarget,
                  AppDimensions.buttonHeightCompact,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    l10n.dashboardRateRental,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppSpacing.xxs),
                Icon(
                  Icons.star,
                  size: AppDimensions.iconSm,
                  color: colors.warning,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _heading(BuildContext context, DashboardRental current) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final eyebrow = current.released
        ? l10n.dashboardCompletedRental(current.reference)
        : l10n.dashboardActiveRental(current.reference);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DashboardThumb(tinted: true),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eyebrow.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: scheme.primary),
              ),
              Text(
                current.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                current.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _steps(BuildContext context, {required bool released}) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final steps = [
      (l10n.dashboardBooked, true),
      (l10n.dashboardStatusInUse, true),
      (l10n.dashboardReturned, released),
    ];
    return Row(
      children: [
        for (final step in steps)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: step.$2
                          ? scheme.primary
                          : scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppRadii.micro),
                    ),
                    child: const SizedBox(
                      height: AppDimensions.syncProgressHeight,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      step.$1.toUpperCase(),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: step.$2 ? scheme.primary : scheme.outline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _frame(
    BuildContext context, {
    required Widget child,
    Color? color,
    bool accent = true,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final border = context.semanticColors.border;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: accent
                ? Border(
                    left: BorderSide(
                      color: scheme.primary,
                      width: AppDimensions.accentBorderWidth,
                    ),
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: child,
          ),
        ),
      ),
    );
  }
}
