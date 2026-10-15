import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_draft.dart';

sealed class CaptureState extends Equatable {
  const CaptureState(this.draft);

  final CaptureDraft draft;

  @override
  List<Object?> get props => [draft];
}

final class CaptureDrafting extends CaptureState {
  const CaptureDrafting([super.draft = const CaptureDraft()]);
}

final class CaptureSubmitting extends CaptureState {
  const CaptureSubmitting(super.draft);
}

final class CaptureSubmitted extends CaptureState {
  const CaptureSubmitted(super.draft);
}

final class CaptureFailed extends CaptureState {
  const CaptureFailed(super.draft, this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [draft, failure];
}
