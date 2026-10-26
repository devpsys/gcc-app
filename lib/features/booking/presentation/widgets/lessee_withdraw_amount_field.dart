import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// Withdrawal amount field with NGN chip (MOB-LSE-14 frame 2).
class LesseeWithdrawAmountField extends StatefulWidget {
  const LesseeWithdrawAmountField({
    required this.value,
    required this.generation,
    required this.onChanged,
    required this.currencyBadge,
    this.error = false,
    this.emphasized = false,
    super.key,
  });

  final String value;
  final int generation;
  final ValueChanged<String> onChanged;
  final String currencyBadge;
  final bool error;
  final bool emphasized;

  @override
  State<LesseeWithdrawAmountField> createState() =>
      _LesseeWithdrawAmountFieldState();
}

class _LesseeWithdrawAmountFieldState extends State<LesseeWithdrawAmountField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.value,
  );

  @override
  void didUpdateWidget(LesseeWithdrawAmountField oldWidget) {
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
    final borderColor = widget.error
        ? scheme.error
        : widget.emphasized
        ? scheme.primary
        : scheme.outline;
    final borderWidth = widget.error || widget.emphasized
        ? AppDimensions.emphasisBorderWidth
        : AppDimensions.borderWidth;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.input),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: AppDimensions.inputHeight),
        child: Row(
          children: [
            const SizedBox(width: AppSpacing.sm),
            Text(
              '₦',
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.end,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9,]')),
                ],
                style: AppTextStyles.tabular(
                  Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                decoration: const InputDecoration(
                  filled: false,
                  isCollapsed: true,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  constraints: BoxConstraints(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                ),
                onChanged: widget.onChanged,
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.secondaryContainer,
                borderRadius: BorderRadius.circular(AppRadii.input),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xxs,
                ),
                child: Text(
                  widget.currencyBadge,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
        ),
      ),
    );
  }
}
