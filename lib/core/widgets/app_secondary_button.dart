import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_button_styles.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/widgets/app_button_frame.dart';

class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    required this.label,
    this.onPressed,
    this.icon,
    this.disabledReason,
    this.expand = true,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final String? disabledReason;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final style = AppButtonStyles.secondary(Theme.of(context).colorScheme);
    final glyph = icon;
    final child = Text(label);
    return AppButtonFrame(
      expand: expand,
      disabledReason: onPressed == null ? disabledReason : null,
      button: glyph == null
          ? OutlinedButton(onPressed: onPressed, style: style, child: child)
          : OutlinedButton.icon(
              onPressed: onPressed,
              style: style,
              icon: Icon(glyph, size: AppDimensions.iconMd),
              label: child,
            ),
    );
  }
}
