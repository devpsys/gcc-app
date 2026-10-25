import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_status_args.dart';
import 'package:gcc_app/features/booking/domain/rental_request.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_payment_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_payment_status_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_request_cubit.dart';
import 'package:gcc_app/features/booking/presentation/gateway/marketplace_rental_request_gateway.dart';
import 'package:gcc_app/features/booking/presentation/gateway/mock_rental_payment_gateway.dart';
import 'package:gcc_app/features/booking/presentation/gateway/mock_rental_payment_status_gateway.dart';
import 'package:gcc_app/features/booking/presentation/gateway/rental_payment_gateway.dart';
import 'package:gcc_app/features/booking/presentation/gateway/rental_payment_status_gateway.dart';
import 'package:gcc_app/features/booking/presentation/gateway/rental_request_gateway.dart';

void registerBookingModule() {
  getIt
    ..registerLazySingleton<RentalRequestGateway>(
      () => MarketplaceRentalRequestGateway(getIt()),
    )
    ..registerLazySingleton<RentalPaymentGateway>(MockRentalPaymentGateway.new)
    ..registerLazySingleton<RentalPaymentStatusGateway>(
      MockRentalPaymentStatusGateway.new,
    )
    ..registerFactoryParam<RentalRequestCubit, String, void>(
      (id, _) => RentalRequestCubit(getIt(), id),
    )
    ..registerFactoryParam<RentalPaymentCubit, RentalRequest, void>(
      (request, _) => RentalPaymentCubit(getIt(), request),
    )
    ..registerFactoryParam<
      RentalPaymentStatusCubit,
      RentalPaymentStatusArgs,
      void
    >((args, _) => RentalPaymentStatusCubit(getIt(), args));
}
