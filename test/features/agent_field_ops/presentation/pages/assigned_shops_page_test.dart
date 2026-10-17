import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shop_status.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/route_summary.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/pages/assigned_shop_scope.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/pages/assigned_shops_page.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/empty_assignment_frame.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/route_complete_frame.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/assigned_shop_row.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/assigned_shop_status_chip.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/next_stop_bar.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/route_summary_strip.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/shop_filter_bar.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  const summary = RouteSummary(
    done: 3,
    total: 8,
    captured: 5,
    routeDistance: '18.4 km',
  );
  final shops = [
    const AssignedShop(
      name: 'Bola Hardware',
      location: 'Kugbo Market · Zone C · Line 4',
      status: AssignedShopStatus.queued,
      coordinates: '9.0580° N, 7.4100° E',
      distance: '120 m away',
    ),
    const AssignedShop(
      name: 'Eze & Sons Auto Electricals',
      location: 'Dei-Dei Market · Zone B · Line 2',
      status: AssignedShopStatus.synced,
      coordinates: '9.0104° N, 7.4691° E',
      distance: '340 m away',
    ),
    const AssignedShop(
      name: 'Okafor Welding & Fabrication',
      location: 'Dei-Dei Market · Zone A · Line 3',
      status: AssignedShopStatus.needsAttention,
      attentionReason: 'Reshoot requested — video too dark',
    ),
    const AssignedShop(
      name: 'Chief Emeka Nwosu Hardware',
      location: 'Dei-Dei Market · Zone B · Line 2',
      status: AssignedShopStatus.verified,
      note: 'Verified 12 Oct by Amaka Obi',
    ),
    const AssignedShop(
      name: 'Uche Generator Point',
      location: 'Kugbo Market · Zone B · Line 6',
      status: AssignedShopStatus.notStarted,
      coordinates: '9.0571° N, 7.4119° E',
      distance: '1.2 km away',
    ),
  ];
  Future<void> pumpPage(
    WidgetTester tester, {
    AssignedShopScope scope = AssignedShopScope.today,
    bool sortedByDistance = false,
    List<AssignedShop>? data,
    String? nextStop = '120 m',
  }) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: AssignedShopsPage(
        summary: summary,
        shops: data ?? shops,
        scope: scope,
        sortedByDistance: sortedByDistance,
        attentionCount: 1,
        nextStopDistance: nextStop,
      ),
    );
  }

  /// Drags the list until [text] is built and fully on screen.
  Future<void> reveal(WidgetTester tester, String text) async {
    final target = find.text(text);
    for (var i = 0; i < 8 && target.evaluate().isEmpty; i++) {
      await tester.drag(find.byType(ListView), const Offset(0, -280));
      await tester.pumpAndSettle();
    }
    await tester.ensureVisible(target);
    await tester.pumpAndSettle();
  }

  testWidgets('AGT-13 today frame shows the route summary', (tester) async {
    await pumpPage(tester);
    expect(find.text('Assigned shops'), findsOneWidget);
    expect(find.byType(RouteSummaryStrip), findsOneWidget);
    expect(find.text('3 done'), findsOneWidget);
    expect(find.text('18.4 km'), findsOneWidget);
    expect(find.text('Route total'), findsOneWidget);
    // 'Today' is both a scope tab and the summary label.
    expect(find.text('Today'), findsNWidgets(2));
    expect(find.text('All 24'), findsOneWidget);
  });
  testWidgets('AGT-13 rows follow the status tone rules', (tester) async {
    await pumpPage(tester);
    final chips = tester
        .widgetList<AssignedShopStatusChip>(find.byType(AssignedShopStatusChip))
        .toList();
    expect(
      chips.map((c) => c.status),
      containsAll([AssignedShopStatus.queued, AssignedShopStatus.synced]),
    );
    // Needs-attention replaces the coordinates with the reason.
    await reveal(tester, 'Reshoot requested — video too dark');
    expect(find.text('Reshoot requested — video too dark'), findsOneWidget);
  });
  testWidgets('AGT-13 verified shop credits the verifying agent', (
    tester,
  ) async {
    await pumpPage(tester);
    await reveal(tester, 'Verified 12 Oct by Amaka Obi');
    expect(find.text('Verified 12 Oct by Amaka Obi'), findsOneWidget);
    expect(find.text('Chief Emeka Nwosu Hardware'), findsOneWidget);
  });
  testWidgets('AGT-13 carries no money and no lock glyphs', (tester) async {
    await pumpPage(tester);
    expect(find.byIcon(Icons.lock), findsNothing);
    expect(find.byIcon(Icons.lock_outline), findsNothing);
    // No naira anywhere on a work list.
    expect(find.textContaining('₦'), findsNothing);
  });
  testWidgets('AGT-13 all frame swaps the summary for filters', (tester) async {
    await pumpPage(tester, scope: AssignedShopScope.all);
    expect(find.byType(RouteSummaryStrip), findsNothing);
    expect(find.text('All markets'), findsOneWidget);
    expect(find.text('All status'), findsOneWidget);
    expect(find.byType(ShopFilterChip), findsNWidgets(3));
    expect(find.text('Needs attention (1)'), findsOneWidget);
  });
  testWidgets('AGT-13 sorted frame offers a way out of the sort', (
    tester,
  ) async {
    await pumpPage(tester, sortedByDistance: true);
    expect(find.text('Sorted by distance'), findsOneWidget);
    expect(find.text('Clear sort'), findsOneWidget);
  });
  testWidgets('AGT-13 sticky next-stop footer meets the touch bound', (
    tester,
  ) async {
    await pumpPage(tester);
    expect(find.byType(NextStopBar), findsOneWidget);
    expect(find.text('Start next stop — 120 m'), findsOneWidget);
    expect(
      tester.getSize(find.byType(AppPrimaryButton)).height,
      greaterThanOrEqualTo(AppDimensions.minTouchTarget),
    );
  });
  testWidgets('AGT-13 hides the footer when there is no next stop', (
    tester,
  ) async {
    await pumpPage(tester, nextStop: null);
    expect(find.byType(NextStopBar), findsNothing);
  });
  testWidgets('AGT-13 empty assignment is not a success state', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: const EmptyAssignmentFrame(),
    );
    expect(find.text('No shops on this route yet'), findsOneWidget);
    // Not the completed-route treatment.
    expect(find.textContaining('All 8 shops captured'), findsNothing);
    expect(find.byIcon(Icons.check_rounded), findsNothing);
  });
  testWidgets('AGT-13 completed frame states what is still uploading', (
    tester,
  ) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: const RouteCompleteFrame(
        summary: RouteSummary(
          done: 8,
          total: 8,
          captured: 8,
          routeDistance: '18.4 km',
        ),
        stopCount: 8,
        uploadedCount: 7,
        pendingCount: 1,
        elapsed: '3 h 20 m',
      ),
    );
    expect(find.text('All 8 shops captured'), findsOneWidget);
    expect(find.textContaining('Uploaded 7 · 1 pending.'), findsOneWidget);
    expect(find.textContaining('18.4 km'), findsWidgets);
    expect(find.text('Load next route'), findsOneWidget);
    expect(find.text('View submissions'), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsNothing);
  });
  testWidgets('AGT-13 rows are reachable by tap', (tester) async {
    final tapped = <AssignedShop>[];
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: AssignedShopsPage(
        summary: summary,
        shops: shops,
        onShopTap: tapped.add,
      ),
    );
    expect(find.byType(AssignedShopRow), findsNWidgets(shops.length));
    await tester.tap(find.text('Bola Hardware'));
    await tester.pumpAndSettle();
    expect(ticked(tapped), isTrue);
  });
}

/// Whether the tapped shop was the one whose row was pressed.
bool ticked(List<AssignedShop> tapped) =>
    tapped.isNotEmpty && tapped.single.name == 'Bola Hardware';
