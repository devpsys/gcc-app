/// Which catalog an asset is routed into.
///
/// This is the routing decision described by the asset design's Section C:
/// a rental asset needs a daily rate, a caution deposit and micro-insurance,
/// while a bulk asset is requested by quantity. The vendor finalises pricing
/// after verification.
enum AssetAvailability {
  /// Appears in the rentals catalog.
  rentalOnly,

  /// Appears in the wholesale catalog.
  bulkOnly,

  /// Appears in both catalogs.
  both,
}
