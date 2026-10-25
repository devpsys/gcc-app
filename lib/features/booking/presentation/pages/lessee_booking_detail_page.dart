import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_detail.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_detail_phase.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_booking_detail_footer.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_booking_detail_header.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_booking_detail_money.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_booking_detail_proofs.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_booking_detail_timeline.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_booking_detail_vendor.dart';
import 'package:gcc_app/features/booking/presentation/widgets/lessee_booking_rate_sheet.dart';
import 'package:go_router/go_router.dart';

class LesseeBookingDetailPage extends StatelessWidget {
  const LesseeBookingDetailPage({required this.detail, super.key});

  final LesseeBookingDetail detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            key: const Key('lessee-booking-detail-body'),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.xs,
              AppSpacing.md,
              AppSpacing.md,
            ),
            children: [
              LesseeBookingDetailHeader(detail: detail),
              const SizedBox(height: AppSpacing.sm),
              LesseeBookingDetailTimeline(events: detail.timeline),
              const SizedBox(height: AppSpacing.sm),
              LesseeBookingDetailMoney(detail: detail),
              const SizedBox(height: AppSpacing.sm),
              LesseeBookingDetailProofs(proofs: detail.proofs),
              const SizedBox(height: AppSpacing.sm),
              LesseeBookingDetailVendor(detail: detail),
            ],
          ),
        ),
        LesseeBookingDetailFooter(
          detail: detail,
          onReviewReturn:
              detail.phase == LesseeBookingDetailPhase.reviewPending
              ? () => GoRouter.maybeOf(
                  context,
                )?.push(RoutePaths.handbackOf(detail.id))
              : null,
          onRate: detail.phase == LesseeBookingDetailPhase.completed
              ? () => _rate(context)
              : null,
        ),
      ],
    );
  }

  Future<void> _rate(BuildContext context) async {
    final rating = await showLesseeBookingRateSheet(
      context: context,
      title: detail.title,
    );
    if (rating == null || !context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.bookingsRateSaved)),
    );
  }
}
