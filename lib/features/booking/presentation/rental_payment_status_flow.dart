import 'package:flutter/material.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_account.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_method.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_status_args.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_status_phase.dart';
import 'package:gcc_app/features/booking/domain/rental_request.dart';
import 'package:go_router/go_router.dart';

Future<void> openRentalPaymentStatus({
  required BuildContext context,
  required RentalRequest request,
  required RentalPaymentAccount account,
  required RentalPaymentMethod method,
  required RentalPaymentStatusPhase phase,
}) async {
  final router = GoRouter.maybeOf(context);
  if (router == null) {
    return;
  }
  await router.push(
    RoutePaths.rentalPaymentStatusOf(request.listing.id),
    extra: RentalPaymentStatusArgs(
      request: request,
      account: account,
      method: method,
      initialPhase: phase,
    ),
  );
}
