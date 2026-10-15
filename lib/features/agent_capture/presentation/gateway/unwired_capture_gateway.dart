import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_draft.dart';
import 'package:gcc_app/features/agent_capture/presentation/gateway/capture_gateway.dart';

final class UnwiredCaptureGateway implements CaptureGateway {
  const UnwiredCaptureGateway();

  @override
  Future<void> submitDraft(CaptureDraft draft) async {}

  @override
  Future<void> discardSubmission(String reference) async {}
}
