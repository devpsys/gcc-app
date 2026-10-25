import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/booking/domain/handback_issue_reason.dart';
import 'package:gcc_app/features/booking/domain/handback_phase.dart';
import 'package:gcc_app/features/booking/presentation/bloc/handback_state.dart';
import 'package:gcc_app/features/booking/presentation/gateway/handback_gateway.dart';

class HandbackCubit extends Cubit<HandbackState> {
  HandbackCubit(this._gateway, this.bookingId)
    : super(const HandbackLoading());

  final HandbackGateway _gateway;
  final String bookingId;

  Future<void> load() async {
    emit(const HandbackLoading());
    try {
      final review = await _gateway.load(bookingId);
      if (review == null) {
        emit(const HandbackMissing());
        return;
      }
      emit(
        HandbackReady(
          review: review,
          phase: HandbackPhase.review,
          videoWatched: false,
          confirmedWatched: false,
        ),
      );
    } on Failure catch (failure) {
      emit(HandbackFailed(failure));
    }
  }

  /// Mock play-through: tapping play marks the clip as fully watched.
  void completePlayback() {
    final ready = _ready;
    if (ready == null || ready.phase != HandbackPhase.review) {
      return;
    }
    emit(ready.copyWith(videoWatched: true));
  }

  void setConfirmedWatched(bool value) {
    final ready = _ready;
    if (ready == null || ready.phase != HandbackPhase.review) {
      return;
    }
    if (value && !ready.videoWatched) {
      return;
    }
    emit(ready.copyWith(confirmedWatched: value));
  }

  Future<void> approve() async {
    final ready = _ready;
    if (ready == null || !ready.canApprove || ready.approving) {
      return;
    }
    emit(ready.copyWith(approving: true));
    try {
      final settlement = await _gateway.approve(bookingId);
      emit(
        ready.copyWith(
          phase: HandbackPhase.approved,
          settlement: settlement,
          approving: false,
        ),
      );
    } on Failure catch (failure) {
      emit(HandbackFailed(failure));
    }
  }

  Future<void> submitIssue({
    required HandbackIssueReason reason,
    required String note,
    required int photoCount,
    required int claimAmount,
  }) {
    return _gateway.submitIssue(
      bookingId: bookingId,
      reason: reason,
      note: note,
      photoCount: photoCount,
      claimAmount: claimAmount,
    );
  }

  HandbackReady? get _ready => switch (state) {
    HandbackReady ready => ready,
    _ => null,
  };
}
