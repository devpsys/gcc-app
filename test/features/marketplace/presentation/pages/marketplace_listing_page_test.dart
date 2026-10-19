import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_listing_cubit.dart';
import 'package:gcc_app/features/marketplace/presentation/gateway/mock_marketplace_gateway.dart';
import 'package:gcc_app/features/marketplace/presentation/pages/marketplace_listing_screen.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_deposit_card.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_rate_card.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the rate, the locked deposit, and the three-day total', (
    tester,
  ) async {
    await _pump(tester);

    expect(find.text('Mika 100kVA Diesel Generator Set'), findsOneWidget);
    await _reveal(tester, find.text('₦196,000'));
    expect(find.text('₦196,000'), findsOneWidget);
    expect(find.text('₦700,000'), findsOneWidget);

    await _reveal(tester, find.byType(MarketplaceDepositCard));
    final deposit = find.byType(MarketplaceDepositCard);
    expect(
      find.descendant(of: deposit, matching: find.byIcon(Icons.lock)),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(MarketplaceRateCard),
        matching: find.byIcon(Icons.lock),
      ),
      findsNothing,
    );

    await _reveal(tester, find.textContaining('₦114,075'));
    expect(find.textContaining('₦114,075'), findsOneWidget);
    await _reveal(tester, find.text('Book now'));
    final book = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Book now'),
    );
    expect(book.onPressed, isNull);
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
          MarketplaceListingCubit(const MockMarketplaceGateway(), 'mika-100')
            ..load(),
      child: const MarketplaceListingScreen(),
    ),
  );
}
