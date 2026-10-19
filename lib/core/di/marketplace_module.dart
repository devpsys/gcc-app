import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_cubit.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_listing_cubit.dart';
import 'package:gcc_app/features/marketplace/presentation/gateway/marketplace_gateway.dart';
import 'package:gcc_app/features/marketplace/presentation/gateway/mock_marketplace_gateway.dart';

void registerMarketplaceModule() {
  getIt
    ..registerLazySingleton<MarketplaceGateway>(MockMarketplaceGateway.new)
    ..registerFactory<MarketplaceBrowseCubit>(
      () => MarketplaceBrowseCubit(getIt()),
    )
    ..registerFactoryParam<MarketplaceListingCubit, String, void>(
      (id, _) => MarketplaceListingCubit(getIt(), id),
    );
}
