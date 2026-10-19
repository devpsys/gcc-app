import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_asset_edit_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_catalog_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_notice_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_profile_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_request_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_wallet_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_withdraw_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_asset_edit_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_catalog_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_notice_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_profile_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_request_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_wallet_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_asset_edit_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_catalog_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_notice_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_profile_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_request_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_wallet_gateway.dart';

/// Registers the vendor catalog presentation dependencies.
void registerVendorModule() {
  getIt
    ..registerLazySingleton<VendorCatalogGateway>(MockVendorCatalogGateway.new)
    ..registerFactory<VendorCatalogCubit>(() => VendorCatalogCubit(getIt()))
    ..registerLazySingleton<VendorRequestGateway>(MockVendorRequestGateway.new)
    ..registerFactory<VendorRequestCubit>(() => VendorRequestCubit(getIt()))
    ..registerLazySingleton<VendorWalletGateway>(MockVendorWalletGateway.new)
    ..registerFactory<VendorWalletCubit>(() => VendorWalletCubit(getIt()))
    ..registerFactory<VendorWithdrawCubit>(() => VendorWithdrawCubit(getIt()))
    ..registerLazySingleton<VendorAssetEditGateway>(
      MockVendorAssetEditGateway.new,
    )
    ..registerFactoryParam<VendorAssetEditCubit, String, void>(
      (reference, _) => VendorAssetEditCubit(getIt(), reference),
    )
    ..registerLazySingleton<VendorProfileGateway>(MockVendorProfileGateway.new)
    ..registerFactory<VendorProfileCubit>(
      () => VendorProfileCubit(getIt(), getIt()),
    )
    ..registerLazySingleton<VendorNoticeGateway>(MockVendorNoticeGateway.new)
    ..registerFactory<VendorNoticeCubit>(() => VendorNoticeCubit(getIt()));
}
