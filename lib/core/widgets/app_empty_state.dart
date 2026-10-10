import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final action = actionLabel;
    final messageText = message;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: AppDimensions.emptyStateIcon, color: scheme.outline),
        const SizedBox(height: AppSpacing.md),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        if (messageText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            messageText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
        if (action != null) ...[
          const SizedBox(height: AppSpacing.xl),
          AppSecondaryButton(label: action, onPressed: onAction, expand: false),
        ],
      ],
    );
  }
}
