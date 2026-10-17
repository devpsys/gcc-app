import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/storage_category.dart';

/// One storage category with its optional clear action.
class StorageCategoryRow extends StatelessWidget {
  const StorageCategoryRow({required this.category, this.onClear, super.key});

  final StorageCategory category;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    // No handler means no button: an inert destructive control is a dead end.
    final clearable = category.clearable && onClear != null;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  category.label,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  category.size,
                  style: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          if (clearable)
            SizedBox(
              height: AppDimensions.minTouchTarget,
              child: TextButton(
                onPressed: onClear,
                style: TextButton.styleFrom(foregroundColor: colors.danger),
                child: Text(
                  context.l10n.profileClearAction,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.danger,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
