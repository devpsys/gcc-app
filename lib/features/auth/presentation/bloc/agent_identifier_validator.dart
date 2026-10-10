abstract final class AgentIdentifierValidator {
  static const int maxLength = 8;
  static final RegExp pattern = RegExp(r'^AG-\d{4}$');

  static bool isEmpty(String value) => value.trim().isEmpty;

  static bool isValid(String value) {
    return pattern.hasMatch(value.trim().toUpperCase());
  }
}
