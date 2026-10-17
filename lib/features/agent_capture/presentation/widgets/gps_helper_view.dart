/// The four states the GPS helper sheet can be opened in.
///
/// There is no location service wired up, so the sheet is driven by the view
/// its caller asks for rather than by live fixes. Real GPS integration is out
/// of scope for the presentation layer (see the implementation plan §13).
enum GpsHelperView {
  /// Fix is present but poor — the sheet explains how to improve it.
  signalWeak,

  /// Fix is good enough to submit against.
  fixAcquired,

  /// The agent has denied location access.
  permissionDenied,

  /// The agent is typing a latitude and longitude by hand.
  manualEntry,
}

/// What the agent chose in the GPS helper.
enum GpsHelperResult {
  /// The agent wants to retry acquiring a fix.
  retry,

  /// The agent is satisfied with the current accuracy.
  accept,

  /// The agent supplied a latitude and longitude by hand.
  useCoordinates,

  /// The agent chose to continue without a verified location.
  continueWithoutFix,
}
