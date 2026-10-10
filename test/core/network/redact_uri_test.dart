import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/network/redact_uri.dart';

void main() {
  test('removes sensitive query parameters', () {
    final uri = Uri.parse(
      'https://api.example.test/bookings?q=generator&token=secret&password=hidden',
    );

    expect(redactUri(uri), 'https://api.example.test/bookings?q=generator');
  });
}
