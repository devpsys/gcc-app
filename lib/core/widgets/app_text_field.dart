import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    this.controller,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.focusNode,
    this.inputFormatters,
    this.semanticLabel,
    this.maxLength,
    this.enabled = true,
    this.obscureText = false,
    this.style,
    super.key,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final String? prefix;
  final Widget? suffix;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final String? semanticLabel;
  final int? maxLength;
  final bool enabled;
  final bool obscureText;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final field = TextField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      obscureText: obscureText,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      autofillHints: autofillHints,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      style: style ?? Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: hint,
        helperText: helperText,
        helperStyle: Theme.of(context).textTheme.bodySmall,
        errorText: errorText,
        errorStyle: Theme.of(context).textTheme.bodySmall
            ?.copyWith(color: Theme.of(context).colorScheme.error),
        prefixText: prefix,
        suffixIcon: suffix,
        counterText: maxLength == null ? null : '',
      ),
    );
    final announced = semanticLabel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: AppSpacing.xs),
        if (announced == null)
          field
        else
          Semantics(label: announced, child: field),
      ],
    );
  }
}
