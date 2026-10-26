import 'dart:async';

import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/presentation/auth_gateway.dart';

class FakeAgentAuthGateway implements AuthGateway {
  Failure? requestFailure;
  Failure? verifyFailure;
  String maskedPhone = '+234 •••• 2290';
  Completer<void>? requestGate;
  int requestCount = 0;
  int verifyCount = 0;

  @override
  Future<String> requestVerificationCode(String identifier) async {
    requestCount += 1;
    final gate = requestGate;
    if (gate != null) {
      await gate.future;
    }
    final failure = requestFailure;
    if (failure != null) {
      throw failure;
    }
    return maskedPhone;
  }

  @override
  Future<void> verifyCode(String identifier, String code) async {
    verifyCount += 1;
    final failure = verifyFailure;
    if (failure != null) {
      throw failure;
    }
  }
}
