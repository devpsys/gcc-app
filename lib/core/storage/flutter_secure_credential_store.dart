import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gcc_app/core/constants/storage_keys.dart';
import 'package:gcc_app/core/error/exceptions.dart';
import 'package:gcc_app/core/storage/secure_credential_store.dart';

class FlutterSecureCredentialStore implements SecureCredentialStore {
  FlutterSecureCredentialStore(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<String?> readAccessToken() {
    return _read(StorageKeys.accessToken);
  }

  @override
  Future<void> writeAccessToken(String token) {
    return _write(StorageKeys.accessToken, token);
  }

  @override
  Future<String?> readRefreshToken() {
    return _read(StorageKeys.refreshToken);
  }

  @override
  Future<void> writeRefreshToken(String token) {
    return _write(StorageKeys.refreshToken, token);
  }

  @override
  Future<void> clear() async {
    try {
      await _storage.delete(key: StorageKeys.accessToken);
      await _storage.delete(key: StorageKeys.refreshToken);
    } on PlatformException catch (error) {
      throw CacheException(error);
    }
  }

  Future<String?> _read(String key) async {
    try {
      return await _storage.read(key: key);
    } on PlatformException catch (error) {
      throw CacheException(error);
    }
  }

  Future<void> _write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } on PlatformException catch (error) {
      throw CacheException(error);
    }
  }
}
