import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_withdraw_amount_field.dart';
import 'package:gcc_app/features/vendor/domain/naira_amount.dart';
import 'package:gcc_app/features/vendor/domain/vendor_withdrawal_gap.dart';
import 'package:gcc_app/features/vendor/domain/vendor_withdrawal_receipt.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_withdraw_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_withdraw_state.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/withdraw_receipt_card.dart';

/// Withdraw form matching MOB-LSE-14 frame 2.
class LesseeWithdrawPage extends StatelessWidget {
  const LesseeWithdrawPage({
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
    final valid = gap == null && amount != null;
    return Column(
      children: [
        Expanded(
          child: ListView(
            key: const Key('lessee-withdraw-form'),
            primary: false,
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              _account(context),
              const SizedBox(height: AppSpacing.md),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(AppRadii.card),
                  border: Border.all(color: colors.border),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.lesseeWithdrawAvailableLabel,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                          ),
                          Text(
                            wallet.available,
                            style: AppTextStyles.tabular(
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        l10n.vendorWithdrawAmount.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: scheme.onSurfaceVariant,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      LesseeWithdrawAmountField(
                        value: state.amountText,
                        generation: state.revision,
                        error: gap != null && state.amountText.isNotEmpty,
                        emphasized: valid,
                        currencyBadge: l10n.lesseeWithdrawCurrencyBadge,
                        onChanged: cubit.amountChanged,
                      ),
                      if (gap != null && state.amountText.isNotEmpty) ...[
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
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          for (final preset in const [
                            100000,
                            250000,
                            400000,
                          ]) ...[
                            Expanded(
                              child: _chip(
                                context,
                                compactNaira(preset),
                                amount == preset,
                                () => cubit.choose(preset),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
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
                      const SizedBox(height: AppSpacing.sm),
                      Divider(height: 1, color: colors.border),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.lesseeWithdrawFeeLabel,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: scheme.onSurfaceVariant),
                            ),
                          ),
                          Text(
                            l10n.vendorWithdrawFree.toUpperCase(),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: colors.success,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.lesseeWithdrawNetLabel,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            amount == null ? '—' : fullNaira(amount),
                            style: AppTextStyles.tabular(
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: scheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        l10n.lesseeWithdrawArrives(wallet.bank),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.heldFundsContainer,
                  borderRadius: BorderRadius.circular(AppRadii.card),
                  border: Border.all(
                    color: colors.heldFunds.withValues(alpha: 0.45),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadii.card),
                  child: CustomPaint(
                    painter: _WithdrawHatchPainter(colors.heldFunds),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lock,
                                size: AppDimensions.iconSm,
                                color: colors.heldFunds,
                              ),
                              const SizedBox(width: AppSpacing.xxs),
                              Expanded(
                                child: Text(
                                  l10n.lesseeWithdrawEscrowGuard,
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: colors.heldFunds,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.4,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text.rich(
                            TextSpan(
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: colors.heldFunds),
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(
                                    Icons.lock,
                                    size: AppDimensions.iconSm,
                                    color: colors.heldFunds,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${wallet.held} ',
                                  style: AppTextStyles.tabular(
                                    Theme.of(context).textTheme.bodySmall!
                                        .copyWith(
                                          color: colors.heldFunds,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                                TextSpan(text: l10n.lesseeWithdrawAuditAnd),
                                const TextSpan(text: ' '),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(
                                    Icons.lock,
                                    size: AppDimensions.iconSm,
                                    color: colors.heldFunds,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${wallet.awaiting} ',
                                  style: AppTextStyles.tabular(
                                    Theme.of(context).textTheme.bodySmall!
                                        .copyWith(
                                          color: colors.heldFunds,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                                TextSpan(text: l10n.lesseeWithdrawQuarantine),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            l10n.lesseeWithdrawAvailableUnlocked(
                              wallet.available,
                            ),
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: colors.heldFunds,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surface,
            border: Border(top: BorderSide(color: colors.border)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppPrimaryButton(
                    label: valid
                        ? l10n.vendorWithdrawSubmit(fullNaira(amount))
                        : l10n.vendorWithdrawAction,
                    icon: Icons.arrow_forward,
                    onPressed: valid ? () => cubit.submit() : null,
                  ),
                  TextButton(
                    onPressed: onCancel,
                    child: Text(
                      l10n.lesseeWithdrawCancel,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _account(BuildContext context) {
    final l10n = context.l10n;
    final wallet = state.wallet;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.lesseeWithdrawDestination.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(AppRadii.button),
                    border: Border.all(
                      color: scheme.primary.withValues(alpha: 0.25),
                    ),
                  ),
                  child: SizedBox.square(
                    dimension: AppSpacing.xxxl,
                    child: Center(
                      child: Text(
                        l10n.lesseeWithdrawBankInitials,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: scheme.primary,
                          fontWeight: FontWeight.w700,
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
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: AppSpacing.xs,
                        children: [
                          Text(
                            l10n.lesseeWithdrawBankName,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '✓ ${l10n.vendorWithdrawVerified}',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: colors.success,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      Text(
                        l10n.lesseeWithdrawAccountLine(
                          wallet.accountNumber,
                          wallet.accountName,
                        ),
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Tooltip(
                  message: l10n.dashboardActionUnavailable,
                  child: TextButton(
                    onPressed: null,
                    style: TextButton.styleFrom(
                      disabledForegroundColor: scheme.primary,
                    ),
                    child: Text(
                      l10n.vendorWithdrawChange,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
      color: selected ? scheme.secondaryContainer : scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.button),
        side: BorderSide(
          color: selected ? scheme.primary : context.semanticColors.border,
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
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: selected ? scheme.primary : scheme.onSurface,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
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
      key: const Key('lessee-withdraw-receipt'),
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
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          l10n.vendorWithdrawArrives(receipt.bank),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
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
            l10n.lesseeWithdrawLedgerUpdated,
          ],
          remainingLabel: l10n.vendorWithdrawRemaining,
          math: '${fullNaira(receipt.previous)} − ${fullNaira(receipt.amount)}',
          remaining: fullNaira(receipt.remaining),
        ),
        const SizedBox(height: AppSpacing.md),
        AppPrimaryButton(
          label: l10n.vendorWithdrawBack,
          onPressed: onDone,
        ),
      ],
    );
  }
}

class _WithdrawHatchPainter extends CustomPainter {
  _WithdrawHatchPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.08)
      ..strokeWidth = AppDimensions.borderWidth * 4;
    const gap = 12.0;
    for (var x = -size.height; x < size.width; x += gap) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_WithdrawHatchPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
