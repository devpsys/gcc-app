import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/auth/presentation/bloc/auth_identifier_validator.dart';

/// Floating-label mono ID field (MOB-AUTH-UNIFIED).
class AuthFloatingIdField extends StatefulWidget {
  const AuthFloatingIdField({
    required this.label,
    required this.hint,
    required this.onChanged,
    this.onUnfocused,
    this.onSubmitted,
    this.onClear,
    this.errorText,
    this.enabled = true,
    this.hasError = false,
    this.controller,
    super.key,
  });

  final String label;
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback? onUnfocused;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final String? errorText;
  final bool enabled;
  final bool hasError;
  final TextEditingController? controller;

  @override
  State<AuthFloatingIdField> createState() => _AuthFloatingIdFieldState();
}

class _AuthFloatingIdFieldState extends State<AuthFloatingIdField> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();
  final FocusNode _focusNode = FocusNode();
  var _ownsController = false;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _focusNode.addListener(_onFocus);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocus);
    _focusNode.dispose();
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onFocus() {
    if (!_focusNode.hasFocus) {
      widget.onUnfocused?.call();
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final error = widget.hasError || widget.errorText != null;
    final borderColor = error
        ? scheme.error
        : _focusNode.hasFocus
        ? scheme.primary
        : colors.border;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: error ? colors.dangerContainer : scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppRadii.input),
            border: Border.all(
              color: borderColor,
              width: error || _focusNode.hasFocus
                  ? AppDimensions.emphasisBorderWidth
                  : AppDimensions.borderWidth,
            ),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: AppDimensions.authInputHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.label.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: error
                                    ? scheme.error
                                    : scheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4,
                              ),
                        ),
                        TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          enabled: widget.enabled,
                          textInputAction: TextInputAction.done,
                          textCapitalization: TextCapitalization.characters,
                          style: AppTextStyles.mono(
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: error ? scheme.error : scheme.onSurface,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                              height: 1.2,
                            ),
                          ),
                          maxLength: AuthIdentifierValidator.maxLength,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9\-]'),
                            ),
                          ],
                          decoration: InputDecoration(
                            isDense: true,
                            isCollapsed: true,
                            counterText: '',
                            border: InputBorder.none,
                            hintText: widget.hint,
                            hintStyle: AppTextStyles.mono(
                              Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                    color: scheme.onSurfaceVariant.withValues(
                                      alpha: 0.45,
                                    ),
                                    height: 1.2,
                                  ),
                            ),
                          ),
                          onChanged: (value) {
                            widget.onChanged(value);
                            setState(() {});
                          },
                          onSubmitted: widget.onSubmitted,
                        ),
                      ],
                    ),
                  ),
                  if (_controller.text.isNotEmpty)
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      tooltip: MaterialLocalizations.of(
                        context,
                      ).deleteButtonTooltip,
                      onPressed: widget.enabled
                          ? () {
                              _controller.clear();
                              widget.onChanged('');
                              widget.onClear?.call();
                              setState(() {});
                            }
                          : null,
                      icon: Icon(
                        error ? Icons.priority_high : Icons.cancel_outlined,
                        color: error ? scheme.error : scheme.onSurfaceVariant,
                        size: AppDimensions.iconMd,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            widget.errorText!,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: scheme.error),
          ),
        ],
      ],
    );
  }
}
