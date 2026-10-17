import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/capture_field_shell.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/coordinate_input_formatter.dart';

/// One labelled coordinate field with a fixed direction block on the trailing
/// edge, so an agent never has to type a hemisphere.
class CoordinateField extends StatelessWidget {
  const CoordinateField({
    required this.label,
    required this.hint,
    required this.direction,
    required this.controller,
    required this.onChanged,
    this.errorText,
    super.key,
  });

  final String label;
  final String hint;

  /// Trailing direction block, e.g. `° N`.
  final String direction;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final error = errorText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xxs),
            child: Text(
              error,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        const SizedBox(height: AppSpacing.tight),
        SizedBox(
          height: AppDimensions.inputHeight,
          child: CaptureFieldShell(
            focused: false,
            error: error != null,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: true,
                    ),
                    inputFormatters: [CoordinateInputFormatter()],
                    style: theme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  height: AppDimensions.inputHeight,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                  alignment: Alignment.center,
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Text(
                    direction,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
