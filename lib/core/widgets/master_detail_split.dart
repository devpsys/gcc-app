import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_breakpoints.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';

/// Compact: [master] fills the body. Tablet+: [master] at
/// [AppDimensions.masterPaneWidth] beside [detail].
class MasterDetailSplit extends StatelessWidget {
  const MasterDetailSplit({
    required this.master,
    required this.detail,
    super.key,
  });

  final Widget master;
  final Widget detail;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!AppBreakpoints.isTablet(constraints.maxWidth)) {
          return master;
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: AppDimensions.masterPaneWidth,
              child: master,
            ),
            const VerticalDivider(width: AppDimensions.borderWidth),
            Expanded(child: detail),
          ],
        );
      },
    );
  }
}
