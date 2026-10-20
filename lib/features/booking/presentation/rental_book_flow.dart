import 'package:flutter/material.dart';
import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_request_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_request_state.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_dates_sheet.dart';
import 'package:go_router/go_router.dart';

/// Opens the dates sheet, then the confirm route when the lessee reviews.
Future<void> startRentalRequest({
  required BuildContext context,
  required String listingId,
}) async {
  final cubit = getIt<RentalRequestCubit>(param1: listingId);
  await cubit.load();
  if (!context.mounted) {
    await cubit.close();
    return;
  }
  if (cubit.state is! RentalRequestReady) {
    await cubit.close();
    return;
  }
  final reviewed = await showRentalDatesSheet(context: context, cubit: cubit);
  if (!reviewed || !context.mounted) {
    await cubit.close();
    return;
  }
  final router = GoRouter.maybeOf(context);
  if (router == null) {
    await cubit.close();
    return;
  }
  await router.push(RoutePaths.rentalRequestOf(listingId), extra: cubit);
}
