import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/booking/domain/handback_phase.dart';
import 'package:gcc_app/features/booking/presentation/bloc/handback_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/handback_state.dart';
import 'package:gcc_app/features/booking/presentation/pages/handback_page.dart';
import 'package:gcc_app/features/booking/presentation/widgets/handback_approved_body.dart';
import 'package:go_router/go_router.dart';

class HandbackScreen extends StatelessWidget {
  const HandbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<HandbackCubit, HandbackState>(
      builder: (context, state) {
        final title = switch (state) {
          HandbackReady(:final phase) when phase == HandbackPhase.approved =>
            l10n.handbackDepositReleasedTitle,
          _ => l10n.handbackConfirmTitle,
        };
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            leading: BackButton(
              onPressed: () {
                final router = GoRouter.maybeOf(context);
                if (router?.canPop() ?? false) {
                  router?.pop();
                } else {
                  router?.go(RoutePaths.bookings);
                }
              },
            ),
          ),
          body: switch (state) {
            HandbackLoading() => const Center(child: AppLoadingIndicator()),
            HandbackFailed() => AppEmptyState(
              icon: Icons.cloud_off,
              title: l10n.dashboardLoadFailed,
              actionLabel: l10n.dashboardRetry,
              onAction: () => context.read<HandbackCubit>().load(),
            ),
            HandbackMissing() => AppEmptyState(
              icon: Icons.search_off,
              title: l10n.handbackMissing,
            ),
            HandbackReady(
              :final phase,
              :final settlement,
              :final review,
            ) =>
              switch (phase) {
                HandbackPhase.review => HandbackPage(state: state),
                HandbackPhase.approved => HandbackApprovedBody(
                  settlement: settlement!,
                  onBrowse: () =>
                      GoRouter.maybeOf(context)?.go(RoutePaths.browse),
                  onBookAgain: review.listingId == null
                      ? null
                      : () => GoRouter.maybeOf(context)?.go(
                          RoutePaths.marketplaceListingOf(review.listingId!),
                        ),
                ),
              },
          },
        );
      },
    );
  }
}
