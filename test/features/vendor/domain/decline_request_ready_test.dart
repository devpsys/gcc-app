import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/vendor/domain/decline_request_ready.dart';
import 'package:gcc_app/features/vendor/domain/vendor_decline_reason.dart';

void main() {
  test('a decline needs a reason and a note', () {
    expect(
      declineRequestReady(reason: null, note: 'The yard is closed'),
      isFalse,
    );
    expect(
      declineRequestReady(reason: VendorDeclineReason.unavailable, note: '  '),
      isFalse,
    );
    expect(
      declineRequestReady(
        reason: VendorDeclineReason.unavailable,
        note: 'The yard is closed',
      ),
      isTrue,
    );
  });
}
