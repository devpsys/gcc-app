import 'package:gcc_app/features/auth/domain/auth_role.dart';

/// Prefix-aware ID rules for MOB-AUTH-UNIFIED (AG- / VND- / LSE- + 4 digits).
abstract final class AuthIdentifierValidator {
  static const int maxLength = 8;

  static final RegExp agentPattern = RegExp(r'^AG-\d{4}$');
  static final RegExp vendorPattern = RegExp(r'^VND-\d{4}$');
  static final RegExp lesseePattern = RegExp(r'^LSE-\d{4}$');

  static bool isEmpty(String value) => value.trim().isEmpty;

  static String normalize(String value) => value.trim().toUpperCase();

  static bool isValidForRole(String value, AuthRole role) {
    final id = normalize(value);
    return switch (role) {
      AuthRole.agent => agentPattern.hasMatch(id),
      AuthRole.vendor => vendorPattern.hasMatch(id),
      AuthRole.lessee => lesseePattern.hasMatch(id),
    };
  }

  static bool isValid(String value) {
    final id = normalize(value);
    return agentPattern.hasMatch(id) ||
        vendorPattern.hasMatch(id) ||
        lesseePattern.hasMatch(id);
  }

  static AuthRole? roleFromIdentifier(String value) {
    final id = normalize(value);
    if (agentPattern.hasMatch(id)) {
      return AuthRole.agent;
    }
    if (vendorPattern.hasMatch(id)) {
      return AuthRole.vendor;
    }
    if (lesseePattern.hasMatch(id)) {
      return AuthRole.lessee;
    }
    return null;
  }

  static String prefixForRole(AuthRole role) {
    return switch (role) {
      AuthRole.agent => 'AG-',
      AuthRole.vendor => 'VND-',
      AuthRole.lessee => 'LSE-',
    };
  }

  static String hintForRole(AuthRole role) {
    return switch (role) {
      AuthRole.agent => 'AG-0142',
      AuthRole.vendor => 'VND-0341',
      AuthRole.lessee => 'LSE-0847',
    };
  }
}
