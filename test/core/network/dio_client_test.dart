import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/error/exceptions.dart';
import 'package:gcc_app/core/network/dio_client.dart';
import 'package:gcc_app/core/storage/secure_credential_store.dart';

import '../../helpers/test_config.dart';

void main() {
  test('rejects requests when no API base URL is configured', () async {
    final dio = createDioClient(
      config: testConfig,
      credentials: _EmptyCredentialStore(),
    );

    await expectLater(
      dio.get<void>('/health'),
      throwsA(
        isA<DioException>().having(
          (error) => error.error,
          'error',
          isA<ConfigurationException>(),
        ),
      ),
    );
  });
}

class _EmptyCredentialStore implements SecureCredentialStore {
  @override
  Future<void> clear() async {}

  @override
  Future<String?> readAccessToken() async => null;

  @override
  Future<String?> readRefreshToken() async => null;

  @override
  Future<void> writeAccessToken(String token) async {}

  @override
  Future<void> writeRefreshToken(String token) async {}
}
