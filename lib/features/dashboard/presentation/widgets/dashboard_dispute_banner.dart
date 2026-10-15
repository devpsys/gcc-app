import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_text_link.dart';

class DashboardDisputeBanner extends StatelessWidget {
  const DashboardDisputeBanner({
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.disabledReason,
    super.key,
  });

  final String title;
  final String message;
  final String actionLabel;
  final String disabledReason;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: colors.dangerContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.gavel, size: AppDimensions.iconMd, color: scheme.error),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(color: scheme.error),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(message, style: Theme.of(context).textTheme.bodySmall),
                  DashboardTextLink(
                    label: actionLabel,
                    disabledReason: disabledReason,
                    chevron: true,
                    color: scheme.error,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
