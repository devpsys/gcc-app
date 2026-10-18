import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset_status.dart';
import 'package:gcc_app/features/vendor/domain/vendor_catalog_kind.dart';

sealed class VendorCatalogState extends Equatable {
  const VendorCatalogState();
}

final class VendorCatalogLoading extends VendorCatalogState {
  const VendorCatalogLoading();

  @override
  List<Object?> get props => const [];
}

final class VendorCatalogReady extends VendorCatalogState {
  const VendorCatalogReady({
    required this.assets,
    required this.requestsWaiting,
    this.kind = VendorCatalogKind.equipment,
    this.filter,
    this.undoReference,
    this.undoStatus,
    this.blockedReference,
  });

  final List<VendorAsset> assets;
  final int requestsWaiting;
  final VendorCatalogKind kind;

  /// Null means every status in the selected kind.
  final VendorAssetStatus? filter;
  final String? undoReference;
  final VendorAssetStatus? undoStatus;
  final String? blockedReference;

  List<VendorAsset> get visible => assets
      .where((asset) => asset.kind == kind)
      .where((asset) => filter == null || asset.status == filter)
      .toList();

  int countOf(VendorCatalogKind segment, [VendorAssetStatus? status]) {
    return assets
        .where((asset) => asset.kind == segment)
        .where((asset) => status == null || asset.status == status)
        .length;
  }

  VendorAsset? assetBy(String? reference) {
    if (reference == null) {
      return null;
    }
    for (final asset in assets) {
      if (asset.reference == reference) {
        return asset;
      }
    }
    return null;
  }

  VendorCatalogReady copyWith({
    List<VendorAsset>? assets,
    VendorCatalogKind? kind,
    VendorAssetStatus? filter,
    bool clearFilter = false,
    String? undoReference,
    VendorAssetStatus? undoStatus,
    bool clearUndo = false,
    String? blockedReference,
    bool clearBlocked = false,
  }) {
    return VendorCatalogReady(
      assets: assets ?? this.assets,
      requestsWaiting: requestsWaiting,
      kind: kind ?? this.kind,
      filter: clearFilter ? null : filter ?? this.filter,
      undoReference: clearUndo ? null : undoReference ?? this.undoReference,
      undoStatus: clearUndo ? null : undoStatus ?? this.undoStatus,
      blockedReference: clearBlocked
          ? null
          : blockedReference ?? this.blockedReference,
    );
  }

  @override
  List<Object?> get props => [
    assets,
    requestsWaiting,
    kind,
    filter,
    undoReference,
    undoStatus,
    blockedReference,
  ];
}

final class VendorCatalogFailed extends VendorCatalogState {
  const VendorCatalogFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
