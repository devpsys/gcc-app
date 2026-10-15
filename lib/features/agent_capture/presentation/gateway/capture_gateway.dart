import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_draft.dart';

abstract interface class CaptureGateway {
  Future<void> submitDraft(CaptureDraft draft);

  Future<void> discardSubmission(String reference);
}
