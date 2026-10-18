/// Whether secret storage is the platform keystore or an in-memory stand-in.
///
/// Widget tests pass a Hive directory and have no platform channel for
/// [FlutterSecureStorage] or biometric prompts. Production leaves [inMemory]
/// false.
final class StorageEnvironment {
  const StorageEnvironment({required this.inMemory});

  final bool inMemory;
}
