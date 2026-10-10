import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({
    required this.label,
    required this.prefix,
    required this.value,
    required this.onChanged,
    this.onSubmitted,
    this.errorText,
    this.complete = false,
    super.key,
  });

  final String label;
  final String prefix;
  final String value;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? errorText;
  final bool complete;

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  late final TextEditingController _controller;
  late final FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focus = FocusNode()..addListener(_rebuild);
  }

  void _rebuild() => setState(() {});

  @override
  void didUpdateWidget(PhoneNumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.value,
        selection: TextSelection.collapsed(offset: widget.value.length),
      );
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
    final focused = _focus.hasFocus;
    final prefixStyle = AppTextStyles.mono(
      Theme.of(context).textTheme.bodyMedium!
          .copyWith(fontWeight: FontWeight.w500, color: scheme.onSurface),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label.toUpperCase(),
          style: AppTextStyles.mono(Theme.of(context).textTheme.labelSmall!),
        ),
        const SizedBox(height: AppSpacing.xs),
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            border: Border.all(
              color: focused ? scheme.primary : scheme.outline,
              width: focused
                  ? AppDimensions.focusBorderWidth
                  : AppDimensions.borderWidth,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            child: SizedBox(
              height: AppDimensions.inputHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      border: Border(
                        right: BorderSide(color: context.semanticColors.border),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                      ),
                      child: Center(
                        child: Text(widget.prefix, style: prefixStyle),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: _controller,
                        focusNode: _focus,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.telephoneNumber],
                        maxLength: OnboardingCubit.phoneLength,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.bodyLarge!,
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
                          counterText: '',
                          constraints: BoxConstraints(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                          ),
                        ),
                        onChanged: widget.onChanged,
                        onSubmitted: widget.onSubmitted,
                      ),
                    ),
                  ),
                  if (widget.complete)
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          size: AppDimensions.iconSm,
                          color: scheme.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            widget.errorText!,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: scheme.error),
          ),
        ],
      ],
    );
  }
}
