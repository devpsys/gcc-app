/// Where one submission sits in the verification lifecycle.
///
/// The escrow treatment is derived from this, not chosen per widget: the
/// designs permit the amber lock and 45° hatch for **awaiting verification
/// only** — that is when the money is genuinely held at GCC. Verified means the
/// money has moved to the payout run, and rejected means it was never payable,
/// so neither is escrowed and neither may carry a lock.
enum BountyStatus {
  /// Uploaded and waiting on a reviewer. Funds are held: escrowed.
  awaitingVerification,

  /// A reviewer approved it. Funds join a payout run.
  verified,

  /// A reviewer refused it. The bounty is forfeited, not held.
  rejected,
}

/// Whether an amount is money GCC is holding on an agent's behalf.
///
/// Escrow is the only reason a lock glyph is permitted anywhere in the app, so
/// it lives here as a single question rather than being sprinkled through the
/// widgets as a boolean.
bool isEscrowed(BountyStatus status) =>
    status == BountyStatus.awaitingVerification;
