import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';

class DashboardThumb extends StatelessWidget {
  const DashboardThumb({
    this.size = AppDimensions.skeletonThumb,
    this.tinted = false,
    super.key,
  });

  final double size;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: tinted
            ? scheme.secondaryContainer
            : scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadii.input),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: SizedBox.square(dimension: size),
    );
  }
}
