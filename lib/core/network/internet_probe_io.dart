import 'dart:async';
import 'dart:io';

/// DNS probe used when a network interface looks active.
///
/// [connectivity_plus] only reports interface presence. Airplane mode and
/// captive portals can still look "connected" until a real lookup fails.
Future<bool> probeInternet({
  Duration timeout = const Duration(seconds: 2),
}) async {
  try {
    final results = await InternetAddress.lookup(
      'one.one.one.one',
    ).timeout(timeout);
    return results.any((address) => address.rawAddress.isNotEmpty);
  } on SocketException {
    return false;
  } on TimeoutException {
    return false;
  } on OSError {
    return false;
  }
}
