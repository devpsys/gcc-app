/// How far around the agent the map will show.
///
/// The labels live in l10n; this enum only names the radii, so the copy stays
/// translatable and a locale change cannot desynchronise the two.
enum MapRadius {
  /// The tightest radius.
  near,

  /// A comfortable walk.
  walkable,

  /// The wider neighbourhood.
  extended,

  /// Everything downloaded.
  wide,
}
