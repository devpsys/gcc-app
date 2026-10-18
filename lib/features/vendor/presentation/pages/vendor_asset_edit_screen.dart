import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_asset_edit_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_asset_edit_state.dart';
import 'package:gcc_app/features/vendor/presentation/pages/vendor_asset_edit_page.dart';

class VendorAssetEditScreen extends StatelessWidget {
  const VendorAssetEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<VendorAssetEditCubit, VendorAssetEditState>(
      builder: (context, state) {
        final title = state is VendorAssetEditReady
            ? state.original.reference
            : l10n.editRatePerDay;
        return AppShell(
          title: title,
          menuLabel: l10n.openNavigationMenu,
          selectedLocation: RoutePaths.vendorCatalog,
          destinations: DashboardDestinations.vendor(l10n),
          child: switch (state) {
            VendorAssetEditLoading() => const Center(
              child: AppLoadingIndicator(),
            ),
            VendorAssetEditFailed() => AppEmptyState(
              icon: Icons.cloud_off,
              title: l10n.dashboardLoadFailed,
              actionLabel: l10n.dashboardRetry,
              onAction: () => context.read<VendorAssetEditCubit>().load(),
            ),
            VendorAssetEditMissing() => AppEmptyState(
              icon: Icons.inventory_2_outlined,
              title: l10n.editMissing,
            ),
            VendorAssetEditReady() => VendorAssetEditPage(state: state),
          },
        );
      },
    );
  }
}
