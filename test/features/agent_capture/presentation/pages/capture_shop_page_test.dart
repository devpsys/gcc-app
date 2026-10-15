import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';
import 'package:gcc_app/features/agent_capture/presentation/pages/capture_shop_page.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/capture_field_shell.dart';

import '../../../../helpers/pump_app.dart';
import '../../fake_capture_gateway.dart';

void main() {
  testWidgets('AGT-05 starts empty and keeps continue disabled', (
    tester,
  ) async {
    final cubit = CaptureCubit(FakeCaptureGateway());
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(value: cubit, child: const CaptureShopPage()),
    );

    expect(
      tester.getSize(find.byKey(const Key('capture.appBar'))).height,
      AppDimensions.topBarHeight,
    );
    expect(
      tester.getSize(find.byKey(const Key('capture.shopNameField'))).height,
      AppDimensions.inputHeight,
    );
    expect(
      tester.getSize(find.byKey(const Key('capture.wizardBar'))).height,
      AppDimensions.wizardBarHeight,
    );
    expect(
      find.text('Fill in the shop name and owner to continue'),
      findsOneWidget,
    );
    expect(find.text('e.g. Bola Hardware'), findsOneWidget);
    expect(find.text('e.g. Alhaji Musa Ibrahim'), findsOneWidget);
    expect(find.text('STEP 1 OF 4 · SHOP DETAILS'), findsOneWidget);
    expect(find.text('START'), findsOneWidget);
    expect(find.text('1 / 4 ACTIVE'), findsNothing);
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Continue'))
          .onPressed,
      isNull,
    );
    expect(tester.takeException(), isNull);
    await cubit.close();
  });

  testWidgets('AGT-05 keeps continue enabled after an incomplete attempt', (
    tester,
  ) async {
    final cubit = CaptureCubit(FakeCaptureGateway());
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(value: cubit, child: const CaptureShopPage()),
    );

    await tester.tap(find.text('Equipment yard'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Shop name is required'), findsOneWidget);
    expect(find.text('4 fields need attention'), findsOneWidget);
    final autosave = find.textContaining('fields incomplete');
    expect(
      tester.widget<Text>(autosave).style?.color,
      tester.element(autosave).semanticColors.danger,
    );
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Continue'))
          .onPressed,
      isNotNull,
    );
    expect(tester.takeException(), isNull);
    await cubit.close();
  });

  testWidgets('AGT-05 groups a phone number and rings the focused field', (
    tester,
  ) async {
    final cubit = CaptureCubit(FakeCaptureGateway());
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(value: cubit, child: const CaptureShopPage()),
    );

    await tester.tap(find.byKey(const Key('capture.shopNameField')));
    await tester.pump();
    expect(
      tester
          .widget<CaptureFieldShell>(
            find.byKey(const Key('capture.shopNameField')),
          )
          .focused,
      isTrue,
    );

    await tester.enterText(find.byType(TextField).at(2), '8034412290');
    await tester.pump();
    expect(find.text('803 441 2290'), findsWidgets);
    expect(tester.takeException(), isNull);
    await cubit.close();
  });
}
