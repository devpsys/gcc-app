import 'dart:async';

import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_gateway.dart';

class FakeOnboardingGateway implements OnboardingGateway {
  Failure? requestFailure;
  Completer<void>? requestGate;
  int requestCount = 0;
  int verifyCount = 0;

  @override
  Future<void> requestSignInCode(String phoneNumber) async {
    requestCount += 1;
    final gate = requestGate;
    if (gate != null) {
      await gate.future;
    }
    final failure = requestFailure;
    if (failure != null) {
      throw failure;
    }
  }

  @override
  Future<void> verifySignInCode(String phoneNumber, String code) async {
    verifyCount += 1;
  }
}
