/// Reports whether the device currently has a usable network path.
abstract interface class OnlineChecker {
  /// One-shot reachability check.
  Future<bool> check();

  /// Emits the latest online flag, including an initial value.
  Stream<bool> watch();
}
