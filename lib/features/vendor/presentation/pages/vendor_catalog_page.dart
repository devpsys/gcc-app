import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset_status.dart';
import 'package:gcc_app/features/vendor/domain/vendor_catalog_kind.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_catalog_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_catalog_state.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/catalog_asset_card.dart';
import 'package:go_router/go_router.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/catalog_undo_banner.dart';

class VendorCatalogPage extends StatelessWidget {
  const VendorCatalogPage({required this.state, super.key});

  final VendorCatalogReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<VendorCatalogCubit>();
    final scheme = Theme.of(context).colorScheme;
    final visible = state.visible;
    final undoAsset = state.assetBy(state.undoReference);
    return ColoredBox(
      color: scheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBox(
            color: scheme.surface,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: _kinds(context, state, cubit),
            ),
          ),
          ColoredBox(
            color: scheme.surface,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                children: [
                  _filter(context, state, cubit, null, l10n.catalogFilterAll),
                  _filter(
                    context,
                    state,
                    cubit,
                    VendorAssetStatus.ready,
                    l10n.catalogFilterReady,
                  ),
                  _filter(
                    context,
                    state,
                    cubit,
                    VendorAssetStatus.rented,
                    l10n.catalogFilterRented,
                  ),
                  _filter(
                    context,
                    state,
                    cubit,
                    VendorAssetStatus.maintenance,
                    l10n.catalogFilterMaintenance,
                  ),
                  _filter(
                    context,
                    state,
                    cubit,
                    VendorAssetStatus.pending,
                    l10n.catalogFilterPending,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                if (undoAsset != null) ...[
                  CatalogUndoBanner(
                    message: l10n.catalogUndoToast(undoAsset.reference),
                    actionLabel: l10n.catalogUndo,
                    onUndo: cubit.undo,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                if (visible.isEmpty)
                  AppEmptyState(
                    icon: Icons.inventory_2_outlined,
                    title: state.kind == VendorCatalogKind.bulkGoods
                        ? l10n.catalogEmptyBulk
                        : l10n.catalogEmptyFilter,
                  )
                else
                  for (final asset in visible) ...[
                    CatalogAssetCard(
                      asset: asset,
                      perDay: l10n.catalogPerDay,
                      depositCaption: l10n.catalogCautionDeposit,
                      readyLabel: l10n.catalogStatusReady,
                      rentedLabel: l10n.catalogStatusRented,
                      maintenanceLabel: l10n.catalogStatusMaintenance,
                      pendingNote: l10n.catalogPendingNote,
                      undoLabel: state.undoReference == asset.reference
                          ? l10n.catalogUndo
                          : null,
                      undoHint: state.undoReference == asset.reference
                          ? l10n.catalogUndoHint
                          : null,
                      onUndo: state.undoReference == asset.reference
                          ? cubit.undo
                          : null,
                      onOpen: () => context.push(
                        RoutePaths.vendorAssetEditOf(asset.reference),
                      ),
                      onStatus: (status) =>
                          cubit.requestStatus(asset.reference, status),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _kinds(
    BuildContext context,
    VendorCatalogReady state,
    VendorCatalogCubit cubit,
  ) {
    final l10n = context.l10n;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.button),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxs),
        child: Row(
          children: [
            _kind(
              context,
              label: l10n.catalogKindEquipment(
                state.countOf(VendorCatalogKind.equipment),
              ),
              selected: state.kind == VendorCatalogKind.equipment,
              onTap: () => cubit.selectKind(VendorCatalogKind.equipment),
            ),
            _kind(
              context,
              label: l10n.catalogKindBulk(
                state.countOf(VendorCatalogKind.bulkGoods),
              ),
              selected: state.kind == VendorCatalogKind.bulkGoods,
              onTap: () => cubit.selectKind(VendorCatalogKind.bulkGoods),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kind(
    BuildContext context, {
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Material(
        color: selected ? scheme.primary : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.input),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.input),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: AppDimensions.minTouchTarget - AppSpacing.xs,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: selected ? scheme.onPrimary : scheme.onSurface,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _filter(
    BuildContext context,
    VendorCatalogReady state,
    VendorCatalogCubit cubit,
    VendorAssetStatus? status,
    String Function(int count) label,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final selected = state.filter == status;
    final count = state.countOf(state.kind, status);
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.xs),
      child: FilterChip(
        label: Text(label(count)),
        selected: selected,
        onSelected: (_) => cubit.selectFilter(status),
        showCheckmark: false,
        selectedColor: scheme.primaryContainer,
        labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: selected ? scheme.primary : scheme.onSurface,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
        ),
        side: BorderSide(color: selected ? scheme.primary : scheme.outline),
      ),
    );
  }
}
