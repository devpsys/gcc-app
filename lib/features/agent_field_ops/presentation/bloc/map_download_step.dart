/// One line of the map-download progress list.
///
/// The design shows the work itemised — tiles, vectors, boundaries — because an
/// agent standing on a street corner needs to know this will finish, not just
/// that something is happening.
enum MapDownloadStep {
  /// A raster tile has arrived.
  tile,

  /// Vector data for a tile is being fetched.
  vectors,

  /// The market boundary is being traced.
  boundary,

  /// Finished tiles are being written to the cache.
  sync,
}
