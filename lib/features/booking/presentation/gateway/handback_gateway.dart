import 'package:gcc_app/features/booking/domain/handback_issue_reason.dart';
import 'package:gcc_app/features/booking/domain/handback_review.dart';
import 'package:gcc_app/features/booking/domain/handback_settlement.dart';

abstract class HandbackGateway {
  Future<HandbackReview?> load(String bookingId);

  Future<HandbackSettlement> approve(String bookingId);

  Future<void> submitIssue({
    required String bookingId,
    required HandbackIssueReason reason,
    required String note,
    required int photoCount,
    required int claimAmount,
  });
}
