/// Digits from a money field, ignoring the naira sign and grouping commas.
int? parseNairaInput(String raw) {
  final digits = raw.replaceAll(RegExp('[^0-9]'), '');
  if (digits.isEmpty) {
    return null;
  }
  return int.tryParse(digits);
}

/// `35000` becomes `35,000`.
String groupNaira(int value) {
  final text = value.toString();
  final buffer = StringBuffer();
  for (var index = 0; index < text.length; index++) {
    final remaining = text.length - index;
    if (index > 0 && remaining % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(text[index]);
  }
  return buffer.toString();
}

/// `35000` becomes `₦35k` when it lands on a thousand.
String compactNaira(int value) {
  if (value >= 1000 && value % 1000 == 0) {
    return '₦${value ~/ 1000}k';
  }
  return '₦${groupNaira(value)}';
}

/// `35000` becomes `₦35,000`.
String fullNaira(int value) => '₦${groupNaira(value)}';
