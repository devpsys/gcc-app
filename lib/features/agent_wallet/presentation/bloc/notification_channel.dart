import 'package:equatable/equatable.dart';

/// One notification channel and what it carries.
class NotificationChannel extends Equatable {
  const NotificationChannel({
    required this.id,
    required this.detail,
    required this.enabled,
    required this.lastSentAt,
    required this.delivered,
  });

  /// e.g. `sms`.
  final String id;

  /// e.g. `Booking requests and verdicts`.
  final String detail;

  final bool enabled;

  /// e.g. `13 Oct, 11:08`. Blank when nothing has been sent.
  final String lastSentAt;

  /// Whether the last message reached the handset.
  final bool delivered;

  @override
  List<Object?> get props => [id, detail, enabled, lastSentAt, delivered];
}
