import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_breakpoints.dart';

void main() {
  test('classifies the product breakpoints', () {
    expect(AppBreakpoints.sizeFor(767), AppWindowSize.compact);
    expect(AppBreakpoints.sizeFor(768), AppWindowSize.medium);
    expect(AppBreakpoints.sizeFor(1023), AppWindowSize.medium);
    expect(AppBreakpoints.sizeFor(1024), AppWindowSize.expanded);
    expect(AppBreakpoints.sizeFor(1439), AppWindowSize.expanded);
    expect(AppBreakpoints.sizeFor(1440), AppWindowSize.large);
  });
}
