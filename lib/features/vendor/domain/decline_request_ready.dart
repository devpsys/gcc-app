import 'package:gcc_app/features/vendor/domain/vendor_decline_reason.dart';

/// A decline needs a reason and a short factual note.
bool declineRequestReady({
  required VendorDeclineReason? reason,
  required String note,
}) {
  return reason != null && note.trim().isNotEmpty;
}
