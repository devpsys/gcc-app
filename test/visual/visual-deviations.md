# Visual deviations

Geometry and widget tests are the gate for these screens. A golden
screenshot harness that calls `toImage()` hangs once a field has a blinking
cursor, so it is not run in CI.

Reviewed against the mobile designs:

- The location step keeps the card stepper from shop step 1. The location
  HTML's thin progress bars are not used.
- Device status-bar chrome in the HTML is not drawn.
- Held-funds amber is only used for money GCC is holding. Pending bounty,
  queued uploads, and maintenance use other tones.
- Scan QR is disabled, with the reason that it is not available yet. There is
  no scanner package.
- The email span on the phone step opens agent sign-in and says so. There is
  no email flow.
- Map pins are layout offsets from sample data. There is no tile projection.
- Camera, GPS, and compression controls are decorative until those SDKs exist.
