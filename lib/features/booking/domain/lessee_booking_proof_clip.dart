import 'package:equatable/equatable.dart';

/// Check-out or check-in proof clip on booking detail.
class LesseeBookingProofClip extends Equatable {
  const LesseeBookingProofClip({
    required this.title,
    required this.subtitle,
    required this.durationLabel,
  });

  final String title;
  final String subtitle;
  final String durationLabel;

  @override
  List<Object?> get props => [title, subtitle, durationLabel];
}
