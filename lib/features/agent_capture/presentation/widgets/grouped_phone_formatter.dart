import 'package:flutter/services.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_draft.dart';

class GroupedPhoneFormatter extends TextInputFormatter {
  const GroupedPhoneFormatter();

  static String format(String raw) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    final clipped = digits.length > CaptureDraft.phoneLength
        ? digits.substring(0, CaptureDraft.phoneLength)
        : digits;
    final buffer = StringBuffer();
    for (var index = 0; index < clipped.length; index++) {
      if (index == 3 || index == 6) {
        buffer.write(' ');
      }
      buffer.write(clipped[index]);
    }
    return buffer.toString();
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final formatted = format(newValue.text);
    final cursor = newValue.selection.isValid
        ? newValue.selection.extentOffset
        : newValue.text.length;
    final bounded = cursor.clamp(0, newValue.text.length);
    final digitsBeforeCursor = newValue.text
        .substring(0, bounded)
        .replaceAll(RegExp(r'\D'), '')
        .length;
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: _offsetForDigits(formatted, digitsBeforeCursor),
      ),
    );
  }

  int _offsetForDigits(String formatted, int digitCount) {
    if (digitCount <= 0) {
      return 0;
    }
    var seen = 0;
    for (var index = 0; index < formatted.length; index++) {
      if (formatted[index] == ' ') {
        continue;
      }
      seen += 1;
      if (seen == digitCount) {
        return index + 1;
      }
    }
    return formatted.length;
  }
}
