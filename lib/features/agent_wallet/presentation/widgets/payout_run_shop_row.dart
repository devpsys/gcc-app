import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run_shop.dart';

/// One shop inside a payout run.
class PayoutRunShopRow extends StatelessWidget {
  const PayoutRunShopRow({required this.shop, super.key});

  final PayoutRunShop shop;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.tight),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  shop.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  shop.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.mono(
                    Theme.of(context).textTheme.labelSmall!
                        .copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            shop.amount,
            style: AppTextStyles.tabular(
              Theme.of(context).textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
