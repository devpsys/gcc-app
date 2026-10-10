import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/theme/app_theme.dart';

void main() {
  testWidgets('uses Inter for interface text and JetBrains Mono for codes', (
    tester,
  ) async {
    final theme = AppTheme.light();
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: const Scaffold(body: Text('Choose your language')),
      ),
    );

    final paragraph = tester.renderObject<RenderParagraph>(
      find.text('Choose your language'),
    );
    expect(paragraph.text.style?.fontFamily, AppTextStyles.sansFamily);
    expect(
      AppTextStyles.mono(theme.textTheme.bodyMedium!).fontFamily,
      AppTextStyles.monoFamily,
    );
    expect(tester.takeException(), isNull);
  });
}
