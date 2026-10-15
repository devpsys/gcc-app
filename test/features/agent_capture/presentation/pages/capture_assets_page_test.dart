import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/widgets/app_segmented_control.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_category.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_condition_grade.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/capture_assets_page.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/asset_quantity_stepper.dart';

import '../../../../helpers/pump_app.dart';
import '../../fake_capture_gateway.dart';

void main() {
  /// Matches any instantiation of the generic control, which `byType` cannot
  /// do because the runtime type parameter differs per call site.
  final anySegmented = find.byWidgetPredicate((w) => w is AppSegmentedControl);

  Future<CaptureCubit> pumpAssets(WidgetTester tester) async {
    final cubit = CaptureCubit(FakeCaptureGateway());
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(value: cubit, child: const CaptureAssetsPage()),
    );
    return cubit;
  }

  /// The asset form is taller than the viewport and the step scrolls, so
  /// anything below the fold has to be brought into view before asserting.
  Future<void> scrollDown(WidgetTester tester, {int times = 12}) async {
    final scrollable = find.byType(Scrollable).first;
    for (var index = 0; index < times; index++) {
      await tester.drag(scrollable, const Offset(0, -400));
      await tester.pumpAndSettle();
    }
  }

  /// Drags until the list actually bottoms out, so a target at the very end
  /// of a long form gets built.
  Future<void> scrollToEnd(WidgetTester tester) async {
    final scrollable = find.byType(Scrollable).first;
    for (var index = 0; index < 60; index++) {
      final position = tester.state<ScrollableState>(scrollable).position;
      if (position.pixels >= position.maxScrollExtent - 1) {
        break;
      }
      await tester.drag(scrollable, const Offset(0, -600));
      await tester.pumpAndSettle();
    }
  }

  void fillAsset(CaptureCubit cubit) {
    cubit
      ..selectAssetCategory(AssetCategory.generators)
      ..editAssetCapacity('100 kVA')
      ..selectAssetCondition(AssetConditionGrade.good);
  }

  testWidgets('AGT-08 shows the designed empty state first', (tester) async {
    final cubit = await pumpAssets(tester);

    expect(find.text('No assets added yet'), findsOneWidget);
    expect(find.text('+ Add first asset'), findsOneWidget);
    expect(find.text('STEP 3 OF 4 · EQUIPMENT CATALOG'), findsOneWidget);
    expect(find.text('3 / 4 ACTIVE'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('AGT-08 continues without any asset', (tester) async {
    final cubit = await pumpAssets(tester);

    // The design states the shop can be submitted without listing every asset,
    // so Continue must not be gated on the asset form.
    final button = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Continue to media'),
    );
    expect(button.onPressed, isNotNull);
    expect(
      tester.getSize(find.byKey(const Key('capture.wizardBar'))).height,
      AppDimensions.wizardBarHeight,
    );

    await cubit.close();
  });

  testWidgets('AGT-08 opens the form and keeps 52px fields', (tester) async {
    final cubit = await pumpAssets(tester);

    await tester.tap(find.text('+ Add first asset'));
    await tester.pumpAndSettle();

    expect(find.text('SECTION A · EQUIPMENT TYPE'), findsOneWidget);
    expect(
      tester
          .getSize(find.byKey(const Key('capture.assetCapacityField')))
          .height,
      AppDimensions.inputHeight,
    );

    await cubit.close();
  });

  testWidgets('AGT-08 refuses to append an incomplete asset', (tester) async {
    final cubit = await pumpAssets(tester);
    cubit.startAssetForm();
    await tester.pumpAndSettle();

    expect(cubit.addAsset(), isFalse);
    await tester.pumpAndSettle();

    // The banner and the first two field errors sit at the top of the form,
    // so they are readable without scrolling.
    expect(find.textContaining('fields need attention'), findsOneWidget);
    expect(find.text('Choose an equipment category'), findsOneWidget);
    expect(find.text('Enter the capacity or size'), findsOneWidget);
    expect(cubit.draft.assets, isEmpty);

    await scrollDown(tester);
    expect(find.text('Choose a condition grade'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('AGT-08 appends a complete asset and opens a fresh one', (
    tester,
  ) async {
    final cubit = await pumpAssets(tester);
    cubit.startAssetForm();
    fillAsset(cubit);
    await tester.pumpAndSettle();

    expect(cubit.addAsset(), isTrue);
    await tester.pumpAndSettle();

    expect(cubit.draft.assets, hasLength(1));
    expect(cubit.draft.assets.single.displayReference, 'AST-0912');
    expect(cubit.draft.asset.isEmpty, isTrue, reason: 'form resets');
    // The collapsed row summarises what was appended.
    expect(find.textContaining('AST-0912'), findsOneWidget);
    expect(find.text('Good'), findsWidgets);

    await cubit.close();
  });

  testWidgets('AGT-08 states the bounty is per shop once two are added', (
    tester,
  ) async {
    final cubit = await pumpAssets(tester);
    cubit.startAssetForm();
    fillAsset(cubit);
    cubit.addAsset();
    fillAsset(cubit);
    cubit.addAsset();
    await tester.pumpAndSettle();

    expect(cubit.draft.assets, hasLength(2));
    await scrollToEnd(tester);
    // The notice is a multi-span RichText, so match on its plain text.
    final richTexts = tester
        .widgetList<RichText>(find.byType(RichText))
        .map((widget) => widget.text.toPlainText());
    expect(
      richTexts.any(
        (plain) =>
            plain.contains('2 assets captured.') && plain.contains('₦5,000'),
      ),
      isTrue,
      reason: 'bounty notice states the per-shop payout',
    );

    await cubit.close();
  });

  testWidgets('AGT-08 numbers the in-progress asset', (tester) async {
    final cubit = await pumpAssets(tester);

    // Nothing is numbered until the form is opened.
    expect(find.text('AST-0912'), findsNothing);

    cubit.startAssetForm();
    await tester.pumpAndSettle();
    expect(find.text('AST-0912'), findsOneWidget);

    fillAsset(cubit);
    cubit.addAsset();
    await tester.pumpAndSettle();

    expect(cubit.draft.assets.single.displayReference, 'AST-0912');
    // The next form already claims the following reference.
    expect(cubit.draft.asset.displayReference, 'AST-0913');
    // The appended row joins its parts, so match on the substring.
    expect(find.textContaining('AST-0912'), findsOneWidget);
    expect(find.text('AST-0913'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('AGT-08 quantity never drops below one', (tester) async {
    final cubit = await pumpAssets(tester);
    cubit.startAssetForm();
    await tester.pumpAndSettle();
    await scrollDown(tester);

    expect(find.byType(AssetQuantityStepper), findsOneWidget);

    cubit.changeAssetQuantity(-1);
    expect(cubit.draft.asset.quantity, 1);

    cubit.changeAssetQuantity(2);
    expect(cubit.draft.asset.quantity, 3);

    await cubit.close();
  });

  testWidgets('AGT-08 uses the 48px filled segment style', (tester) async {
    final cubit = await pumpAssets(tester);
    cubit.startAssetForm();
    await tester.pumpAndSettle();
    await scrollDown(tester);

    final controls = tester.widgetList<AppSegmentedControl>(anySegmented);
    expect(controls, isNotEmpty);
    // Both pickers use the asset design's variant, unlike the 40px raised
    // control on the shop-type step.
    for (final control in controls) {
      expect(control.style.name, 'filled');
    }

    await cubit.close();
  });
}
