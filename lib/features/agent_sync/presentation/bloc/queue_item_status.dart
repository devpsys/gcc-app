/// Where a queued submission currently is.
///
/// The design's colour rules are load-bearing: queued is **info**, uploading is
/// **warning**, failed is **danger**, synced is **success**. Nothing here is
/// ever amber-and-locked, because a pending bounty is not held funds.
enum QueueItemStatus { queued, uploading, synced, failed }
