import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// A single 48 px text action inside the camera stage bar.
class CameraActionButton extends StatelessWidget {
  const CameraActionButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.minTouchTarget,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          minimumSize: const Size(0, AppDimensions.minTouchTarget),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.surface),
        ),
      ),
    );
  }
}
