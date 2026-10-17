import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';
import 'package:gcc_app/core/widgets/language_option.dart';
import 'package:gcc_app/core/widgets/language_option_row.dart';

import '../../helpers/pump_app.dart';

void main() {
  /// Hosts a button that opens a sheet with [body].
  Widget host(Widget body, {Widget? footer}) => Builder(
    builder: (context) => Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => showAppSheet<void>(
            context: context,
            title: 'Filter radius',
            subtitle: 'Cached areas only',
            footer: footer,
            child: body,
          ),
          child: const Text('open'),
        ),
      ),
    ),
  );

  /// A body that insists on being taller than any sheet.
  ///
  /// Stands in for the worst case: content that was never told to scroll.
  Widget buildTallBody() => const SizedBox(height: 2000);

  testWidgets('AppSheet clamps a body taller than the sheet', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: host(buildTallBody()),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    // This used to throw a RenderFlex overflow on the sheet's Column.
    expect(tester.takeException(), isNull);
    expect(find.byType(AppSheet), findsOneWidget);
  });

  testWidgets('AppSheet survives a large text scale', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      textScaler: const TextScaler.linear(2.0),
      child: host(
        buildTallBody(),
        footer: const AppPrimaryButton(label: 'Apply', expand: true),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Apply'), findsOneWidget);
  });

  testWidgets('AppSheet survives a tall screen', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 1400),
      child: host(buildTallBody()),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('AppSheet keeps a scrollable body scrollable', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: host(
        ListView.builder(
          itemCount: 40,
          itemBuilder: (context, index) =>
              SizedBox(height: 48, child: Text('row $index')),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('row 0'), findsOneWidget);
    // The body scrolls inside the sheet rather than being clipped away.
    expect(find.text('row 39'), findsNothing);
  });

  testWidgets('AppSheet body stays short when it wants to be', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: host(const SizedBox(height: 24)),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    // Not stretched to fill: a short body keeps the sheet compact.
    final sheet = tester.getSize(find.byType(AppSheet));
    expect(sheet.height, lessThan(400));
  });

  testWidgets('language rows render inside a bounded sheet', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: host(
        ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) => LanguageOptionRow(
            option: LanguageOption(
              id: 'lang-$index',
              englishName: 'Language $index',
              nativeName: 'Language $index',
              sample: 'Sample $index',
              enabled: true,
            ),
            selected: index == 0,
            unavailableReason: 'Unavailable',
            onTap: () {},
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Language 0'), findsOneWidget);
  });
}
