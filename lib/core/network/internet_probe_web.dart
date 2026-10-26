/// Web has no [InternetAddress] DNS probe; trust the browser online bit.
Future<bool> probeInternet({
  Duration timeout = const Duration(seconds: 2),
}) async {
  return true;
}
