import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/auth/presentation/widgets/otp_code_box.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';

class OnboardingCodeField extends StatefulWidget {
  const OnboardingCodeField({
    required this.label,
    required this.helper,
    required this.value,
    required this.onChanged,
    required this.onCompleted,
    this.enabled = false,
    this.errorText,
    super.key,
  });

  final String label;
  final String helper;
  final String value;
  final bool enabled;
  final String? errorText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onCompleted;

  @override
  State<OnboardingCodeField> createState() => _OnboardingCodeFieldState();
}

class _OnboardingCodeFieldState extends State<OnboardingCodeField> {
  late final TextEditingController _controller;
  late final FocusNode _focus;
  var _completed = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focus = FocusNode()..addListener(_rebuild);
    _completed = widget.value.length == OnboardingCubit.codeLength;
  }

  void _rebuild() => setState(() {});

  @override
  void didUpdateWidget(OnboardingCodeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.value,
        selection: TextSelection.collapsed(offset: widget.value.length),
      );
      _completed = widget.value.length == OnboardingCubit.codeLength;
    }
    if (widget.enabled && !oldWidget.enabled) {
      _focus.requestFocus();
    }
  }

  @override
  void dispose() {
    _focus.removeListener(_rebuild);
    _focus.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final error = widget.errorText;
    final value = _controller.text;
    final labelStyle = AppTextStyles.mono(
      Theme.of(context).textTheme.labelSmall!.copyWith(
        color: widget.enabled ? scheme.onSurfaceVariant : scheme.outline,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label.toUpperCase(), style: labelStyle),
        const SizedBox(height: AppSpacing.xs),
        SizedBox(
          height: AppDimensions.inputHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  for (
                    var index = 0;
                    index < OnboardingCubit.codeLength;
                    index++
                  ) ...[
                    if (index > 0) const SizedBox(width: AppSpacing.xxs),
                    Expanded(
                      child: OtpCodeBox(
                        digit: index < value.length ? value[index] : '',
                        filled: index < value.length,
                        focused:
                            widget.enabled &&
                            _focus.hasFocus &&
                            index == value.length &&
                            value.length < OnboardingCubit.codeLength,
                        hasError: error != null,
                      ),
                    ),
                  ],
                ],
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: 0,
                  child: TextField(
                    controller: _controller,
                    focusNode: _focus,
                    enabled: widget.enabled,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.oneTimeCode],
                    maxLength: OnboardingCubit.codeLength,
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
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          error ?? widget.helper,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: error == null ? null : scheme.error),
        ),
      ],
    );
  }

  void _onChanged(String value) {
    setState(() {});
    widget.onChanged(value);
    if (value.length < OnboardingCubit.codeLength) {
      _completed = false;
      return;
    }
    _completeIfReady(value);
  }

  void _completeIfReady(String value) {
    if (_completed || value.length != OnboardingCubit.codeLength) {
      return;
    }
    _completed = true;
    widget.onCompleted(value);
  }
}
