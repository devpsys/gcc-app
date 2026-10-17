/// Which of the camera step's four design frames is on screen.
enum CameraStageState {
  /// Viewfinder ready to shoot.
  idle,

  /// A 30 second condition clip is running.
  recording,

  /// The agent has denied camera access.
  permissionDenied,

  /// A clip stopped short of the minimum length and cannot be audited.
  failed,
}
