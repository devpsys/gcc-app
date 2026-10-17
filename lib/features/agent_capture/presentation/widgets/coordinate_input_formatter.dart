import 'package:flutter/services.dart';

/// Allows only the characters a decimal degree can contain.
///
/// Strips the offending characters rather than rejecting the whole edit, which
/// is what an agent typing quickly on a phone needs.
class CoordinateInputFormatter extends TextInputFormatter {
  CoordinateInputFormatter({RegExp? pattern})
    : _pattern = pattern ?? RegExp(r'[^0-9.\-]');

  final RegExp _pattern;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final filtered = newValue.text.replaceAll(_pattern, '');
    if (filtered == newValue.text) {
      return newValue;
    }
    return newValue.copyWith(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}
