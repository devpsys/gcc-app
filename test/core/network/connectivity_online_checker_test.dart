import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/network/connectivity_online_checker.dart';

void main() {
  group('hasInternetTransport', () {
    test('is false for none, empty, or bluetooth-only', () {
      expect(ConnectivityOnlineChecker.hasInternetTransport(const []), isFalse);
      expect(
        ConnectivityOnlineChecker.hasInternetTransport(const [
          ConnectivityResult.none,
        ]),
        isFalse,
      );
      expect(
        ConnectivityOnlineChecker.hasInternetTransport(const [
          ConnectivityResult.bluetooth,
        ]),
        isFalse,
      );
    });

    test('is true for wifi, mobile, other, and mixed lists', () {
      expect(
        ConnectivityOnlineChecker.hasInternetTransport(const [
          ConnectivityResult.wifi,
        ]),
        isTrue,
      );
      expect(
        ConnectivityOnlineChecker.hasInternetTransport(const [
          ConnectivityResult.mobile,
        ]),
        isTrue,
      );
      expect(
        ConnectivityOnlineChecker.hasInternetTransport(const [
          ConnectivityResult.other,
        ]),
        isTrue,
      );
      expect(
        ConnectivityOnlineChecker.hasInternetTransport(const [
          ConnectivityResult.none,
          ConnectivityResult.wifi,
        ]),
        isTrue,
      );
    });
  });

  group('isOnlineFor', () {
    test('skips the probe when there is no transport', () async {
      var probed = false;
      final online = await ConnectivityOnlineChecker.isOnlineFor(
        const [ConnectivityResult.none],
        probe: () async {
          probed = true;
          return true;
        },
      );
      expect(online, isFalse);
      expect(probed, isFalse);
    });

    test('requires a successful probe when a transport is present', () async {
      expect(
        await ConnectivityOnlineChecker.isOnlineFor(
          const [ConnectivityResult.wifi],
          probe: () async => false,
        ),
        isFalse,
      );
      expect(
        await ConnectivityOnlineChecker.isOnlineFor(
          const [ConnectivityResult.other],
          probe: () async => true,
        ),
        isTrue,
      );
    });

    test('fails closed when the probe throws', () async {
      expect(
        await ConnectivityOnlineChecker.isOnlineFor(
          const [ConnectivityResult.wifi],
          probe: () async => throw StateError('dns down'),
        ),
        isFalse,
      );
    });
  });
}
