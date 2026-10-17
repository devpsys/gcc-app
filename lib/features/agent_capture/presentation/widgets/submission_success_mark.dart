import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';

/// The success mark at the top of the terminal screen.
class SubmissionSuccessMark extends StatelessWidget {
  const SubmissionSuccessMark({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.successContainer,
        shape: BoxShape.circle,
        border: Border.all(color: colors.success, width: 2),
      ),
      child: SizedBox.square(
        dimension: AppDimensions.emptyStateIcon,
        child: Icon(
          Icons.check,
          size: AppDimensions.iconLg * 1.5,
          color: colors.success,
        ),
      ),
    );
  }
}
