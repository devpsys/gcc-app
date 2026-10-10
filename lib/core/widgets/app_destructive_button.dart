import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_button_styles.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/widgets/app_button_frame.dart';

class AppDestructiveButton extends StatelessWidget {
  const AppDestructiveButton({
    required this.label,
    this.onPressed,
    this.icon,
    this.filled = false,
    this.disabledReason,
    this.expand = true,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool filled;
  final String? disabledReason;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = AppButtonStyles.destructive(scheme, filled: filled);
    final glyph = icon;
    final child = Text(label);
    return AppButtonFrame(
      expand: expand,
      disabledReason: onPressed == null ? disabledReason : null,
      button: glyph == null
          ? FilledButton(onPressed: onPressed, style: style, child: child)
          : FilledButton.icon(
              onPressed: onPressed,
              style: style,
              icon: Icon(glyph, size: AppDimensions.iconMd),
              label: child,
            ),
    );
  }
}
