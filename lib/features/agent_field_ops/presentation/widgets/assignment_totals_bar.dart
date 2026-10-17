import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_segment_option.dart';
import 'package:gcc_app/core/widgets/app_segmented_control.dart';

/// The all-assignment figures: total stops, captured stops, markets covered.
///
/// Read-only rather than selectable — they are totals, not filters. The
/// segmented track is used only because it is the shape the design gives them.
class AssignmentTotalsBar extends StatelessWidget {
  const AssignmentTotalsBar({
    required this.total,
    required this.captured,
    required this.marketCount,
    super.key,
  });

  final int total;
  final int captured;
  final int marketCount;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.xs,
        AppSpacing.md,
        0,
      ),
      child: AppSegmentedControl<int>(
        options: [
          AppSegmentOption(
            value: total,
            label: '${l10n.shopsFilterTotal} $total',
          ),
          AppSegmentOption(
            value: captured,
            label: '${l10n.shopsSummaryCaptured} $captured',
          ),
          AppSegmentOption(
            value: marketCount,
            label: '${l10n.shopsFilterMarkets} $marketCount',
          ),
        ],
        selected: total,
        onChanged: (_) {},
      ),
    );
  }
}
