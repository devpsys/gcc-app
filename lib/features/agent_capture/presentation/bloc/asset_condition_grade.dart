/// Condition grade recorded against an asset at capture time.
///
/// Verification is what ultimately settles the grade; the agent records what
/// they can see on site.
enum AssetConditionGrade {
  /// Pristine, never deployed on-site.
  newCondition,

  /// Works as intended, normal wear.
  good,

  /// Works, but shows visible wear.
  fair,

  /// Has faults the vendor should fix.
  needsService,
}
