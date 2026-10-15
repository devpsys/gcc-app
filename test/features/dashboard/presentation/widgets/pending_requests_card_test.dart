import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/pending_requests_card.dart';

import '../../../../helpers/pump_app.dart';
import '../dashboard_fixtures.dart';

void main() {
  testWidgets('renders the countdown in monospace and not as a live region', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: const PendingRequestsCard(
        requests: waitingRequests,
        emptyTitle: 'No requests waiting',
        emptyBody: 'New booking requests arrive by SMS and appear here.',
        waitingTitle: '3 booking requests waiting',
        respondWithin: 'Respond within',
        expiry:
            'Unanswered requests expire in 6 hours and go to the next vendor.',
        respondLabel: 'Respond to requests',
        allRequestsLabel: 'All 3 requests',
        disabledReason: "This isn't available in the app yet.",
      ),
    );

    final countdown = tester.widget<Text>(find.text('06:12:40'));
    expect(countdown.style?.fontFamily, AppTextStyles.monoFamily);
    expect(
      tester.getSemantics(find.text('06:12:40')).flagsCollection.isLiveRegion,
      isFalse,
    );
    semantics.dispose();
  });
}
