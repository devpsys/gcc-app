import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

class AppButtonFrame extends StatelessWidget {
  const AppButtonFrame({
    required this.button,
    this.disabledReason,
    this.expand = true,
    super.key,
  });

  final Widget button;
  final String? disabledReason;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final framed = expand
        ? SizedBox(width: double.infinity, child: button)
        : button;
    final reason = disabledReason;
    if (reason == null) {
      return framed;
    }

    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        framed,
        const SizedBox(height: AppSpacing.xxs),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.info_outline,
              size: AppDimensions.iconSm,
              color: scheme.error,
            ),
            const SizedBox(width: AppSpacing.xxs),
            Expanded(
              child: Text(
                reason,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: AppTextStyles.eyebrowSize,
                  height:
                      AppTextStyles.eyebrowLineHeight /
                      AppTextStyles.eyebrowSize,
                  color: scheme.error,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
