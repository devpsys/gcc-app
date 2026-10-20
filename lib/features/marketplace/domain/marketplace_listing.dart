import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_audit_clip.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_availability.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_spec.dart';

/// One piece of equipment a lessee can open from browse.
class MarketplaceListing extends Equatable {
  const MarketplaceListing({
    required this.id,
    required this.title,
    required this.yard,
    required this.market,
    required this.place,
    required this.category,
    required this.specification,
    required this.dailyRate,
    required this.deposit,
    required this.availability,
    required this.withOperator,
    this.thumbBadge,
    this.heroMark,
    this.heroTagline,
    this.unavailableUntil,
    this.verified = false,
    this.inBrowse = true,
    this.distance,
    this.deliveryFee = 0,
    this.operatorDailyFee = 0,
    this.photoCount = 1,
    this.videoCaption,
    this.specs = const [],
    this.included = const [],
    this.auditClips = const [],
    this.accessZone,
    this.access,
    this.similarIds = const [],
  });

  final String id;
  final String title;
  final String yard;
  final String market;
  final String place;
  final String category;
  final String specification;
  final int dailyRate;
  final int deposit;
  final MarketplaceAvailability availability;
  final bool withOperator;

  /// Mono label on the browse thumbnail, e.g. `100 kVA · 23`.
  final String? thumbBadge;

  /// Large mark on the listing hero, e.g. `MIKA 100`.
  final String? heroMark;
  final String? heroTagline;
  final String? unavailableUntil;
  final bool verified;

  /// When false, the listing is only opened from similar or a deep link.
  final bool inBrowse;
  final String? distance;
  final int deliveryFee;

  /// Daily fee when the lessee assigns a certified operator.
  final int operatorDailyFee;
  final int photoCount;
  final String? videoCaption;
  final List<MarketplaceSpec> specs;
  final List<String> included;
  final List<MarketplaceAuditClip> auditClips;
  final String? accessZone;
  final String? access;
  final List<String> similarIds;

  @override
  List<Object?> get props => [
    id,
    title,
    yard,
    market,
    place,
    category,
    specification,
    dailyRate,
    deposit,
    availability,
    withOperator,
    thumbBadge,
    heroMark,
    heroTagline,
    unavailableUntil,
    verified,
    inBrowse,
    distance,
    deliveryFee,
    operatorDailyFee,
    photoCount,
    videoCaption,
    specs,
    included,
    auditClips,
    accessZone,
    access,
    similarIds,
  ];
}
