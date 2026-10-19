import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_browse_cubit.dart';
import 'package:gcc_app/features/marketplace/presentation/gateway/mock_marketplace_gateway.dart';
import 'package:gcc_app/features/marketplace/presentation/pages/marketplace_browse_screen.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_listing_card.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the five listings and locks only the deposit', (
    tester,
  ) async {
    await _pump(tester);

    expect(find.text('Mika 100kVA Diesel Generator Set'), findsOneWidget);
    expect(find.text('5 results in 3 markets'), findsOneWidget);
    expect(find.text('100 kVA · 23'), findsOneWidget);
    final mika = find.ancestor(
      of: find.text('Mika 100kVA Diesel Generator Set'),
      matching: find.byType(MarketplaceListingCard),
    );
    expect(
      find.descendant(of: mika, matching: find.byIcon(Icons.lock)),
      findsOneWidget,
    );

    await _reveal(tester, find.text('250A Welding Machine'));
    final welder = find.ancestor(
      of: find.text('250A Welding Machine'),
      matching: find.byType(MarketplaceListingCard),
    );
    expect(find.text('In use until 16 Oct'), findsOneWidget);
    expect(
      find.descendant(of: welder, matching: find.byIcon(Icons.lock)),
      findsOneWidget,
    );

    await _reveal(tester, find.text('Out of service'));
    expect(find.text('Out of service'), findsOneWidget);
  });

  testWidgets('a search with no match shows the empty state', (tester) async {
    await _pump(tester);

    await tester.enterText(find.byType(TextField), 'catering freezer');
    await tester.pumpAndSettle();

    expect(find.text('No equipment matches'), findsOneWidget);
    expect(find.textContaining('catering freezer'), findsWidgets);
    expect(find.text('Clear all filters'), findsOneWidget);
    expect(find.text('Mika 100kVA Diesel Generator Set'), findsNothing);
  });

  testWidgets('available now hides equipment that cannot be booked', (
    tester,
  ) async {
    await _pump(tester);

    await tester.tap(find.text('Available now').first);
    await tester.pumpAndSettle();

    expect(find.textContaining('3 results'), findsOneWidget);
    expect(find.text('250A Welding Machine'), findsNothing);
    expect(find.text('5HP Water Pump'), findsNothing);
    expect(find.text('Mika 100kVA Diesel Generator Set'), findsOneWidget);
  });

  testWidgets('the filter sheet matches the market and category layout', (
    tester,
  ) async {
    await _pump(tester);

    await tester.tap(find.text('Filters'));
    await tester.pumpAndSettle();

    expect(find.text('Near me'), findsOneWidget);
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Category'), findsOneWidget);
    expect(find.text('Rate per day'), findsOneWidget);

    await tester.drag(find.byType(ListView).last, const Offset(0, -600));
    await tester.pumpAndSettle();
    expect(find.text('With certified operator'), findsOneWidget);
    expect(
      find.text("Deposit range can't be combined with a rate filter."),
      findsOneWidget,
    );

    await tester.tap(find.text('Caution deposit under ₦25,000'));
    await tester.pumpAndSettle();

    final slider = tester.widget<RangeSlider>(find.byType(RangeSlider));
    slider.onChanged!(const RangeValues(5000, 40000));
    await tester.pumpAndSettle();
    expect(find.textContaining("can't be combined"), findsOneWidget);
  });

  testWidgets('bulk trade has no goods to show', (tester) async {
    await _pump(tester);

    await tester.tap(find.text('Bulk trade'));
    await tester.pumpAndSettle();

    expect(find.text('No bulk goods yet'), findsOneWidget);
    expect(find.byType(MarketplaceListingCard), findsNothing);
  });

  testWidgets('lays out at 320×640 with text scale 2', (tester) async {
    await _pump(tester, size: const Size(320, 640), scale: 2);

    await tester.drag(find.byType(ListView), const Offset(0, -900));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}

Future<void> _reveal(WidgetTester tester, Finder target) async {
  final list = find.byType(ListView);
  for (var step = 0; step < 8; step++) {
    if (target.hitTestable().evaluate().isNotEmpty) {
      return;
    }
    await tester.drag(list, const Offset(0, -350));
    await tester.pumpAndSettle();
  }
}

Future<void> _pump(
  WidgetTester tester, {
  Size size = const Size(360, 800),
  double scale = 1,
}) {
  return pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: BlocProvider(
      create: (_) =>
          MarketplaceBrowseCubit(const MockMarketplaceGateway())..load(),
      child: const MarketplaceBrowseScreen(),
    ),
  );
}
