import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_catalog_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_catalog_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/pages/vendor_catalog_screen.dart';
import 'package:gcc_app/features/vendor/presentation/widgets/catalog_asset_card.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the four equipment cards and an empty bulk tab', (
    tester,
  ) async {
    await _pump(tester);

    expect(find.textContaining('AST-0912'), findsOneWidget);
    expect(find.textContaining('AST-0913'), findsOneWidget);
    expect(find.text('₦50,000'), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsWidgets);
    expect(find.text('Equipment (4)'), findsOneWidget);
    expect(find.text('Bulk goods (0)'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.textContaining('AST-0902'),
      400,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.textContaining('AST-0902'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.textContaining('AST-0874'),
      400,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.textContaining('AST-0874'), findsOneWidget);

    await tester.tap(find.text('Bulk goods (0)'));
    await tester.pumpAndSettle();

    expect(find.text('No bulk goods in this catalog.'), findsOneWidget);
  });

  testWidgets('scheduling maintenance keeps the rented booking', (
    tester,
  ) async {
    await _pump(tester);

    await tester.tap(_status('AST-0913', 'Maintenance'));
    await tester.pumpAndSettle();

    expect(find.text('Set to In maintenance?'), findsOneWidget);
    expect(find.text('1 active booking is affected'), findsOneWidget);

    await tester.tap(find.widgetWithText(AppPrimaryButton, 'Set after return'));
    await tester.pumpAndSettle();

    expect(
      find.text('Set to In maintenance · changes again on 17 Oct, 09:00'),
      findsOneWidget,
    );
    expect(find.text('On BK-24804 · returns 17 Oct, 09:00'), findsOneWidget);
    expect(find.textContaining('set to In maintenance'), findsNothing);
  });

  testWidgets('immediate maintenance can be undone', (tester) async {
    await _pump(tester);

    await tester.tap(_status('AST-0912', 'Maintenance'));
    await tester.pumpAndSettle();

    expect(find.text('AST-0912 set to In maintenance'), findsOneWidget);
    expect(find.text('Reversible within 10 seconds'), findsOneWidget);

    await tester.tap(find.text('Undo').first);
    await tester.pumpAndSettle();

    expect(find.text('AST-0912 set to In maintenance'), findsNothing);
    expect(find.text('Reversible within 10 seconds'), findsNothing);
  });

  testWidgets('catalog lays out at 320×640 with text scale 2', (tester) async {
    await _pump(tester, size: const Size(320, 640), scale: 2);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pump(
  WidgetTester tester, {
  Size size = const Size(360, 800),
  double scale = 1,
}) async {
  final cubit = VendorCatalogCubit(const MockVendorCatalogGateway());
  await cubit.load();
  addTearDown(cubit.close);
  await pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: BlocProvider.value(value: cubit, child: const VendorCatalogScreen()),
  );
}

Finder _status(String reference, String label) {
  final card = find.ancestor(
    of: find.textContaining(reference),
    matching: find.byType(CatalogAssetCard),
  );
  return find.descendant(of: card, matching: find.text(label));
}
