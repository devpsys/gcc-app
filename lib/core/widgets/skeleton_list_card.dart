import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class SkeletonListCard extends StatefulWidget {
  const SkeletonListCard({super.key});

  @override
  State<SkeletonListCard> createState() => _SkeletonListCardState();
}

class _SkeletonListCardState extends State<SkeletonListCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final pulse = _controller.value < 0.5
            ? _controller.value * 2
            : (1 - _controller.value) * 2;
        final color =
            Color.lerp(
              scheme.surfaceContainerHighest,
              scheme.outlineVariant,
              pulse,
            ) ??
            scheme.surfaceContainerHighest;
        return DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(color: context.semanticColors.border),
          ),
          child: SizedBox(
            height: AppDimensions.skeletonCardHeight,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xs),
              child: Row(
                children: [
                  _bar(
                    AppDimensions.skeletonThumb,
                    AppDimensions.skeletonThumb,
                    color,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FractionallySizedBox(
                          widthFactor: 0.6,
                          child: _bar(double.infinity, AppSpacing.sm, color),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        FractionallySizedBox(
                          widthFactor: 0.4,
                          child: _bar(double.infinity, AppSpacing.sm, color),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _bar(double width, double height, Color color) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppRadii.input),
        ),
      ),
    );
  }
}
