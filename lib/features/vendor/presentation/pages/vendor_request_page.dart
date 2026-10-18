import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/vendor/domain/vendor_audit_kind.dart';
import 'package:gcc_app/features/vendor/domain/vendor_booking_request.dart';
import 'package:gcc_app/features/vendor/domain/vendor_request_audit.dart';
import 'package:gcc_app/features/vendor/domain/vendor_request_stage.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/request_deposit_strip.dart';

class VendorRequestPage extends StatelessWidget {
  const VendorRequestPage({
    required this.request,
    required this.onViewSms,
    required this.onReject,
    required this.onAccept,
    super.key,
  });

  final VendorBookingRequest request;
  final VoidCallback onViewSms;
  final VoidCallback onReject;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final stage = request.stage;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              if (stage == VendorRequestStage.active) ...[
                _channel(context),
                const SizedBox(height: AppSpacing.sm),
                _asset(context),
                const SizedBox(height: AppSpacing.sm),
                _lessee(context),
                const SizedBox(height: AppSpacing.sm),
                _terms(context),
                const SizedBox(height: AppSpacing.sm),
                _earning(context),
                const SizedBox(height: AppSpacing.sm),
                RequestDepositStrip(
                  message: l10n.requestHoldDeposit(request.deposit),
                ),
                const SizedBox(height: AppSpacing.sm),
                _expiry(context),
              ] else if (stage == VendorRequestStage.accepted) ...[
                _accepted(context),
              ] else
                _declined(context),
            ],
          ),
        ),
        if (stage == VendorRequestStage.active)
          _actions(context)
        else if (stage == VendorRequestStage.accepted)
          _acceptedActions(context),
      ],
    );
  }

  Widget _channel(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.infoContainer,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.requestReceivedSms,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: colors.info, fontWeight: FontWeight.w600),
            ),
            Text(
              request.receivedAt,
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.bodySmall!
                    .copyWith(color: colors.info),
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              l10n.requestSmsParity,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.info),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton(
                onPressed: onViewSms,
                child: Text(l10n.requestViewSms),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _asset(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.ink900,
            borderRadius: BorderRadius.circular(AppRadii.input),
          ),
          child: SizedBox(
            width: AppDimensions.skeletonThumb,
            height: AppDimensions.skeletonThumb,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ColoredBox(
                color: AppColors.ink950.withValues(alpha: 0.9),
                child: SizedBox(
                  width: AppDimensions.skeletonThumb,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.xxs,
                    ),
                    child: Text(
                      '${request.mark}\n${request.fuel}',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.mono(
                        Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: colors.heldFunds,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                request.assetName,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                '${request.assetReference} · ${request.reference}',
                style: AppTextStyles.mono(
                  Theme.of(context).textTheme.bodySmall!
                      .copyWith(color: scheme.onSurfaceVariant),
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.successContainer,
                  borderRadius: BorderRadius.circular(AppRadii.input),
                  border: Border.all(
                    color: colors.success.withValues(alpha: 0.3),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: AppSpacing.xxs,
                  ),
                  child: Text(
                    context.l10n.requestReadyInYard,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _lessee(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: scheme.surfaceContainerHighest,
          child: Text(
            request.lesseeInitials,
            style: AppTextStyles.mono(Theme.of(context).textTheme.labelLarge!),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                request.lessee,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                request.phone,
                style: AppTextStyles.mono(
                  Theme.of(context).textTheme.bodySmall!
                      .copyWith(color: scheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _terms(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        _term(context, l10n.requestDates, request.dates, null),
        _term(context, l10n.requestDuration, request.duration, null),
        _term(
          context,
          l10n.requestRentalFee,
          request.rentalFee,
          request.rentalDetail,
        ),
        _term(
          context,
          l10n.requestDelivery,
          request.deliveryFee,
          request.deliveryDetail,
        ),
      ],
    );
  }

  Widget _term(
    BuildContext context,
    String label,
    String value,
    String? detail,
  ) {
    final scheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: AppDimensions.minTouchTarget,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodyMedium),
                if (detail != null)
                  Text(
                    detail,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _earning(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.requestYoullReceive,
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              l10n.requestNetEarning,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              request.netEarning,
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.headlineSmall!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              request.reference,
              style: AppTextStyles.mono(Theme.of(context).textTheme.bodySmall!),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              l10n.requestEarningNote,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _expiry(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.requestExpiresIn,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.warningContainer,
                    borderRadius: BorderRadius.circular(AppRadii.input),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                      vertical: AppSpacing.xxs,
                    ),
                    child: Text(
                      l10n.requestUrgent,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colors.warning,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              l10n.requestAutoReassigns,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              request.expiresIn,
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.headlineSmall!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadii.pill),
              child: LinearProgressIndicator(
                value: request.expiryProgress,
                minHeight: AppDimensions.sheetHandleHeight,
                color: colors.warning,
                backgroundColor: colors.warningContainer,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.requestExpiresDetail,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _actions(BuildContext context) {
    final l10n = context.l10n;
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Expanded(
              child: AppSecondaryButton(
                label: l10n.requestReject,
                expand: false,
                onPressed: onReject,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppPrimaryButton(
                label: l10n.requestAccept,
                expand: false,
                onPressed: onAccept,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _accepted(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final when = request.acceptedAt;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.infoContainer,
            borderRadius: BorderRadius.circular(AppRadii.card),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Text(
              request.acceptedBySms
                  ? l10n.requestAcceptedSmsBody
                  : l10n.requestCollectionConfirmed(request.collectionWindow),
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: colors.info),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.successContainer,
            borderRadius: BorderRadius.circular(AppRadii.card),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.acceptedBySms
                      ? l10n.requestAcceptedSms
                      : l10n.requestAccepted,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: colors.success,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (when != null)
                  Text(
                    l10n.requestAcceptedAt(when),
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: colors.success),
                  ),
                Text(
                  l10n.requestCollectionConfirmed(request.collectionWindow),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        if (request.acceptedBySms && request.audit.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.requestAuditTitle,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: AppSpacing.xs),
          for (final step in request.audit) _audit(context, step),
        ],
        const SizedBox(height: AppSpacing.md),
        _summaryLine(context, l10n.requestEquipment, request.assetName),
        _summaryLine(context, l10n.requestNetPayout, request.netEarning),
        const SizedBox(height: AppSpacing.xs),
        RequestDepositStrip(
          message: '${l10n.requestHeldDeposit} ${request.deposit}',
        ),
        if (request.acceptedBySms) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.requestSmsReverse,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ],
    );
  }

  Widget _audit(BuildContext context, VendorRequestAudit step) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final title = switch (step.kind) {
      VendorAuditKind.received => l10n.requestAuditReceived,
      VendorAuditKind.accepted => l10n.requestAuditAcceptedSms,
      VendorAuditKind.collection => l10n.requestAuditCollection,
    };
    final channel = switch (step.kind) {
      VendorAuditKind.received => l10n.requestAuditBySms,
      VendorAuditKind.accepted => l10n.requestAuditReply,
      VendorAuditKind.collection => l10n.requestAuditPending,
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            step.done ? Icons.circle : Icons.circle_outlined,
            size: AppDimensions.iconSm,
            color: step.done ? colors.success : colors.muted,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.at,
                  style: AppTextStyles.mono(
                    Theme.of(context).textTheme.bodySmall!,
                  ),
                ),
                Text(channel, style: Theme.of(context).textTheme.labelSmall),
                Text(title, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryLine(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.bodyMedium!,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _acceptedActions(BuildContext context) {
    final l10n = context.l10n;
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppPrimaryButton(
              label: l10n.requestRecordCondition,
              disabledReason: l10n.dashboardActionUnavailable,
            ),
            TextButton(
              onPressed: onReject,
              child: Text(l10n.requestDeclineAnyway),
            ),
          ],
        ),
      ),
    );
  }

  Widget _declined(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.requestDeclinedTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(l10n.requestDeclineNotice),
        if (request.declineNote != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(request.declineNote!),
        ],
      ],
    );
  }
}
