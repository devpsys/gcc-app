/// How far the map sheet is dragged up.
///
/// Half shows the nearby shops; full reveals the filters. Two stops only — a
/// continuous drag would make the filter row's position unpredictable.
enum MapSheetDetent {
  /// The sheet covers roughly the lower third of the map.
  half,

  /// The sheet covers all but a peek of the map.
  full,
}
