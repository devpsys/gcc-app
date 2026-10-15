import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/widgets/sync_status_banner.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_section_id.dart';

typedef DashboardStop = ({
  String distance,
  String route,
  String name,
  String address,
  String coordinates,
});

typedef DashboardShop = ({
  String position,
  String name,
  String place,
  String status,
});

typedef DashboardSubmission = ({
  String name,
  String detail,
  String status,
  String? amount,
});

typedef DashboardRental = ({
  String reference,
  String title,
  String location,
  bool released,
  String returnBy,
  String remaining,
  String depositAmount,
  String releasedDetail,
});

typedef DashboardEquipment = ({
  String title,
  String place,
  String specification,
  bool available,
  String availability,
  String price,
});

typedef DashboardOrder = ({
  String reference,
  String title,
  String status,
  String amount,
  bool complete,
});

typedef DashboardRequests = ({
  int count,
  String countdown,
  String headline,
  String reference,
  String customer,
  String amount,
});

typedef DashboardAttention = ({
  String title,
  String detail,
  String status,
  String tone,
});

typedef DashboardFleet = ({
  int ready,
  int rented,
  int maintenance,
  int listed,
  int pendingVerification,
  List<DashboardAttention> attention,
});

typedef DashboardEarnings = ({
  String available,
  String awaitingCheck,
  String cautionDeposits,
});

typedef DashboardBooking = ({
  String reference,
  String title,
  String status,
  String detail,
});

typedef DashboardDispute = ({
  String reference,
  String bookingReference,
  String detail,
});

final class DashboardSnapshot extends Equatable {
  const DashboardSnapshot({
    this.place,
    this.agentName,
    this.assignment,
    this.agentId,
    this.syncKind,
    this.syncDetail,
    this.progressAssigned = 0,
    this.progressCaptured = 0,
    this.progressTarget = 0,
    this.pendingBounty,
    this.nextStop,
    this.shops = const [],
    this.submissions = const [],
    this.bountyPending,
    this.bountyPendingCaption,
    this.bountyEarned,
    this.bountyEarnedCaption,
    this.rental,
    this.equipment = const [],
    this.orders = const [],
    this.requests,
    this.fleet,
    this.earnings,
    this.bookings = const [],
    this.dispute,
    this.failedSection,
    this.filterCount = 0,
    this.navBadge = 0,
    this.lastRental,
    this.earningsNote,
    this.lastAnswered,
  });

  final String? place;
  final String? agentName;
  final String? assignment;
  final String? agentId;
  final SyncBannerKind? syncKind;
  final String? syncDetail;
  final int progressAssigned;
  final int progressCaptured;
  final int progressTarget;
  final String? pendingBounty;
  final DashboardStop? nextStop;
  final List<DashboardShop> shops;
  final List<DashboardSubmission> submissions;
  final String? bountyPending;
  final String? bountyPendingCaption;
  final String? bountyEarned;
  final String? bountyEarnedCaption;
  final DashboardRental? rental;
  final List<DashboardEquipment> equipment;
  final List<DashboardOrder> orders;
  final DashboardRequests? requests;
  final DashboardFleet? fleet;
  final DashboardEarnings? earnings;
  final List<DashboardBooking> bookings;
  final DashboardDispute? dispute;
  final DashboardSectionId? failedSection;
  final int filterCount;
  final int navBadge;
  final String? lastRental;
  final String? earningsNote;
  final String? lastAnswered;

  @override
  List<Object?> get props => [
    place,
    agentName,
    assignment,
    agentId,
    syncKind,
    syncDetail,
    progressAssigned,
    progressCaptured,
    progressTarget,
    pendingBounty,
    nextStop,
    shops,
    submissions,
    bountyPending,
    bountyPendingCaption,
    bountyEarned,
    bountyEarnedCaption,
    rental,
    equipment,
    orders,
    requests,
    fleet,
    earnings,
    bookings,
    dispute,
    failedSection,
    filterCount,
    navBadge,
    lastRental,
    earningsNote,
    lastAnswered,
  ];
}
