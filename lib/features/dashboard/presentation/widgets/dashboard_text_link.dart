import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class DashboardTextLink extends StatelessWidget {
  const DashboardTextLink({
    required this.label,
    required this.disabledReason,
    this.chevron = false,
    this.color,
    this.underline = false,
    this.alignment = Alignment.centerLeft,
    super.key,
  });

  final String label;
  final String disabledReason;
  final bool chevron;
  final Color? color;
  final bool underline;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final foreground = color ?? scheme.primary;
    final button = TextButton(
      onPressed: null,
      style: TextButton.styleFrom(
        foregroundColor: foreground,
        disabledForegroundColor: foreground,
        minimumSize: const Size(0, AppDimensions.minTouchTarget),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: alignment,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label,
              style: underline
                  ? const TextStyle(decoration: TextDecoration.underline)
                  : null,
            ),
          ),
          if (chevron)
            const Icon(Icons.chevron_right, size: AppDimensions.iconSm),
        ],
      ),
    );
    return Tooltip(
      message: disabledReason,
      child: Align(
        alignment: alignment,
        widthFactor: 1,
        heightFactor: 1,
        child: button,
      ),
    );
  }
}
