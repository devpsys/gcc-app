import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_payment_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_payment_state.dart';
import 'package:gcc_app/features/booking/presentation/pages/rental_payment_page.dart';

class RentalPaymentScreen extends StatelessWidget {
  const RentalPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<RentalPaymentCubit, RentalPaymentState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(l10n.rentalPaymentTitle)),
          body: switch (state) {
            RentalPaymentLoading() => const Center(
              child: AppLoadingIndicator(),
            ),
            RentalPaymentFailed() => AppEmptyState(
              icon: Icons.cloud_off,
              title: l10n.dashboardLoadFailed,
              actionLabel: l10n.dashboardRetry,
              onAction: () => context.read<RentalPaymentCubit>().load(),
            ),
            RentalPaymentReady() => RentalPaymentPage(state: state),
          },
        );
      },
    );
  }
}
