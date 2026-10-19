import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// A right-aligned naira amount. The prefix is the currency mark, not copy.
class WithdrawAmountField extends StatefulWidget {
  const WithdrawAmountField({
    required this.value,
    required this.generation,
    required this.onChanged,
    this.error = false,
    super.key,
  });

  final String value;
  final int generation;
  final ValueChanged<String> onChanged;
  final bool error;

  @override
  State<WithdrawAmountField> createState() => _WithdrawAmountFieldState();
}

class _WithdrawAmountFieldState extends State<WithdrawAmountField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.value,
  );

  @override
  void didUpdateWidget(WithdrawAmountField oldWidget) {
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.input),
        border: Border.all(
          color: widget.error ? scheme.error : scheme.outline,
          width: widget.error
              ? AppDimensions.emphasisBorderWidth
              : AppDimensions.borderWidth,
        ),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: AppDimensions.inputHeight),
        child: Row(
          children: [
            const SizedBox(width: AppSpacing.sm),
            Text(
              '₦',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
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
                  Theme.of(context).textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w700),
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
          ],
        ),
      ),
    );
  }
}
