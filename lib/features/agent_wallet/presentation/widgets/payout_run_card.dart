import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run_state.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/payout_run_pill.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/payout_run_shop_row.dart';

/// One payout run: how much it paid, or what it is still collecting.
///
/// An open run states what it is *expected* to pay, and says plainly that the
/// figure depends on verification — an expectation is not money in hand, so it
/// carries no lock.
class PayoutRunCard extends StatelessWidget {
  const PayoutRunCard({required this.run, super.key});

  final PayoutRun run;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final open = run.state == PayoutRunState.open;
    final closingNote = run.closingNote;
    final expectedNote = run.expectedNote;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    run.reference,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                PayoutRunPill(open: open),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              run.subtitle,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
            if (open) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${run.shopCount}',
                style: AppTextStyles.tabular(
                  Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ] else
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xs),
                child: Text(
                  run.total,
                  style: AppTextStyles.tabular(
                    Theme.of(context).textTheme.headlineSmall!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            if (expectedNote != null) ...[
              const SizedBox(height: 2),
              Text(
                expectedNote,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ],
            if (closingNote != null) ...[
              const SizedBox(height: AppSpacing.xxs),
              Text(
                closingNote,
                style: AppTextStyles.mono(
                  Theme.of(context).textTheme.labelSmall!
                      .copyWith(color: scheme.onSurfaceVariant),
                ),
              ),
            ],
            if (run.shops.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              for (final shop in run.shops) PayoutRunShopRow(shop: shop),
            ],
          ],
        ),
      ),
    );
  }
}
