import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice_filter.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice_mark.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice_piece.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice_tone.dart';

/// One vendor notification. Titles and amounts are the notice itself.
class VendorNotice extends Equatable {
  const VendorNotice({
    required this.id,
    required this.inAll,
    required this.inRequests,
    required this.inMoney,
    required this.tone,
    required this.mark,
    required this.title,
    required this.detail,
    required this.time,
    required this.group,
    this.timeDay,
    this.sms = false,
    this.unread = false,
    this.needsDecision = false,
    this.decisionDeadline,
    this.opensRequests = false,
  });

  final String id;
  final bool inAll;
  final bool inRequests;
  final bool inMoney;
  final VendorNoticeTone tone;
  final VendorNoticeMark mark;
  final bool sms;
  final String title;
  final List<VendorNoticePiece> detail;
  final String time;
  final String? timeDay;
  final String group;
  final bool unread;
  final bool needsDecision;
  final String? decisionDeadline;
  final bool opensRequests;

  bool shownIn(VendorNoticeFilter filter) {
    return switch (filter) {
      VendorNoticeFilter.all => inAll,
      VendorNoticeFilter.requests => inRequests,
      VendorNoticeFilter.money => inMoney,
    };
  }

  VendorNotice copyWith({bool? unread}) {
    return VendorNotice(
      id: id,
      inAll: inAll,
      inRequests: inRequests,
      inMoney: inMoney,
      tone: tone,
      mark: mark,
      sms: sms,
      title: title,
      detail: detail,
      time: time,
      timeDay: timeDay,
      group: group,
      unread: unread ?? this.unread,
      needsDecision: needsDecision,
      decisionDeadline: decisionDeadline,
      opensRequests: opensRequests,
    );
  }

  @override
  List<Object?> get props => [
    id,
    inAll,
    inRequests,
    inMoney,
    tone,
    mark,
    sms,
    title,
    detail,
    time,
    timeDay,
    group,
    unread,
    needsDecision,
    decisionDeadline,
    opensRequests,
  ];
}
