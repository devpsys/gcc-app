import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:gcc_app/app.dart';
import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/widgets/startup_failure_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await configureDependencies();
    runApp(const GccApp());
  } catch (error, stackTrace) {
    log(
      'Startup failed',
      name: 'gcc-app',
      error: error,
      stackTrace: stackTrace,
    );
    runApp(const StartupFailureApp());
  }
}
