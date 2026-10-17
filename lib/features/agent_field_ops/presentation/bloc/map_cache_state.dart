/// Whether the device has map data for the current view.
enum MapCacheState {
  /// Tiles are on the device and usable offline.
  cached,

  /// Tiles are being fetched right now.
  refreshing,

  /// The view has no cached vector data at all.
  outside,
}
