import 'package:gcc_app/core/error/exceptions.dart';

final class BiometricBundle {
  const BiometricBundle({required this.accessToken, this.refreshToken});

  final String accessToken;
  final String? refreshToken;
}

abstract interface class BiometricSecretStore {
  Future<void> write(BiometricBundle bundle);

  Future<BiometricBundle> read();

  Future<void> delete();
}

/// Bundle stand-in for tests and web, where the keychain gate does not exist.
final class MemoryBiometricSecretStore implements BiometricSecretStore {
  BiometricBundle? bundle;
  AppException? writeError;
  AppException? readError;

  @override
  Future<void> write(BiometricBundle value) async {
    final error = writeError;
    if (error != null) {
      throw error;
    }
    bundle = value;
  }

  @override
  Future<BiometricBundle> read() async {
    final error = readError;
    if (error != null) {
      throw error;
    }
    final stored = bundle;
    if (stored == null) {
      throw const BiometricEnrollmentLostException();
    }
    return stored;
  }

  @override
  Future<void> delete() async {
    bundle = null;
  }
}
