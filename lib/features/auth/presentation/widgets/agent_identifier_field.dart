import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_text_field.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_identifier_validator.dart';

class AgentIdentifierField extends StatefulWidget {
  const AgentIdentifierField({
    required this.label,
    required this.hint,
    required this.onChanged,
    this.onUnfocused,
    this.onSubmitted,
    this.errorText,
    this.enabled = true,
    super.key,
  });

  final String label;
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback? onUnfocused;
  final ValueChanged<String>? onSubmitted;
  final String? errorText;
  final bool enabled;

  @override
  State<AgentIdentifierField> createState() => _AgentIdentifierFieldState();
}

class _AgentIdentifierFieldState extends State<AgentIdentifierField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        widget.onUnfocused?.call();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme.bodyLarge;
    return AppTextField(
      label: widget.label,
      hint: widget.hint,
      style: text == null
          ? null
          : AppTextStyles.mono(text.copyWith(fontWeight: FontWeight.w500)),
      focusNode: _focusNode,
      enabled: widget.enabled,
      errorText: widget.errorText,
      textCapitalization: TextCapitalization.characters,
      textInputAction: TextInputAction.done,
      maxLength: AgentIdentifierValidator.maxLength,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9-]')),
      ],
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
    );
  }
}
