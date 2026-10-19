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

/// `35000` becomes `₦35,000`.
String fullNaira(int value) => '₦${groupNaira(value)}';
