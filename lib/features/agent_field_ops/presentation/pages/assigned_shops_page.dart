import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/route_summary.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/pages/assigned_shop_scope.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/assigned_shop_row.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/empty_route_panel.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/next_stop_bar.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/route_summary_strip.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/shop_scope_bar.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/shop_scope_filter_bar.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/sort_notice_bar.dart';

/// The agent's work list.
///
/// Four frames, matching the design: today's route, the whole assignment with
/// filters, the same list sorted by distance, and the completed route (see
/// [RouteCompleteFrame]).
///
/// The design is explicit that this screen carries **no money**: no bounty
/// figures and no lock glyphs. It is a work list, and the wallet is a
/// different screen.
class AssignedShopsPage extends StatelessWidget {
  const AssignedShopsPage({
    required this.summary,
    required this.shops,
    this.scope = AssignedShopScope.today,
    this.sortedByDistance = false,
    this.attentionCount = 0,
    this.marketFilter,
    this.statusFilter,
    this.nextStopDistance,
    this.onShopTap,
    this.onNextStop,
    super.key,
  });
  final RouteSummary summary;
  final List<AssignedShop> shops;

  /// Which slice of the assignment is showing.
  final AssignedShopScope scope;

  /// Whether the list is sorted nearest-first.
  final bool sortedByDistance;

  /// How many shops need attention, for the filter shortcut.
  final int attentionCount;
  final String? marketFilter;
  final String? statusFilter;

  /// e.g. `120 m`, used on the sticky next-stop footer. Null hides the footer.
  final String? nextStopDistance;
  final ValueChanged<AssignedShop>? onShopTap;
  final VoidCallback? onNextStop;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final allScope = scope == AssignedShopScope.all;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.shopsTitle),
        backgroundColor: scheme.surface,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ShopScopeBar(
              todayLabel: l10n.shopsScopeToday,
              allLabel: l10n.shopsScopeAll,
              selected: scope == AssignedShopScope.today,
              onChanged: (_) {},
            ),
            if (allScope) ...[
              const SizedBox(height: AppSpacing.xxs),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.tight,
                ),
                child: ShopScopeFilterBar(
                  attentionCount: attentionCount,
                  marketFilter: marketFilter ?? l10n.shopsFilterAllMarkets,
                  statusFilter: statusFilter ?? l10n.shopsFilterAllStatus,
                ),
              ),
            ] else ...[
              const SizedBox(height: AppSpacing.xxs),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: RouteSummaryStrip(summary: summary),
              ),
            ],
            if (sortedByDistance) ...[
              const SizedBox(height: AppSpacing.xs),
              const SortNoticeBar(),
            ] else
              const SizedBox(height: AppSpacing.xs),
            Expanded(
              child: shops.isEmpty
                  ? const Center(child: EmptyRoutePanel())
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      itemCount: shops.length,
                      separatorBuilder: (_, _) =>
                          Divider(height: 1, color: colors.border),
                      itemBuilder: (context, index) {
                        final shop = shops[index];
                        return AssignedShopRow(
                          shop: shop,
                          onTap: onShopTap == null
                              ? null
                              : () => onShopTap!(shop),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: nextStopDistance == null
          ? null
          : NextStopBar(
              label: l10n.shopsStartNextStop(nextStopDistance!),
              onTap: onNextStop,
            ),
    );
  }
}
