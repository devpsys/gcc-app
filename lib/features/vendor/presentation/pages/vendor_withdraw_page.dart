import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/vendor/domain/naira_amount.dart';
import 'package:gcc_app/features/vendor/domain/vendor_withdrawal_gap.dart';
import 'package:gcc_app/features/vendor/domain/vendor_withdrawal_receipt.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_withdraw_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_withdraw_state.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/withdraw_amount_field.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/withdraw_quote_card.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/withdraw_receipt_card.dart';

class VendorWithdrawPage extends StatelessWidget {
  const VendorWithdrawPage({
    required this.state,
    required this.onCancel,
    required this.onDone,
    super.key,
  });

  final VendorWithdrawReady state;
  final VoidCallback onCancel;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final receipt = state.receipt;
    if (receipt != null) {
      return _receipt(context, receipt);
    }
    return _form(context);
  }

  Widget _form(BuildContext context) {
    final cubit = context.read<VendorWithdrawCubit>();
    final l10n = context.l10n;
    final wallet = state.wallet;
    final gap = state.gap;
    final amount = state.amount;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return ListView(
      key: const Key('vendor-withdraw-form'),
      primary: false,
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        if (gap == VendorWithdrawalGap.empty)
          Text(
            l10n.vendorWithdrawEnterAmount,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: scheme.error, fontWeight: FontWeight.w700),
          ),
        _account(context),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.vendorWithdrawHowMuch,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  l10n.vendorWithdrawAvailableOf(wallet.available),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        WithdrawAmountField(
          value: state.amountText,
          generation: state.revision,
          error: gap != null,
          onChanged: cubit.amountChanged,
        ),
        if (gap != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            l10n.vendorWithdrawRange(
              fullNaira(minimumWithdrawal),
              wallet.available,
            ),
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            for (final preset in const [100000, 250000, 400000]) ...[
              Expanded(
                child: _chip(
                  context,
                  compactNaira(preset),
                  amount == preset,
                  () => cubit.choose(preset),
                ),
              ),
              const SizedBox(width: AppSpacing.xxs),
            ],
            Expanded(
              child: _chip(
                context,
                l10n.vendorWithdrawAll,
                amount == wallet.availableAmount,
                () => cubit.choose(wallet.availableAmount),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (gap == null && amount != null)
          WithdrawQuoteCard(
            amountLabel: l10n.vendorWithdrawAmount,
            amount: fullNaira(amount),
            feeLabel: l10n.vendorWithdrawFee,
            freeLabel: l10n.vendorWithdrawFree,
            netLabel: l10n.vendorWithdrawNet,
            arrivesTitle: l10n.vendorWithdrawArrives(wallet.bank),
            arrivesBody: l10n.vendorWithdrawArrivesBody,
          )
        else
          Text(
            l10n.vendorWithdrawNeedAmount,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        if (gap == null) ...[
          const SizedBox(height: AppSpacing.md),
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.heldFundsContainer,
              borderRadius: BorderRadius.circular(AppRadii.card),
              border: Border.all(
                color: colors.heldFunds.withValues(alpha: 0.3),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.vendorWithdrawOnly,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.heldFunds,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: AppSpacing.xxs,
                    children: [
                      Icon(
                        Icons.lock,
                        size: AppDimensions.iconSm,
                        color: colors.heldFunds,
                      ),
                      Text(
                        wallet.awaiting,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.heldFunds,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        l10n.vendorWithdrawAuditAnd,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: colors.heldFunds),
                      ),
                      Icon(
                        Icons.lock,
                        size: AppDimensions.iconSm,
                        color: colors.heldFunds,
                      ),
                      Text(
                        wallet.held,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.heldFunds,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        l10n.vendorWithdrawQuarantine,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: colors.heldFunds),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.vendorWithdrawHeldStay,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: AppSecondaryButton(
                label: l10n.vendorWithdrawCancel,
                onPressed: onCancel,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppPrimaryButton(
                label: gap == null && amount != null
                    ? l10n.vendorWithdrawSubmit(fullNaira(amount))
                    : l10n.vendorWithdrawAction,
                onPressed: gap == null ? () => cubit.submit() : null,
              ),
            ),
          ],
        ),
        if (gap != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            l10n.vendorWithdrawContinue,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall
                ?.copyWith(color: scheme.error),
          ),
        ],
      ],
    );
  }

  Widget _account(BuildContext context) {
    final l10n = context.l10n;
    final wallet = state.wallet;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_balance, color: scheme.primary),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wallet.bank.split('•').first.trim(),
                    style: Theme.of(context).textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    l10n.vendorWithdrawVerified,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.success,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Tooltip(
                message: l10n.dashboardActionUnavailable,
                child: TextButton(
                  onPressed: null,
                  child: FittedBox(child: Text(l10n.vendorWithdrawChange)),
                ),
              ),
            ),
          ],
        ),
        Text(
          wallet.accountNumber,
          style: AppTextStyles.mono(Theme.of(context).textTheme.titleMedium!),
        ),
        Text(
          l10n.vendorWithdrawAccountNote,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _chip(
    BuildContext context,
    String label,
    bool selected,
    VoidCallback onTap,
  ) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: selected ? scheme.secondaryContainer : scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.button),
        side: BorderSide(
          color: selected ? scheme.primary : scheme.outline,
          width: selected
              ? AppDimensions.emphasisBorderWidth
              : AppDimensions.borderWidth,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.button),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppDimensions.minTouchTarget,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: selected ? scheme.primary : scheme.onSurface,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _receipt(BuildContext context, VendorWithdrawalReceipt receipt) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return ListView(
      key: const Key('vendor-withdraw-receipt'),
      primary: false,
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Icon(
          Icons.check_circle,
          size: AppDimensions.noticeIcon,
          color: colors.success,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.vendorWithdrawOnTheWay(fullNaira(receipt.amount)),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        Text(
          l10n.vendorWithdrawArrives(receipt.bank),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.md),
        WithdrawReceiptCard(
          receipt: receipt,
          referenceLabel: l10n.vendorWithdrawReference,
          debitedLabel: l10n.vendorWithdrawDebited,
          dispatchedLabel: l10n.vendorWithdrawDispatched,
          arrivalLabel: l10n.vendorWithdrawEstimated,
          amount: fullNaira(receipt.amount),
          checks: [
            l10n.vendorWithdrawAccountMatches(receipt.accountName),
            l10n.vendorWithdrawChannelClear(
              receipt.bank.split('•').first.trim(),
            ),
            l10n.vendorWithdrawLedgerUpdated,
          ],
          remainingLabel: l10n.vendorWithdrawRemaining,
          math: '${fullNaira(receipt.previous)} − ${fullNaira(receipt.amount)}',
          remaining: fullNaira(receipt.remaining),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.vendorWithdrawSms,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.md),
        AppPrimaryButton(
          label: l10n.vendorWithdrawTrack,
          onPressed: null,
          disabledReason: l10n.dashboardActionUnavailable,
        ),
        const SizedBox(height: AppSpacing.xs),
        AppSecondaryButton(label: l10n.vendorWithdrawBack, onPressed: onDone),
      ],
    );
  }
}
