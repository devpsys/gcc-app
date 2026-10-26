import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

class OtpCodeBox extends StatelessWidget {
  const OtpCodeBox({
    required this.digit,
    required this.filled,
    required this.focused,
    required this.hasError,
    super.key,
  });

  final String digit;
  final bool filled;
  final bool focused;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final Color background;
    final Color border;
    final double borderWidth;
    if (hasError) {
      background = scheme.errorContainer;
      border = scheme.error;
      borderWidth = AppDimensions.focusBorderWidth;
    } else if (focused) {
      background = scheme.surface;
      border = scheme.primary;
      borderWidth = AppDimensions.accentBorderWidth;
    } else if (filled) {
      background = scheme.secondaryContainer.withValues(alpha: 0.55);
      border = scheme.primary;
      borderWidth = AppDimensions.emphasisBorderWidth;
    } else {
      background = scheme.surfaceContainerHighest.withValues(alpha: 0.55);
      border = scheme.outlineVariant;
      borderWidth = AppDimensions.borderWidth;
    }
    return ExcludeSemantics(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AppRadii.button),
          border: Border.all(color: border, width: borderWidth),
          boxShadow: focused
              ? [
                  BoxShadow(
                    color: scheme.primary.withValues(alpha: 0.18),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: SizedBox(
          width: AppDimensions.otpCellWidth,
          height: AppDimensions.otpCellHeight,
          child: Center(
            child: Text(
              digit,
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: filled || focused
                      ? scheme.primary
                      : scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
