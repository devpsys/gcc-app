import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_asset_edit_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_asset_edit_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/pages/vendor_asset_edit_screen.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the daily example and locks only the deposit', (
    tester,
  ) async {
    await _pump(tester, 'AST-0912');

    expect(find.text('Mika 100kVA Diesel Generator Set'), findsOneWidget);
    expect(find.text('35,000'), findsOneWidget);
    expect(find.textContaining('₦196,000'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -800));
    await tester.pumpAndSettle();
    expect(find.text('₦164,075'), findsOneWidget);
    expect(find.textContaining('₦99,900'), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsOneWidget);
  });

  testWidgets('clearing the rate pauses the example and blocks save', (
    tester,
  ) async {
    await _pump(tester, 'AST-0912');

    await tester.enterText(find.byType(TextField).first, '');
    await tester.pumpAndSettle();

    expect(find.text('1 field needs attention'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -800));
    await tester.pumpAndSettle();
    expect(
      find.text('Add a rate and deposit to see what buyers will pay.'),
      findsOneWidget,
    );
    expect(find.text('₦164,075'), findsNothing);

    final save = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Save changes'),
    );
    expect(save.onPressed, isNull);
  });

  testWidgets('edit lays out at 320×640 with text scale 2', (tester) async {
    await _pump(tester, 'AST-0912', size: const Size(320, 640), scale: 2);
    expect(tester.takeException(), isNull);
  });

  testWidgets('discard restores the rate and save keeps the new one', (
    tester,
  ) async {
    final gateway = MockVendorAssetEditGateway();
    await _pump(tester, 'AST-0912', gateway: gateway);

    await tester.enterText(find.byType(TextField).first, '1000');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Discard'));
    await tester.pumpAndSettle();
    expect(find.text('35,000'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, '42000');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save changes'));
    await tester.pumpAndSettle();

    final saved = await gateway.load('AST-0912');
    expect(saved?.dailyRate, 42000);
  });

  testWidgets('the charge buttons change the rate the quote uses', (
    tester,
  ) async {
    await _pump(tester, 'AST-0912');

    await tester.tap(find.text('Hourly'));
    await tester.pumpAndSettle();
    expect(find.textContaining('₦4,375'), findsOneWidget);

    await tester.tap(find.text('Project'));
    await tester.pumpAndSettle();
    expect(find.text('Project price'), findsOneWidget);
  });
}

Future<void> _pump(
  WidgetTester tester,
  String reference, {
  MockVendorAssetEditGateway? gateway,
  Size size = const Size(360, 800),
  double scale = 1,
}) async {
  final cubit = VendorAssetEditCubit(
    gateway ?? MockVendorAssetEditGateway(),
    reference,
  );
  await cubit.load();
  addTearDown(cubit.close);
  await pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: BlocProvider.value(
      value: cubit,
      child: const VendorAssetEditScreen(),
    ),
  );
}
