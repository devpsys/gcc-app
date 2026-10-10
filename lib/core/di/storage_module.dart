import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gcc_app/core/constants/storage_keys.dart';
import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/storage/flutter_secure_credential_store.dart';
import 'package:gcc_app/core/storage/secure_credential_store.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> registerStorageModule({String? storageDirectory}) async {
  if (storageDirectory == null) {
    await Hive.initFlutter();
  } else {
    Hive.init(storageDirectory);
  }

  final preferences = await Hive.openBox<String>(StorageKeys.preferencesBox);
  getIt
    ..registerSingleton<Box<String>>(preferences)
    ..registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(),
    )
    ..registerLazySingleton<SecureCredentialStore>(
      () => FlutterSecureCredentialStore(getIt()),
    );
}
