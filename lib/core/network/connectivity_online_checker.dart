import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gcc_app/core/network/internet_probe.dart';
import 'package:gcc_app/core/network/online_checker.dart';

/// [OnlineChecker] using interface status plus a real reachability probe.
///
/// Interface-only checks are not enough: iOS/macOS [NWPathMonitor] can report
/// wifi/other while airplane mode (or a dead path) still blocks the internet.
/// We treat "no transport" as offline immediately, and otherwise confirm with
/// [probeInternet] (DNS on IO, trusted browser bit on web).
final class ConnectivityOnlineChecker implements OnlineChecker {
  ConnectivityOnlineChecker({
    Connectivity? connectivity,
    Future<bool> Function()? probe,
  }) : _connectivity = connectivity ?? Connectivity(),
       _probe = probe ?? probeInternet;

  final Connectivity _connectivity;
  final Future<bool> Function() _probe;

  static const _internetTransports = {
    ConnectivityResult.wifi,
    ConnectivityResult.mobile,
    ConnectivityResult.ethernet,
    ConnectivityResult.vpn,
    ConnectivityResult.other,
    ConnectivityResult.satellite,
  };

  @override
  Future<bool> check() async {
    try {
      final results = await _connectivity.checkConnectivity();
      return await isOnlineFor(results, probe: _probe);
    } catch (_) {
      return false;
    }
  }

  @override
  Stream<bool> watch() async* {
    yield await check();
    await for (final results in _connectivity.onConnectivityChanged) {
      try {
        yield await isOnlineFor(results, probe: _probe);
      } catch (_) {
        yield false;
      }
    }
  }

  /// Shared decision used by [check]/[watch] and unit tests.
  static Future<bool> isOnlineFor(
    List<ConnectivityResult> results, {
    required Future<bool> Function() probe,
  }) async {
    if (!hasInternetTransport(results)) {
      return false;
    }
    try {
      return await probe();
    } catch (_) {
      return false;
    }
  }

  static bool hasInternetTransport(List<ConnectivityResult> results) {
    if (results.isEmpty) {
      return false;
    }
    return results.any(_internetTransports.contains);
  }
}
