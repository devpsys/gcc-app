import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// A naira amount with a trailing unit, used for rates and the deposit.
class EditMoneyField extends StatefulWidget {
  const EditMoneyField({
    required this.label,
    required this.value,
    required this.generation,
    required this.suffix,
    required this.onChanged,
    this.errorText,
    this.held = false,
    super.key,
  });

  final String label;
  final String value;
  final int generation;
  final String suffix;
  final ValueChanged<String> onChanged;
  final String? errorText;
  final bool held;

  @override
  State<EditMoneyField> createState() => _EditMoneyFieldState();
}

class _EditMoneyFieldState extends State<EditMoneyField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.value,
  );

  @override
  void didUpdateWidget(EditMoneyField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.generation != oldWidget.generation &&
        _controller.text != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final error = widget.errorText;
    final borderColor = error != null ? scheme.error : colors.border;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.label,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            if (error != null)
              Text(
                context.l10n.editRequired,
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: scheme.error),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        DecoratedBox(
          decoration: BoxDecoration(
            color: widget.held ? colors.heldFundsContainer : scheme.surface,
            borderRadius: BorderRadius.circular(AppRadii.input),
            border: Border.all(
              color: widget.held ? colors.heldFunds : borderColor,
              width: error != null
                  ? AppDimensions.emphasisBorderWidth
                  : AppDimensions.borderWidth,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.input),
            child: CustomPaint(
              painter: widget.held ? const _EditHatchPainter() : null,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: AppDimensions.inputHeight,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: AppDimensions.minTouchTarget,
                      child: Center(
                        child: Text(
                          '₦',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9,]')),
                        ],
                        style: AppTextStyles.tabular(
                          Theme.of(context).textTheme.bodyLarge!,
                        ),
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          filled: false,
                        ),
                        onChanged: widget.onChanged,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                      ),
                      child: Text(
                        widget.suffix,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            error,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: scheme.error),
          ),
        ],
      ],
    );
  }
}

class _EditHatchPainter extends CustomPainter {
  const _EditHatchPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.escrowHatch
      ..strokeWidth = 2;
    const step = 14.0;
    for (var x = -size.height; x < size.width; x += step) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_EditHatchPainter oldDelegate) => false;
}
