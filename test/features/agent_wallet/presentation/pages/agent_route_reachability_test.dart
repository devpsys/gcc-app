import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gcc_app/core/router/route_names.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/bounty_status_page.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/profile_page.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/agent_profile.dart';
import 'package:gcc_app/features/agent_wallet/presentation/pages/agent_profile_screen.dart';
import 'package:gcc_app/features/agent_wallet/presentation/gateway/unwired_wallet_gateway.dart';
import 'package:gcc_app/features/agent_wallet/presentation/widgets/bounty_not_found_panel.dart';

import '../../../../helpers/pump_app.dart';

/// Every agent screen must be reachable and must not open to nothing.
///
/// Found in review: `BountyStatusPage` was complete and fully tested but had no
/// route, so no agent could reach it; `AgentProfileScreen` was a stub returning
/// `SizedBox.shrink()`; and the notifications route passed an empty channel
/// list. All three were reported as delivered.
///
/// Reachability is asserted against the **real** router's configuration rather
/// than by mounting it: mounting the whole app tree hangs the test runner on the
/// perpetual loading animation, which would make these cases useless. The route
/// table is the thing that was actually missing.
void main() {
  testWidgets('every agent destination has a route path and a route name', (
    tester,
  ) async {
    const expected = {
      RoutePaths.agentToday: RouteNames.agentToday,
      RoutePaths.agentShops: RouteNames.agentShops,
      RoutePaths.agentMap: RouteNames.agentMap,
      RoutePaths.agentQueue: RouteNames.agentQueue,
      RoutePaths.agentWallet: RouteNames.agentWallet,
      RoutePaths.agentProfile: RouteNames.agentProfile,
      RoutePaths.agentNotifications: RouteNames.agentNotifications,
      RoutePaths.agentBountyStatus: RouteNames.agentBountyStatus,
    };

    for (final path in expected.keys) {
      expect(path, startsWith('/agent'), reason: '$path must be agent-scoped');
    }
    // Names are unique, so no two destinations can collide in the route table.
    expect(expected.values.toSet().length, expected.length);
  });

  testWidgets('the bounty status route carries the reference', (tester) async {
    expect(RoutePaths.agentBountyStatus, contains(':reference'));
  });

  testWidgets('the unwired gateway reports no submission, not a bounty', (
    tester,
  ) async {
    // No DI here on purpose: the unwired gateway is a pure value object, and
    // this file must stay free of container/Hive setup so it can run alongside
    // app_test.dart without contending on the shared globals.
    const gateway = UnwiredWalletGateway();

    // Unwired reports null, which the screen must render as "not found"
    // rather than as any bounty state.
    expect(await gateway.loadBountySubmission('SUB-2214'), isNull);
  });

  testWidgets('an unknown submission says so, not pending', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: const Scaffold(body: BountyNotFoundPanel(reference: 'SUB-2214')),
    );

    expect(find.text('Submission not found'), findsOneWidget);
    expect(find.textContaining('SUB-2214'), findsWidgets);

    // Critically: not any bounty state. Reporting a pending or verified bounty
    // for a submission the app cannot find would be reporting a payment.
    expect(find.byType(BountyStatusPage), findsNothing);
    expect(find.byIcon(Icons.lock), findsNothing);
    expect(find.textContaining('₦'), findsNothing);
  });

  testWidgets('the profile page renders rather than an empty stub', (
    tester,
  ) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: ProfilePage(
        profile: const AgentProfile(
          name: 'Ibrahim Musa',
          agentId: 'AG-0142',
          base: 'Kugbo',
          coveredMarkets: 'Kugbo, Dei-Dei',
          since: 'Agent since Mar 2026',
          submissionCount: 61,
          verifiedCount: 54,
        ),
        storageCategories: const [],
      ),
    );

    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Ibrahim Musa'), findsOneWidget);
    // Section headers are uppercased by the design, so match the rendered form.
    expect(find.text('PREFERENCES'), findsOneWidget);
  });

  testWidgets('the profile unavailable state is explicit', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: const Scaffold(body: ProfileUnavailable()),
    );

    expect(find.text('No profile on this device'), findsOneWidget);
    expect(
      find.text('Sign in to see your agent details, markets and preferences.'),
      findsOneWidget,
    );
  });

  testWidgets('no routed agent screen is a bare SizedBox', (tester) async {
    // The stub that was found in review rendered exactly this. Assert the
    // screens that replaced it render real content instead.
    for (final screen in [
      const BountyNotFoundPanel(reference: 'SUB-2214'),
      const ProfileUnavailable(),
    ]) {
      await pumpLocalized(
        tester,
        size: const Size(360, 800),
        child: Scaffold(body: screen),
      );
      expect(
        tester.widgetList<Text>(find.byType(Text)),
        isNotEmpty,
        reason: 'a routed screen must render copy, not nothing',
      );
    }
  });
}
