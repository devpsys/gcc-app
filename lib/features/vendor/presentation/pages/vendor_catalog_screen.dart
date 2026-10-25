import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/shell_navigation_style.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_catalog_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_catalog_state.dart';
import 'package:gcc_app/features/vendor/presentation/pages/vendor_catalog_page.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/catalog_block_choice.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/catalog_blocked_sheet.dart';

class VendorCatalogScreen extends StatelessWidget {
  const VendorCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<VendorCatalogCubit, VendorCatalogState>(
      listenWhen: (previous, current) {
        final before = previous is VendorCatalogReady
            ? previous.blockedReference
            : null;
        final after = current is VendorCatalogReady
            ? current.blockedReference
            : null;
        return before != after && after != null;
      },
      listener: (context, state) async {
        if (state is! VendorCatalogReady) {
          return;
        }
        final asset = state.assetBy(state.blockedReference);
        final hold = asset?.hold;
        if (hold == null) {
          return;
        }
        final choice = await showAppSheet<CatalogBlockChoice>(
          context: context,
          title: context.l10n.catalogBlockedTitle,
          closeLabel: context.l10n.authClose,
          child: CatalogBlockedSheet(hold: hold),
        );
        if (!context.mounted) {
          return;
        }
        final cubit = context.read<VendorCatalogCubit>();
        switch (choice) {
          case CatalogBlockChoice.afterReturn:
            cubit.scheduleAfterReturn();
          case CatalogBlockChoice.now:
            cubit.applyBlockedNow();
          case null:
            cubit.dismissBlock();
        }
      },
      builder: (context, state) {
        final waiting = state is VendorCatalogReady ? state.requestsWaiting : 0;
        return AppShell(
          title: l10n.catalogTitle,
          menuLabel: l10n.openNavigationMenu,
          selectedLocation: RoutePaths.vendorCatalog,
          navigationStyle: ShellNavigationStyle.topTabs,
          destinations: DashboardDestinations.vendor(
            l10n,
            requestsBadge: waiting,
          ),
          actions: [
            IconButton(
              tooltip: l10n.dashboardActionUnavailable,
              onPressed: null,
              icon: Icon(Icons.add, size: AppDimensions.iconLg),
            ),
          ],
          child: switch (state) {
            VendorCatalogLoading() => const Center(
              child: AppLoadingIndicator(),
            ),
            VendorCatalogFailed() => AppEmptyState(
              icon: Icons.cloud_off,
              title: l10n.dashboardLoadFailed,
              actionLabel: l10n.dashboardRetry,
              onAction: () => context.read<VendorCatalogCubit>().load(),
            ),
            VendorCatalogReady() => VendorCatalogPage(state: state),
          },
        );
      },
    );
  }
}
