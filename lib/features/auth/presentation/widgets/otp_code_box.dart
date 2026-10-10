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
    final emphasized = focused || hasError || filled;
    return ExcludeSemantics(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: focused ? scheme.primaryContainer : scheme.surface,
          borderRadius: BorderRadius.circular(AppRadii.input),
          border: Border.all(
            color: hasError
                ? scheme.error
                : emphasized
                ? scheme.primary
                : scheme.outline,
            width: emphasized
                ? AppDimensions.focusBorderWidth
                : AppDimensions.borderWidth,
          ),
        ),
        child: SizedBox(
          height: AppDimensions.inputHeight,
          child: Center(
            child: Text(
              digit,
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.titleLarge!,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
