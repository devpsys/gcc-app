import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/semantics.dart';

import 'package:gcc_app/features/agent_wallet/presentation/widgets/profile_unavailable.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/agent_today_header.dart';

import '../../../../helpers/pump_app.dart';

/// Both entry points must actually work, not merely be wired.
///
/// Found in review: the avatar on the Today header existed but
/// `onOpenProfile` was never passed from the page, so it rendered inert; and
/// notification settings sat behind the profile's Notifications row, which
/// never renders while there is no profile — so notifications had no entry
/// point at all.
///
/// These cases assert the handlers are *invoked*, which is the thing a wiring
/// check misses.
void main() {
  testWidgets('the Today header avatar opens the profile when tapped', (
    tester,
  ) async {
    var opened = false;
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: Scaffold(
        body: AgentTodayHeader(
          dateLabel: 'Monday, 13 Oct',
          greeting: 'Good morning, Ibrahim',
          agentId: 'AG-0142',
          assignment: 'Kugbo · 8 stops',
          disabledReason: '',
          installLabel: 'Add to home screen',
          onOpenProfile: () => opened = true,
        ),
      ),
    );

    final avatar = find.bySemanticsLabel('Profile');
    expect(avatar, findsOneWidget);
    expect(find.byIcon(Icons.person_outline), findsOneWidget);

    await tester.tap(avatar);
    await tester.pump();
    expect(opened, isTrue, reason: 'the avatar must invoke its handler');
  });

  testWidgets('the avatar is inert when no handler is supplied', (
    tester,
  ) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: Scaffold(
        body: AgentTodayHeader(
          dateLabel: 'Monday, 13 Oct',
          greeting: 'Good morning',
          agentId: 'AG-0142',
          assignment: 'Kugbo · 8 stops',
          disabledReason: '',
          installLabel: 'Add to home screen',
        ),
      ),
    );

    // Still rendered, but not announced as a button — an inert control should
    // not look tappable.
    final semantics = tester.getSemantics(find.bySemanticsLabel('Profile'));
    // ignore: deprecated_member_use
    expect(semantics.hasFlag(SemanticsFlag.isButton), isFalse);
  });

  testWidgets('notifications stay reachable with no profile', (tester) async {
    var opened = false;
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: Scaffold(
        body: ProfileUnavailable(onOpenNotifications: () => opened = true),
      ),
    );

    expect(find.text('No profile on this device'), findsOneWidget);

    // The defect: these rows belong to the agent, so without this the
    // notification settings had no way in at all.
    await tester.tap(find.text('Notifications'));
    await tester.pump();
    expect(opened, isTrue);
  });

  testWidgets('no handler means no notification button', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: const Scaffold(body: ProfileUnavailable()),
    );

    // Better absent than present-and-dead.
    expect(find.text('Notifications'), findsNothing);
  });
}
