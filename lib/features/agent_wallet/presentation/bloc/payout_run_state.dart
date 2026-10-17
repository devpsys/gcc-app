/// Whether a payout run has happened yet.
enum PayoutRunState {
  /// Already paid out.
  paid,

  /// Still collecting, closes before the next Monday.
  open,
}
