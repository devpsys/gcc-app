import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_stage_tone.dart';

/// One audit-trail row on booking detail (MOB-VND-09).
class LesseeBookingTimelineEvent extends Equatable {
  const LesseeBookingTimelineEvent({
    required this.timeLabel,
    required this.title,
    required this.tone,
    this.detail,
    this.detailHighlight = false,
  });

  final String timeLabel;
  final String title;
  final LesseeBookingStageTone tone;
  final String? detail;
  final bool detailHighlight;

  @override
  List<Object?> get props => [
    timeLabel,
    title,
    tone,
    detail,
    detailHighlight,
  ];
}
