import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/grouped_phone_formatter.dart';

void main() {
  test('groups a shop phone into 3-3-4', () {
    const formatter = GroupedPhoneFormatter();
    final result = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(
        text: '8034412290',
        selection: TextSelection.collapsed(offset: 10),
      ),
    );

    expect(result.text, '803 441 2290');
    expect(result.selection.extentOffset, result.text.length);
  });

  test('keeps the cursor on the digit that was just typed', () {
    const formatter = GroupedPhoneFormatter();
    final result = formatter.formatEditUpdate(
      const TextEditingValue(
        text: '803',
        selection: TextSelection.collapsed(offset: 3),
      ),
      const TextEditingValue(
        text: '8034',
        selection: TextSelection.collapsed(offset: 4),
      ),
    );

    expect(result.text, '803 4');
    expect(result.selection.extentOffset, 5);
  });
}
