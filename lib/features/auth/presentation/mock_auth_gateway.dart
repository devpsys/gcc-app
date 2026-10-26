import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/presentation/auth_gateway.dart';
import 'package:gcc_app/features/auth/presentation/bloc/auth_identifier_validator.dart';

/// Local stand-in for MOB-AUTH-UNIFIED until an auth API exists.
///
/// Known IDs match app mocks; unknown IDs surface Frame 03 recovery.
final class MockAuthGateway implements AuthGateway {
  static const String sampleMaskedPhone = '+234 •••• 2290';

  static const Set<String> knownIdentifiers = {
    'AG-0142',
    'VND-0341',
    'LSE-0847',
  };

  @override
  Future<String> requestVerificationCode(String identifier) async {
    final id = AuthIdentifierValidator.normalize(identifier);
    if (!AuthIdentifierValidator.isValid(id) || !knownIdentifiers.contains(id)) {
      throw const ValidationFailure(fieldErrors: {'identifier': []});
    }
    return sampleMaskedPhone;
  }

  @override
  Future<void> verifyCode(String identifier, String code) async {
    final id = AuthIdentifierValidator.normalize(identifier);
    if (!knownIdentifiers.contains(id)) {
      throw const ValidationFailure(fieldErrors: {'identifier': []});
    }
    if (code.length != 6) {
      throw const ValidationFailure(fieldErrors: {'code': []});
    }
  }
}
