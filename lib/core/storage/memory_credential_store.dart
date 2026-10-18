import 'package:gcc_app/core/storage/secure_credential_store.dart';

/// In-memory working tokens for tests. Production uses the platform keystore.
class MemoryCredentialStore implements SecureCredentialStore {
  String? _access;
  String? _refresh;

  @override
  Future<String?> readAccessToken() async => _access;

  @override
  Future<void> writeAccessToken(String token) async {
    _access = token;
  }

  @override
  Future<String?> readRefreshToken() async => _refresh;

  @override
  Future<void> writeRefreshToken(String token) async {
    _refresh = token;
  }

  @override
  Future<void> clear() async {
    _access = null;
    _refresh = null;
  }
}
