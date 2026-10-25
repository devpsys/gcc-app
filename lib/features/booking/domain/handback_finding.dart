import 'package:equatable/equatable.dart';

/// A timestamped note the yard marked on the check-in clip.
class HandbackFinding extends Equatable {
  const HandbackFinding({required this.timeLabel, required this.note});

  final String timeLabel;
  final String note;

  @override
  List<Object?> get props => [timeLabel, note];
}
