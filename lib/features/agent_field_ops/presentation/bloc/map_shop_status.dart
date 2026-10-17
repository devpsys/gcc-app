/// What the map knows about a pinned shop.
///
/// Verified and synced are success, queued is info, and a lead is deliberately
/// neutral — it is unverified ground, not a problem to flag.
enum MapShopStatus { verified, queued, synced, lead }
