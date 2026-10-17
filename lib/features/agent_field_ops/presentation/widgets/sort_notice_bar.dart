import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The "Sorted by distance" notice with its own way out.
///
/// The sort is a choice the agent made, so it offers an explicit undo rather
/// than making them hunt for a control.
class SortNoticeBar extends StatelessWidget {
  const SortNoticeBar({this.onClear, super.key});

  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.xs,
      ),
      child: Row(
        children: [
          Icon(
            Icons.near_me_outlined,
            size: AppSpacing.lg,
            color: scheme.onSurfaceVariant,
          ),
          const SizedBox(width: AppSpacing.tight),
          Expanded(
            child: Text(
              l10n.shopsSortedByDistance,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
          TextButton(
            onPressed: onClear,
            style: TextButton.styleFrom(foregroundColor: scheme.primary),
            child: Text(
              l10n.shopsClearSort,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: scheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
