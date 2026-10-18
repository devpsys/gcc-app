import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/session_repository.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_gateway.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_language.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_role.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._gateway, this._session)
    : super(const OnboardingStarted());

  final OnboardingGateway _gateway;
  final SessionRepository _session;

  static const int phoneLength = 11;
  static const int codeLength = 6;

  bool get _busy => state is OnboardingSubmitting;

  void selectLanguage(OnboardingLanguage language) {
    if (_busy || !language.isAvailable) {
      return;
    }
    emit(OnboardingLanguageSelected(language: language));
  }

  void selectRole(OnboardingRole role) {
    if (_busy) {
      return;
    }
    final language = state.language;
    if (language == null) {
      return;
    }
    emit(OnboardingRoleSelected(language: language, role: role));
  }

  void phoneChanged(String value) {
    if (_busy) {
      return;
    }
    final language = state.language;
    final role = state.role;
    if (language == null || role == null) {
      return;
    }
    final digits = value.replaceAll(RegExp(r'\D'), '');
    final phone = digits.length > phoneLength
        ? digits.substring(0, phoneLength)
        : digits;
    emit(OnboardingSignInReady(language: language, role: role, phone: phone));
  }

  void clearPhone() {
    if (_busy) {
      return;
    }
    final language = state.language;
    final role = state.role;
    if (language == null || role == null) {
      return;
    }
    emit(OnboardingRoleSelected(language: language, role: role));
  }

  Future<void> requestCode() async {
    if (_busy) {
      return;
    }
    final language = state.language;
    final role = state.role;
    final phone = state.phone;
    if (language == null || role == null || phone.length != phoneLength) {
      return;
    }

    emit(
      OnboardingSubmitting(
        language: language,
        role: role,
        phone: phone,
        code: state.code,
      ),
    );
    try {
      await _gateway.requestSignInCode(phone);
      emit(
        OnboardingCodeRequested(language: language, role: role, phone: phone),
      );
    } on Failure catch (failure) {
      emit(
        OnboardingFailed(
          failure: failure,
          language: language,
          role: role,
          phone: phone,
        ),
      );
    }
  }

  void codeChanged(String code) {
    if (_busy) {
      return;
    }
    final current = state;
    if (current is! OnboardingCodeRequested && current is! OnboardingFailed) {
      return;
    }
    final language = current.language;
    final role = current.role;
    if (language == null || role == null) {
      return;
    }
    emit(
      OnboardingCodeRequested(
        language: language,
        role: role,
        phone: current.phone,
        code: code,
      ),
    );
  }

  Future<void> verifyCode(String code) async {
    if (_busy || code.length != codeLength) {
      return;
    }
    final language = state.language;
    final role = state.role;
    final phone = state.phone;
    if (language == null ||
        role == null ||
        phone.length != phoneLength ||
        state is! OnboardingCodeRequested && state is! OnboardingFailed) {
      return;
    }

    emit(
      OnboardingSubmitting(
        language: language,
        role: role,
        phone: phone,
        code: code,
      ),
    );
    try {
      await _gateway.verifySignInCode(phone, code);
      await _session.establish(_sessionRole(role));
      emit(
        OnboardingCompleted(
          language: language,
          role: role,
          phone: phone,
          code: code,
        ),
      );
    } on Failure catch (failure) {
      emit(
        OnboardingFailed(
          failure: failure,
          language: language,
          role: role,
          phone: phone,
          code: code,
        ),
      );
    }
  }
}

/// Listing equipment opens the vendor home. Renting and browsing open the
/// lessee home. Both need an unlocked session or the router sends `/` back
/// to the language screen.
AuthRole _sessionRole(OnboardingRole role) {
  return switch (role) {
    OnboardingRole.list => AuthRole.vendor,
    OnboardingRole.rent || OnboardingRole.browse => AuthRole.lessee,
  };
}
