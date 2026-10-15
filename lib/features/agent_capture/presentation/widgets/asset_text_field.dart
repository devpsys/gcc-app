import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/capture_field_shell.dart';

/// Labelled text input for the asset step.
///
/// Mirrors the pattern the shop step uses: a small label, an optional error
/// beneath it, and a 52 px field inside the capture field shell. Owning the
/// controller here means the four asset text fields do not each have to
/// re-implement controller syncing and focus tracking.
///
/// [action] renders on the trailing edge — the serial field uses it for the
/// design's `Scan` text action.
class AssetTextField extends StatefulWidget {
  const AssetTextField({
    required this.label,
    required this.hint,
    required this.onChanged,
    this.value = '',
    this.errorText,
    this.action,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.fieldKey,
    super.key,
  });

  final String label;
  final String hint;
  final String value;
  final String? errorText;
  final Widget? action;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final ValueChanged<String> onChanged;

  /// Key for the underlying field, so conformance tests can measure it.
  final Key? fieldKey;

  @override
  State<AssetTextField> createState() => _AssetTextFieldState();
}

class _AssetTextFieldState extends State<AssetTextField> {
  late final TextEditingController _controller;
  late final FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focus = FocusNode()..addListener(_onFocus);
  }

  void _onFocus() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(AssetTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == _controller.text) {
      return;
    }
    _controller.value = TextEditingValue(
      text: widget.value,
      selection: TextSelection.collapsed(offset: widget.value.length),
    );
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocus);
    _focus.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final error = widget.errorText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: error == null
                ? theme.colorScheme.onSurface
                : theme.colorScheme.error,
          ),
        ),
        if (error != null)
          Text(
            error,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.w500,
            ),
          ),
        const SizedBox(height: AppSpacing.xxs),
        CaptureFieldShell(
          focused: _focus.hasFocus,
          error: error != null,
          child: TextField(
            key: widget.fieldKey,
            controller: _controller,
            focusNode: _focus,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization,
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.sm,
              ),
              suffixIcon: widget.action,
            ),
          ),
        ),
      ],
    );
  }
}
