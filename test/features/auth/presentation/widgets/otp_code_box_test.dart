import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/auth/presentation/widgets/otp_code_box.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('paints filled, focused, and error borders', (tester) async {
    await pumpLocalized(
      tester,
      child: const Column(
        children: [
          OtpCodeBox(digit: '1', filled: true, focused: false, hasError: false),
          OtpCodeBox(digit: '', filled: false, focused: true, hasError: false),
          OtpCodeBox(digit: '2', filled: true, focused: false, hasError: true),
        ],
      ),
    );

    final scheme = Theme.of(tester.element(find.byType(OtpCodeBox).first))
        .colorScheme;
    final decorations = tester
        .widgetList<DecoratedBox>(find.byType(DecoratedBox))
        .map((box) => box.decoration)
        .whereType<BoxDecoration>()
        .toList();

    expect((decorations[0].border! as Border).top.color, scheme.primary);
    expect(decorations[1].color, scheme.surface);
    expect((decorations[1].border! as Border).top.color, scheme.primary);
    expect(decorations[2].color, scheme.errorContainer);
    expect((decorations[2].border! as Border).top.color, scheme.error);
  });
}
