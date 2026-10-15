/// The two appearances the agent designs draw for a segmented control.
///
/// Both are the same control; the capture wizard's shop-type picker and the
/// asset step's condition/availability pickers simply differ in the source
/// designs, and collapsing them into one widget keeps the tap and selection
/// behaviour identical.
enum AppSegmentStyle {
  /// Shop type (MOB-AGT-05): a 4 px-radius track with 6 px gutters and 40 px
  /// segments. The selection is a raised white tile with a 2 px brand edge.
  raised,

  /// Condition grade and availability (MOB-AGT-08): a 8 px-radius track with
  /// 4 px gutters and 48 px segments. The selection is a `brand-50` fill with
  /// a 1 px brand edge.
  filled,
}
