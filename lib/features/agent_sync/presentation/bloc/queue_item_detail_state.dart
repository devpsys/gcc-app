/// Which of the four design frames a queue item is showing.
enum QueueItemDetailState {
  /// The upload timed out and can be retried.
  failed,

  /// It reached the server and is awaiting verification.
  synced,

  /// Another agent mapped the same shop first.
  conflict,

  /// The agent discarded their copy; terminal.
  discarded,
}
