import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_breakpoints.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

void main() {
  test('page gutters absorb from 16 to 20 at 390 then 24 at tablet', () {
    expect(AppSpacing.pageGutterFor(360), AppSpacing.pageGutterCompact);
    expect(
      AppSpacing.pageGutterFor(AppBreakpoints.comfortable),
      AppSpacing.pageGutterComfortable,
    );
    expect(
      AppSpacing.pageGutterFor(AppBreakpoints.medium),
      AppSpacing.pageGutterExpanded,
    );
  });
}
