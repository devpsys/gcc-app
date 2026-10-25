import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';

class OrderSummaryRow extends StatelessWidget {
  const OrderSummaryRow({
    required this.order,
    required this.disabledReason,
    this.onOpen,
    super.key,
  });

  final DashboardOrder order;
  final String disabledReason;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final amount = Theme.of(context).textTheme.bodySmall
        ?.copyWith(fontWeight: FontWeight.w600);
    final reference = AppTextStyles.mono(
      Theme.of(context).textTheme.labelSmall!
          .copyWith(color: scheme.onSurfaceVariant, letterSpacing: 0),
    );
    return Tooltip(
      message: onOpen == null ? disabledReason : '',
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: order.reference, style: reference),
                        TextSpan(
                          text: '  ${order.title}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    order.status,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: order.complete ? colors.success : colors.info,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Text(
                order.amount,
                textAlign: TextAlign.end,
                style: amount == null ? null : AppTextStyles.tabular(amount),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
