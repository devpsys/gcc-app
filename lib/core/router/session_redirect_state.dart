import 'package:equatable/equatable.dart';

/// What the router needs to decide between onboarding, unlock, and a home.
///
/// Locations are already resolved paths. The router does not import a feature.
final class SessionRedirectState extends Equatable {
  const SessionRedirectState({
    required this.enrolled,
    required this.unlocked,
    this.homeLocation,
    this.signInLocation,
  });

  final bool enrolled;
  final bool unlocked;

  /// Where an unlocked session belongs. Null until a role has been stored.
  final String? homeLocation;

  /// Where a signed-out user with a known role should verify again.
  final String? signInLocation;

  @override
  List<Object?> get props => [enrolled, unlocked, homeLocation, signInLocation];
}
