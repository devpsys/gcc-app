/// How a single file stands.
enum QueueFileState {
  /// The upload failed for this file.
  failed,

  /// It is on the server.
  synced,

  /// It is still only on the device.
  notUploaded,
}
