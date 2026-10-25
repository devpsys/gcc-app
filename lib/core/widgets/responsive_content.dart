import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class ResponsiveContent extends StatelessWidget {
  const ResponsiveContent({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final gutter = AppSpacing.pageGutterFor(constraints.maxWidth);
        final available = constraints.maxWidth.isFinite
            ? constraints.maxWidth - (gutter * 2)
            : AppDimensions.maxContentWidth;
        final width = math.max(
          0,
          math.min(available, AppDimensions.maxContentWidth),
        );

        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(gutter),
            child: SizedBox(width: width.toDouble(), child: child),
          ),
        );
      },
    );
  }
}
