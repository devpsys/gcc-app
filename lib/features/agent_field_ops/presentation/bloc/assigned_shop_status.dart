/// Where a shop on the agent's route stands.
///
/// The design's tones are load-bearing and are shared with the map screen:
/// verified and synced are success, queued is info, needs attention is
/// warning, and not-started is deliberately muted — it is not a problem, just
/// not begun.
///
/// Nothing here is ever amber-and-locked: a work list is not a wallet, and the
/// design states that rule outright.
enum AssignedShopStatus { verified, queued, synced, needsAttention, notStarted }
