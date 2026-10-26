import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_button_styles.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/widgets/app_button_frame.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.label,
    this.onPressed,
    this.icon,
    this.disabledReason,
    this.expand = true,
    this.busy = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final String? disabledReason;
  final bool expand;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final style = AppButtonStyles.primary(Theme.of(context).colorScheme);
    final glyph = icon;
    final pressed = busy ? null : onPressed;
    final child = busy
        ? Semantics(
            label: label,
            child: const SizedBox(
              width: AppDimensions.iconMd,
              height: AppDimensions.iconMd,
              child: CircularProgressIndicator(
                strokeWidth: AppDimensions.emphasisBorderWidth,
              ),
            ),
          )
        : Text(label);
    return AppButtonFrame(
      expand: expand,
      disabledReason: pressed == null && !busy ? disabledReason : null,
      button: glyph == null
          ? FilledButton(onPressed: pressed, style: style, child: child)
          : FilledButton.icon(
              onPressed: pressed,
              style: style,
              icon: Icon(glyph, size: AppDimensions.iconMd),
              iconAlignment: IconAlignment.end,
              label: child,
            ),
    );
  }
}
