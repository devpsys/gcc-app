import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/capture_field_shell.dart';

class SpatialSelectorField extends StatelessWidget {
  const SpatialSelectorField({
    required this.label,
    required this.value,
    required this.hint,
    required this.onPressed,
    this.highlighted = false,
    this.error = false,
    this.errorText,
    super.key,
  });

  final String label;
  final String value;
  final String hint;
  final VoidCallback onPressed;
  final bool highlighted;

  /// Renders the field in the danger tone when a required selection is missing.
  final bool error;

  /// Message shown under the field when [error] is set.
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final chosen = value.trim();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: error ? scheme.error : scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        const SizedBox(height: AppSpacing.xxs),
        CaptureFieldShell(
          focused: highlighted,
          error: error,
          child: SizedBox(
            height: AppDimensions.inputHeight,
            child: InkWell(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        chosen.isEmpty ? hint : chosen,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: chosen.isEmpty
                              ? scheme.onSurfaceVariant
                              : highlighted
                              ? scheme.secondary
                              : scheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: AppDimensions.iconSm,
                      color: highlighted
                          ? scheme.primary
                          : scheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xxs),
            child: Text(
              errorText!,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.error, fontWeight: FontWeight.w500),
            ),
          ),
      ],
    );
  }
}
