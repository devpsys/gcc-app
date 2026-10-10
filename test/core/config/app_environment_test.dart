import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/config/app_environment.dart';

void main() {
  test('parses known environment names', () {
    expect(AppEnvironment.parse('development'), AppEnvironment.development);
    expect(AppEnvironment.parse(' staging '), AppEnvironment.staging);
    expect(AppEnvironment.parse('production'), AppEnvironment.production);
  });

  test('rejects an unknown environment name', () {
    expect(() => AppEnvironment.parse('qa'), throwsArgumentError);
  });
}
