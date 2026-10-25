import 'package:equatable/equatable.dart';

/// Signed-in lessee account (MOB-LSE-17).
class LesseeProfile extends Equatable {
  const LesseeProfile({
    required this.initials,
    required this.name,
    required this.greetingName,
    required this.reference,
    required this.kind,
    required this.place,
    required this.memberSince,
    required this.bookingCount,
    required this.completedCount,
    required this.activeBookings,
    required this.savedCards,
    required this.notificationSummary,
    required this.deviceModel,
    required this.devicePlatform,
    required this.appVersion,
    required this.offlineCapture,
    required this.supportPhone,
    required this.canSwitchToVendor,
  });

  final String initials;
  final String name;
  final String greetingName;
  final String reference;
  final String kind;
  final String place;
  final String memberSince;
  final int bookingCount;
  final int completedCount;
  final int activeBookings;
  final int savedCards;
  final String notificationSummary;
  final String deviceModel;
  final String devicePlatform;
  final String appVersion;
  final String offlineCapture;
  final String supportPhone;
  final bool canSwitchToVendor;

  @override
  List<Object?> get props => [
    initials,
    name,
    greetingName,
    reference,
    kind,
    place,
    memberSince,
    bookingCount,
    completedCount,
    activeBookings,
    savedCards,
    notificationSummary,
    deviceModel,
    devicePlatform,
    appVersion,
    offlineCapture,
    supportPhone,
    canSwitchToVendor,
  ];
}
