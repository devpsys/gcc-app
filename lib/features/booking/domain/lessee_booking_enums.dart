enum LesseeBookingTab { active, completed, cancelled }

enum LesseeBookingStatus {
  actionNeeded,
  inUse,
  outForDelivery,
  completed,
  cancelled,
}

enum LesseeBookingFilter {
  all,
  needsAction,
  generators,
  audio,
  recentCancelled,
  archivedCancelled,
}
