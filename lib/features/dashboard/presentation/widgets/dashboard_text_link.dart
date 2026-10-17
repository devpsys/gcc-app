import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class DashboardTextLink extends StatelessWidget {
  const DashboardTextLink({
    required this.label,
    this.disabledReason,
    this.onPressed,
    this.chevron = false,
    this.color,
    this.underline = false,
    this.alignment = Alignment.centerLeft,
    super.key,
  });

  final String label;
  final String? disabledReason;
  final VoidCallback? onPressed;
  final bool chevron;
  final Color? color;
  final bool underline;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final foreground = color ?? scheme.primary;
    final button = TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foreground,
        disabledForegroundColor: foreground,
        minimumSize: const Size(0, AppDimensions.minTouchTarget),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: alignment,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final text = Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: underline
                ? const TextStyle(decoration: TextDecoration.underline)
                : null,
          );
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (constraints.maxWidth.isFinite)
                Flexible(child: text)
              else
                text,
              if (chevron)
                const Icon(Icons.chevron_right, size: AppDimensions.iconSm),
            ],
          );
        },
      ),
    );
    final reason = onPressed == null ? disabledReason : null;
    if (reason == null) {
      return Align(
        alignment: alignment,
        widthFactor: 1,
        heightFactor: 1,
        child: button,
      );
    }
    return Tooltip(
      message: reason,
      child: Align(
        alignment: alignment,
        widthFactor: 1,
        heightFactor: 1,
        child: button,
      ),
    );
  }
}
