import 'package:equatable/equatable.dart';

/// One check-out or check-in clip on the listing audit.
class MarketplaceAuditClip extends Equatable {
  const MarketplaceAuditClip({
    required this.time,
    required this.title,
    this.detail,
  });

  final String time;
  final String title;
  final String? detail;

  @override
  List<Object?> get props => [time, title, detail];
}
