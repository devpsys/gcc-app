import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/booking/domain/handback_phase.dart';
import 'package:gcc_app/features/booking/domain/handback_review.dart';
import 'package:gcc_app/features/booking/domain/handback_settlement.dart';

sealed class HandbackState extends Equatable {
  const HandbackState();
}

final class HandbackLoading extends HandbackState {
  const HandbackLoading();

  @override
  List<Object?> get props => [];
}

final class HandbackFailed extends HandbackState {
  const HandbackFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class HandbackMissing extends HandbackState {
  const HandbackMissing();

  @override
  List<Object?> get props => [];
}

final class HandbackReady extends HandbackState {
  const HandbackReady({
    required this.review,
    required this.phase,
    required this.videoWatched,
    required this.confirmedWatched,
    this.settlement,
    this.approving = false,
  });

  final HandbackReview review;
  final HandbackPhase phase;
  final bool videoWatched;
  final bool confirmedWatched;
  final HandbackSettlement? settlement;
  final bool approving;

  bool get canApprove =>
      phase == HandbackPhase.review && videoWatched && confirmedWatched;

  HandbackReady copyWith({
    HandbackPhase? phase,
    bool? videoWatched,
    bool? confirmedWatched,
    HandbackSettlement? settlement,
    bool? approving,
  }) {
    return HandbackReady(
      review: review,
      phase: phase ?? this.phase,
      videoWatched: videoWatched ?? this.videoWatched,
      confirmedWatched: confirmedWatched ?? this.confirmedWatched,
      settlement: settlement ?? this.settlement,
      approving: approving ?? this.approving,
    );
  }

  @override
  List<Object?> get props => [
    review,
    phase,
    videoWatched,
    confirmedWatched,
    settlement,
    approving,
  ];
}
