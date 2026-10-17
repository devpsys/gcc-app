import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/route_summary.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/route_complete_panel.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/route_summary_strip.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/shop_scope_bar.dart';

/// The completed-route frame: every stop captured, route walked.
///
/// Deliberately states what is still uploading rather than implying the day's
/// work is fully banked — a pending upload is not yet an uploaded submission.
class RouteCompleteFrame extends StatelessWidget {
  const RouteCompleteFrame({
    required this.summary,
    required this.stopCount,
    required this.uploadedCount,
    required this.pendingCount,
    required this.elapsed,
    super.key,
  });

  final RouteSummary summary;

  /// Stops on the finished route.
  final int stopCount;

  /// How many have finished uploading.
  final int uploadedCount;

  /// How many are still only on the device.
  final int pendingCount;

  /// e.g. `3 h 20 m`.
  final String elapsed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.shopsTitle),
        backgroundColor: scheme.surface,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            ShopScopeBar(
              todayLabel: l10n.shopsScopeToday,
              allLabel: l10n.shopsScopeAll,
              selected: true,
              onChanged: (_) {},
            ),
            const SizedBox(height: AppSpacing.xs),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              child: RouteSummaryStrip(summary: summary),
            ),
            const SizedBox(height: AppSpacing.xxl),
            RouteCompletePanel(
              stopCount: stopCount,
              uploadedCount: uploadedCount,
              pendingCount: pendingCount,
              routeDistance: summary.routeDistance,
              elapsed: elapsed,
              loadNextLabel: l10n.shopsLoadNextRoute,
              viewSubmissionsLabel: l10n.shopsViewSubmissions,
            ),
          ],
        ),
      ),
    );
  }
}
