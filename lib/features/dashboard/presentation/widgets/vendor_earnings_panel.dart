import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/held_funds_indicator.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_text_link.dart';

class VendorEarningsPanel extends StatelessWidget {
  const VendorEarningsPanel({
    required this.earnings,
    required this.availableLabel,
    required this.awaitingLabel,
    required this.depositsLabel,
    required this.withdrawLabel,
    required this.walletLabel,
    required this.emptyLabel,
    required this.disabledReason,
    this.note,
    super.key,
  });

  final DashboardEarnings? earnings;
  final String availableLabel;
  final String awaitingLabel;
  final String depositsLabel;
  final String withdrawLabel;
  final String walletLabel;
  final String emptyLabel;
  final String disabledReason;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final current = earnings;
    final contextNote = note;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.l10n.dashboardEarnings,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            if (current == null)
              Text(emptyLabel)
            else ...[
              _available(context, current.available),
              const SizedBox(height: AppSpacing.xs),
              _held(context, awaitingLabel, current.awaitingCheck),
              const SizedBox(height: AppSpacing.xs),
              _held(context, depositsLabel, current.cautionDeposits),
              if (contextNote != null && contextNote.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  contextNote,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.sm),
              AppPrimaryButton(
                label: withdrawLabel,
                onPressed: null,
                disabledReason: disabledReason,
              ),
              DashboardTextLink(
                label: walletLabel,
                disabledReason: disabledReason,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _available(BuildContext context, String amount) {
    final style = Theme.of(context).textTheme.bodyMedium;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: AppDimensions.topBarHeight),
      child: Row(
        children: [
          Expanded(child: Text(availableLabel)),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              amount,
              textAlign: TextAlign.end,
              style: style == null ? null : AppTextStyles.tabular(style),
            ),
          ),
        ],
      ),
    );
  }

  Widget _held(BuildContext context, String label, String amount) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: AppDimensions.topBarHeight),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: HeldFundsIndicator(
              label: label,
              amount: amount,
              compact: true,
            ),
          ),
        ],
      ),
    );
  }
}
