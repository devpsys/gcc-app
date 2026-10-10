import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/auth/presentation/widgets/otp_code_box.dart';

class OtpCodeField extends StatefulWidget {
  const OtpCodeField({
    required this.label,
    required this.onChanged,
    this.onCompleted,
    this.errorText,
    this.enabled = true,
    this.autofocus = false,
    super.key,
  });

  static const int length = 6;

  final String label;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onCompleted;
  final String? errorText;
  final bool enabled;
  final bool autofocus;

  @override
  State<OtpCodeField> createState() => _OtpCodeFieldState();
}

class _OtpCodeFieldState extends State<OtpCodeField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  var _completed = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final error = widget.errorText;
    final value = _controller.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppDimensions.inputHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  _cluster(value, error, 0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.outline,
                        borderRadius: BorderRadius.circular(AppRadii.micro),
                      ),
                      child: const SizedBox(width: AppSpacing.xs, height: 2),
                    ),
                  ),
                  _cluster(value, error, 3),
                ],
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: 0,
                  child: Semantics(
                    label: widget.label,
                    textField: true,
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      enabled: widget.enabled,
                      autofocus: widget.autofocus,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.oneTimeCode],
                      maxLength: OtpCodeField.length,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        filled: false,
                        isCollapsed: true,
                        counterText: '',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        constraints: BoxConstraints(),
                      ),
                      onChanged: _onChanged,
                      onSubmitted: _completeIfReady,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            error,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ],
    );
  }

  Widget _cluster(String value, String? error, int start) {
    return Expanded(
      child: Row(
        children: [
          for (var offset = 0; offset < 3; offset++) ...[
            if (offset > 0) const SizedBox(width: AppSpacing.xxs),
            Expanded(child: _box(value, error, start + offset)),
          ],
        ],
      ),
    );
  }

  Widget _box(String value, String? error, int index) {
    return OtpCodeBox(
      digit: index < value.length ? value[index] : '',
      filled: index < value.length,
      focused:
          widget.enabled &&
          _focusNode.hasFocus &&
          index == value.length &&
          value.length < OtpCodeField.length,
      hasError: error != null,
    );
  }

  void _onChanged(String value) {
    setState(() {});
    widget.onChanged(value);
    if (value.length < OtpCodeField.length) {
      _completed = false;
      return;
    }
    _completeIfReady(value);
  }

  void _completeIfReady(String value) {
    if (_completed || value.length != OtpCodeField.length) {
      return;
    }
    _completed = true;
    widget.onCompleted?.call(value);
  }
}
