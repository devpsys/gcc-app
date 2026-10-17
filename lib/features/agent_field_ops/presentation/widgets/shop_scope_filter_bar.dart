import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/shop_filter_bar.dart';

/// The market / status / needs-attention filter row on the all-assignment frame.
///
/// Horizontally scrollable: an agent in the field filters with one thumb, so the
/// shortcuts stay reachable rather than wrapping onto a second line.
class ShopScopeFilterBar extends StatelessWidget {
  const ShopScopeFilterBar({
    required this.attentionCount,
    required this.marketFilter,
    required this.statusFilter,
    super.key,
  });

  /// How many shops need attention, so the shortcut can say so.
  final int attentionCount;

  /// Current market filter, or the all-markets default.
  final String marketFilter;

  /// Current status filter, or the all-status default.
  final String statusFilter;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ShopFilterChip(
            label: marketFilter,
            selected: false,
            onSelected: (_) {},
          ),
          const SizedBox(width: AppSpacing.xs),
          ShopFilterChip(
            label: statusFilter,
            selected: false,
            onSelected: (_) {},
          ),
          const SizedBox(width: AppSpacing.xs),
          ShopFilterChip(
            label: l10n.shopsFilterNeedsAttention(attentionCount),
            selected: false,
            warning: true,
            onSelected: (_) {},
          ),
        ],
      ),
    );
  }
}
