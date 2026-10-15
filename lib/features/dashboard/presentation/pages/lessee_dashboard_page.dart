import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/responsive_content.dart';
import 'package:gcc_app/core/widgets/skeleton_list_card.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_section_id.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/active_rental_card.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/category_chip_row.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_marketplace_header.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_search_bar.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_section.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_text_link.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/equipment_result_row.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/order_summary_row.dart';

class LesseeDashboardPage extends StatelessWidget {
  const LesseeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final l10n = context.l10n;
        final place = state.content?.place ?? l10n.dashboardNoLocation;
        return AppShell(
          showAppBar: false,
          title: place,
          menuLabel: l10n.openNavigationMenu,
          selectedLocation: RoutePaths.home,
          destinations: DashboardDestinations.lessee(
            l10n,
            bookingsBadge: state.content?.navBadge ?? 0,
          ),
          child: Column(
            children: [
              DashboardMarketplaceHeader(
                place: place,
                refreshing: state is DashboardRefreshing,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => context.read<DashboardCubit>().refresh(),
                  child: ResponsiveContent(child: _body(context, state)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context, DashboardState state) {
    final l10n = context.l10n;
    if (state is DashboardLoading) {
      return const Column(
        children: [
          SkeletonListCard(),
          SizedBox(height: AppSpacing.sm),
          SkeletonListCard(),
        ],
      );
    }
    if (state is DashboardFailure) {
      return Column(
        children: [
          AppEmptyState(
            icon: Icons.cloud_off,
            title: l10n.dashboardLoadFailed,
            actionLabel: l10n.dashboardRetry,
            onAction: () => context.read<DashboardCubit>().load(),
          ),
        ],
      );
    }
    final snapshot = state.content ?? const DashboardSnapshot();
    final unavailable = l10n.dashboardActionUnavailable;
    final failedResults =
        state is DashboardPartial &&
        state.failedSection == DashboardSectionId.results;
    final failedOrders =
        state is DashboardPartial &&
        state.failedSection == DashboardSectionId.orders;
    final border = context.semanticColors.border;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ActiveRentalCard(
          rental: snapshot.rental,
          place: snapshot.place,
          lastRental: snapshot.lastRental,
          onDisabled: unavailable,
        ),
        const SizedBox(height: AppSpacing.lg),
        DashboardSearchBar(
          hint: l10n.dashboardSearchHint,
          filtersLabel: l10n.dashboardFilters,
          disabledReason: unavailable,
          filterCount: snapshot.filterCount,
        ),
        const SizedBox(height: AppSpacing.lg),
        DashboardSection(
          title: l10n.dashboardBrowseByCategory.toUpperCase(),
          titleStyle: Theme.of(context).textTheme.labelSmall,
          framed: false,
          child: CategoryChipRow(
            categories: [
              (
                label: l10n.dashboardCategoryGenerators,
                icon: Icons.electrical_services_outlined,
              ),
              (
                label: l10n.dashboardCategorySound,
                icon: Icons.speaker_outlined,
              ),
              (
                label: l10n.dashboardCategoryLighting,
                icon: Icons.lightbulb_outline,
              ),
              (label: l10n.dashboardCategoryPumps, icon: Icons.water_outlined),
              (
                label: l10n.dashboardCategoryWelding,
                icon: Icons.construction_outlined,
              ),
              (
                label: l10n.dashboardCategoryMaterials,
                icon: Icons.inventory_2_outlined,
              ),
            ],
            disabledReason: unavailable,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        DashboardSection(
          title: l10n.dashboardAvailableNearYou,
          titleStyle: Theme.of(context).textTheme.titleLarge,
          contentPadding: EdgeInsets.zero,
          trailing: DashboardTextLink(
            label: l10n.dashboardSeeAll,
            disabledReason: unavailable,
            chevron: true,
            alignment: Alignment.centerRight,
          ),
          errorMessage: failedResults ? l10n.dashboardSectionFailed : null,
          onRetry: () => context.read<DashboardCubit>().retrySection(
            DashboardSectionId.results,
          ),
          child: snapshot.equipment.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text(l10n.dashboardNoResults),
                )
              : Column(
                  children: [
                    for (
                      var index = 0;
                      index < snapshot.equipment.length;
                      index++
                    ) ...[
                      if (index > 0)
                        Divider(
                          height: AppDimensions.borderWidth,
                          thickness: AppDimensions.borderWidth,
                          color: border,
                        ),
                      EquipmentResultRow(
                        listing: snapshot.equipment[index],
                        availableLabel: l10n.dashboardAvailable,
                        perDay: l10n.dashboardPerDay,
                        disabledReason: unavailable,
                      ),
                    ],
                  ],
                ),
        ),
        const SizedBox(height: AppSpacing.lg),
        DashboardSection(
          title: l10n.dashboardRecentOrders,
          titleStyle: Theme.of(context).textTheme.titleLarge,
          contentPadding: EdgeInsets.zero,
          trailing: DashboardTextLink(
            label: l10n.dashboardSeeAll,
            disabledReason: unavailable,
            chevron: true,
            alignment: Alignment.centerRight,
          ),
          errorMessage: failedOrders ? l10n.dashboardSectionFailed : null,
          onRetry: () => context.read<DashboardCubit>().retrySection(
            DashboardSectionId.orders,
          ),
          child: snapshot.orders.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text(l10n.dashboardNoOrders),
                )
              : Column(
                  children: [
                    for (
                      var index = 0;
                      index < snapshot.orders.length;
                      index++
                    ) ...[
                      if (index > 0)
                        Divider(
                          height: AppDimensions.borderWidth,
                          thickness: AppDimensions.borderWidth,
                          color: border,
                        ),
                      OrderSummaryRow(
                        order: snapshot.orders[index],
                        disabledReason: unavailable,
                      ),
                    ],
                  ],
                ),
        ),
      ],
    );
  }
}
