/// Whether one timeline step has happened, failed, or never will.
///
/// The designs make this a three-way distinction, not a two-way one: a rejected
/// step is a failure the agent can act on, a not-applicable step never will
/// apply at all, and only a pending step is still in progress.
enum AuditEventState {
  /// It happened.
  done,

  /// It has not happened yet.
  pending,

  /// It happened and failed.
  rejected,

  /// It will never apply — the bounty was forfeited.
  notApplicable,
}
