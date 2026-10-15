import 'dart:async';

import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_draft.dart';
import 'package:gcc_app/features/agent_capture/presentation/gateway/capture_gateway.dart';

class FakeCaptureGateway implements CaptureGateway {
  int submits = 0;
  Future<void>? pending;
  Failure? failure;

  @override
  Future<void> discardSubmission(String reference) async {}

  @override
  Future<void> submitDraft(CaptureDraft draft) {
    submits += 1;
    final error = failure;
    if (error != null) {
      throw error;
    }
    return pending ?? Future<void>.value();
  }
}
