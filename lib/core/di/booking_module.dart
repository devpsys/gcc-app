import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_request_cubit.dart';
import 'package:gcc_app/features/booking/presentation/gateway/marketplace_rental_request_gateway.dart';
import 'package:gcc_app/features/booking/presentation/gateway/rental_request_gateway.dart';

void registerBookingModule() {
  getIt
    ..registerLazySingleton<RentalRequestGateway>(
      () => MarketplaceRentalRequestGateway(getIt()),
    )
    ..registerFactoryParam<RentalRequestCubit, String, void>(
      (id, _) => RentalRequestCubit(getIt(), id),
    );
}
