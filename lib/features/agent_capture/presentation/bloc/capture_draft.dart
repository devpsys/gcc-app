import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_draft.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/shop_category.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/shop_type.dart';

class CaptureDraft extends Equatable {
  const CaptureDraft({
    this.shopName = '',
    this.shopType,
    this.ownerName = '',
    this.phone = '',
    this.whatsAppSameAsPhone = true,
    this.whatsApp = '',
    this.categories = const [],
    this.market = '',
    this.zone = '',
    this.line = '',
    this.landmark = '',
    this.shopAttempted = false,
    this.assets = const [],
    this.asset = const AssetDraft(),
    this.showAssetForm = false,
    this.assetAttempted = false,
    this.savedAt,
  });

  static const int phoneLength = 10;

  final String shopName;
  final ShopType? shopType;
  final String ownerName;
  final String phone;
  final bool whatsAppSameAsPhone;
  final String whatsApp;
  final List<ShopCategory> categories;
  final String market;
  final String zone;
  final String line;
  final String landmark;
  final bool shopAttempted;

  /// Assets already appended to this capture, each collapsed to a summary row.
  final List<AssetDraft> assets;

  /// The asset currently being edited. Appended to [assets] by `addAsset`.
  final AssetDraft asset;

  /// Whether the asset form is open. Starts false so the step shows its
  /// designed empty state until the agent opts in.
  final bool showAssetForm;

  /// Set once the agent has tried to append an incomplete asset, which is what
  /// surfaces the field errors.
  final bool assetAttempted;
  final DateTime? savedAt;

  bool get needsIdentity => shopName.trim().isEmpty || ownerName.trim().isEmpty;

  bool get shopIsValid =>
      shopName.trim().isNotEmpty &&
      ownerName.trim().isNotEmpty &&
      phone.length == phoneLength &&
      shopType != null &&
      categories.isNotEmpty;

  int get shopIssueCount {
    var count = 0;
    if (shopName.trim().isEmpty) {
      count += 1;
    }
    if (shopType == null) {
      count += 1;
    }
    if (ownerName.trim().isEmpty) {
      count += 1;
    }
    if (phone.length != phoneLength) {
      count += 1;
    }
    if (categories.isEmpty) {
      count += 1;
    }
    return count;
  }

  String get whatsAppValue => whatsAppSameAsPhone ? phone : whatsApp;

  int get spatialCurrentIndex {
    if (market.trim().isEmpty) {
      return 0;
    }
    if (zone.trim().isEmpty) {
      return 1;
    }
    return 2;
  }

  /// The asset step is optional by design — the asset suite's empty state
  /// says the shop can be submitted without listing every asset. Only the
  /// currently-edited asset has to be complete before it can be appended.
  bool get assetIsComplete => asset.isComplete;

  CaptureDraft copyWith({
    String? shopName,
    ShopType? shopType,
    bool clearShopType = false,
    String? ownerName,
    String? phone,
    bool? whatsAppSameAsPhone,
    String? whatsApp,
    List<ShopCategory>? categories,
    String? market,
    String? zone,
    String? line,
    String? landmark,
    bool? shopAttempted,
    List<AssetDraft>? assets,
    AssetDraft? asset,
    bool? showAssetForm,
    bool? assetAttempted,
    DateTime? savedAt,
  }) {
    return CaptureDraft(
      shopName: shopName ?? this.shopName,
      shopType: clearShopType ? null : shopType ?? this.shopType,
      ownerName: ownerName ?? this.ownerName,
      phone: phone ?? this.phone,
      whatsAppSameAsPhone: whatsAppSameAsPhone ?? this.whatsAppSameAsPhone,
      whatsApp: whatsApp ?? this.whatsApp,
      categories: categories ?? this.categories,
      market: market ?? this.market,
      zone: zone ?? this.zone,
      line: line ?? this.line,
      landmark: landmark ?? this.landmark,
      shopAttempted: shopAttempted ?? this.shopAttempted,
      assets: assets ?? this.assets,
      asset: asset ?? this.asset,
      showAssetForm: showAssetForm ?? this.showAssetForm,
      assetAttempted: assetAttempted ?? this.assetAttempted,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  @override
  List<Object?> get props => [
    shopName,
    shopType,
    ownerName,
    phone,
    whatsAppSameAsPhone,
    whatsApp,
    categories,
    market,
    zone,
    line,
    landmark,
    shopAttempted,
    assets,
    asset,
    showAssetForm,
    assetAttempted,
    savedAt,
  ];
}
