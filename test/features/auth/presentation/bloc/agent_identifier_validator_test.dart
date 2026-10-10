import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_identifier_validator.dart';

void main() {
  test('accepts an agent ID of AG- and four digits', () {
    expect(AgentIdentifierValidator.isValid('AG-0142'), isTrue);
    expect(AgentIdentifierValidator.isValid('ag-0142'), isTrue);
  });

  test('rejects empty, short, and over-long identifiers', () {
    expect(AgentIdentifierValidator.isEmpty('  '), isTrue);
    expect(AgentIdentifierValidator.isValid(''), isFalse);
    expect(AgentIdentifierValidator.isValid('AG-12'), isFalse);
    expect(AgentIdentifierValidator.isValid('AG-01420'), isFalse);
    expect(AgentIdentifierValidator.isValid('GX-0142'), isFalse);
  });
}
