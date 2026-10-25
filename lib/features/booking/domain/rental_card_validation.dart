/// Digits only from a typed card number.
String cardDigits(String raw) => raw.replaceAll(RegExp(r'\D'), '');

/// Nigerian cards are 16 or 19 digits. A 15-digit entry is the design error case.
String? cardNumberIssue(String raw) {
  final digits = cardDigits(raw);
  if (digits.isEmpty) {
    return 'empty';
  }
  if (digits.length == 15) {
    return 'fifteen';
  }
  if (digits.length != 16 && digits.length != 19) {
    return 'length';
  }
  return null;
}

String? cardExpiryIssue(String raw) {
  final trimmed = raw.trim();
  if (trimmed.isEmpty) {
    return 'empty';
  }
  final match = RegExp(r'^(\d{2})\s*/\s*(\d{2})$').firstMatch(trimmed);
  if (match == null) {
    return 'format';
  }
  final month = int.tryParse(match.group(1)!);
  if (month == null || month < 1 || month > 12) {
    return 'month';
  }
  return null;
}

String? cardCvvIssue(String raw) {
  final digits = cardDigits(raw);
  if (digits.length != 3) {
    return 'cvv';
  }
  return null;
}

bool cardFieldsValid({
  required String number,
  required String expiry,
  required String cvv,
}) {
  return cardNumberIssue(number) == null &&
      cardExpiryIssue(expiry) == null &&
      cardCvvIssue(cvv) == null;
}
