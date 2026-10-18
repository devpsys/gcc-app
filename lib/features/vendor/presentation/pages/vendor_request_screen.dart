import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/vendor/domain/vendor_booking_request.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_request_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_request_state.dart';
import 'package:gcc_app/features/vendor/presentation/pages/vendor_request_page.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/request_accept_dialog.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/request_decline_sheet.dart';

class VendorRequestScreen extends StatelessWidget {
  const VendorRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<VendorRequestCubit, VendorRequestState>(
      builder: (context, state) {
        final waiting = state is VendorRequestReady ? state.requestsWaiting : 0;
        return AppShell(
          title: l10n.requestTitle,
          menuLabel: l10n.openNavigationMenu,
          selectedLocation: RoutePaths.vendorRequests,
          destinations: DashboardDestinations.vendor(
            l10n,
            requestsBadge: waiting,
          ),
          child: switch (state) {
            VendorRequestLoading() => const Center(
              child: AppLoadingIndicator(),
            ),
            VendorRequestFailed() => AppEmptyState(
              icon: Icons.cloud_off,
              title: l10n.dashboardLoadFailed,
              actionLabel: l10n.dashboardRetry,
              onAction: () => context.read<VendorRequestCubit>().load(),
            ),
            VendorRequestReady(:final request) =>
              request == null
                  ? AppEmptyState(
                      icon: Icons.inbox_outlined,
                      title: l10n.requestEmpty,
                    )
                  : VendorRequestPage(
                      request: request,
                      onViewSms: () => _sms(context, request),
                      onReject: () => _decline(context),
                      onAccept: () => _accept(context, request),
                    ),
          },
        );
      },
    );
  }

  Future<void> _sms(BuildContext context, VendorBookingRequest request) {
    final l10n = context.l10n;
    return showAppSheet<void>(
      context: context,
      title: l10n.requestSmsTitle,
      closeLabel: l10n.authClose,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          0,
          AppSpacing.md,
          AppSpacing.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(request.receivedAt),
            const SizedBox(height: AppSpacing.xs),
            Text(l10n.requestSmsParity),
          ],
        ),
      ),
    );
  }

  Future<void> _accept(
    BuildContext context,
    VendorBookingRequest request,
  ) async {
    final accepted = await showDialog<bool>(
      context: context,
      builder: (context) => RequestAcceptDialog(request: request),
    );
    if (accepted == true && context.mounted) {
      context.read<VendorRequestCubit>().accept();
    }
  }

  Future<void> _decline(BuildContext context) async {
    final result = await showAppSheet<RequestDeclineResult>(
      context: context,
      title: context.l10n.requestDeclineTitle,
      closeLabel: context.l10n.authClose,
      child: const RequestDeclineSheet(),
    );
    if (result != null && context.mounted) {
      context.read<VendorRequestCubit>().decline(
        reason: result.reason,
        note: result.note,
      );
    }
  }
}
