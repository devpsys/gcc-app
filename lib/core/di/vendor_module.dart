import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_catalog_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_request_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_catalog_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_request_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_catalog_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_request_gateway.dart';

/// Registers the vendor catalog presentation dependencies.
void registerVendorModule() {
  getIt
    ..registerLazySingleton<VendorCatalogGateway>(MockVendorCatalogGateway.new)
    ..registerFactory<VendorCatalogCubit>(() => VendorCatalogCubit(getIt()))
    ..registerLazySingleton<VendorRequestGateway>(MockVendorRequestGateway.new)
    ..registerFactory<VendorRequestCubit>(() => VendorRequestCubit(getIt()));
}
