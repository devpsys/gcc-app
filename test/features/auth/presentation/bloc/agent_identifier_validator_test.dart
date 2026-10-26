import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/presentation/bloc/auth_identifier_validator.dart';

void main() {
  test('accepts AG, VND, and LSE identifiers', () {
    expect(AuthIdentifierValidator.isValid('AG-0142'), isTrue);
    expect(AuthIdentifierValidator.isValid('ag-0142'), isTrue);
    expect(AuthIdentifierValidator.isValid('VND-0341'), isTrue);
    expect(AuthIdentifierValidator.isValid('LSE-0847'), isTrue);
  });

  test('rejects empty and malformed identifiers', () {
    expect(AuthIdentifierValidator.isEmpty('  '), isTrue);
    expect(AuthIdentifierValidator.isValid(''), isFalse);
    expect(AuthIdentifierValidator.isValid('AG-12'), isFalse);
    expect(AuthIdentifierValidator.isValid('AG-01420'), isFalse);
    expect(AuthIdentifierValidator.isValid('GX-0142'), isFalse);
  });

  test('validates against the selected role prefix', () {
    expect(
      AuthIdentifierValidator.isValidForRole('AG-0142', AuthRole.agent),
      isTrue,
    );
    expect(
      AuthIdentifierValidator.isValidForRole('VND-0341', AuthRole.agent),
      isFalse,
    );
    expect(
      AuthIdentifierValidator.isValidForRole('VND-0341', AuthRole.vendor),
      isTrue,
    );
    expect(
      AuthIdentifierValidator.isValidForRole('LSE-0847', AuthRole.lessee),
      isTrue,
    );
  });

  test('maps prefix to auth role', () {
    expect(
      AuthIdentifierValidator.roleFromIdentifier('AG-0142'),
      AuthRole.agent,
    );
    expect(
      AuthIdentifierValidator.roleFromIdentifier('VND-0341'),
      AuthRole.vendor,
    );
    expect(
      AuthIdentifierValidator.roleFromIdentifier('LSE-0847'),
      AuthRole.lessee,
    );
  });
}
