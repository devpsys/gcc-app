import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_toggle_switch.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/capture_field_shell.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/grouped_phone_formatter.dart';

class WhatsAppOptionalField extends StatefulWidget {
  const WhatsAppOptionalField({
    required this.phone,
    required this.sameAsPhone,
    required this.whatsApp,
    required this.onPhoneChanged,
    required this.onSameChanged,
    required this.onWhatsAppChanged,
    this.phoneError,
    super.key,
  });

  final String phone;
  final bool sameAsPhone;
  final String whatsApp;
  final ValueChanged<String> onPhoneChanged;
  final ValueChanged<bool> onSameChanged;
  final ValueChanged<String> onWhatsAppChanged;
  final String? phoneError;

  @override
  State<WhatsAppOptionalField> createState() => _WhatsAppOptionalFieldState();
}

class _WhatsAppOptionalFieldState extends State<WhatsAppOptionalField> {
  late final TextEditingController _phone;
  late final TextEditingController _whatsApp;
  late final FocusNode _phoneFocus;
  late final FocusNode _whatsAppFocus;

  @override
  void initState() {
    super.initState();
    _phone = TextEditingController(
      text: GroupedPhoneFormatter.format(widget.phone),
    );
    _whatsApp = TextEditingController(
      text: GroupedPhoneFormatter.format(_shown),
    );
    _phoneFocus = FocusNode()..addListener(_onFocus);
    _whatsAppFocus = FocusNode()..addListener(_onFocus);
  }

  void _onFocus() {
    if (mounted) {
      setState(() {});
    }
  }

  String get _shown => widget.sameAsPhone ? widget.phone : widget.whatsApp;

  @override
  void didUpdateWidget(WhatsAppOptionalField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sync(_phone, widget.phone);
    _sync(_whatsApp, _shown);
  }

  void _sync(TextEditingController controller, String digits) {
    final formatted = GroupedPhoneFormatter.format(digits);
    if (controller.text == formatted) {
      return;
    }
    controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  @override
  void dispose() {
    _phoneFocus.removeListener(_onFocus);
    _whatsAppFocus.removeListener(_onFocus);
    _phoneFocus.dispose();
    _whatsAppFocus.dispose();
    _phone.dispose();
    _whatsApp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final locked = widget.sameAsPhone;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.capturePhoneNumber,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: widget.phoneError == null ? null : scheme.error,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        _prefixField(
          context,
          controller: _phone,
          focusNode: _phoneFocus,
          enabled: true,
          onChanged: widget.onPhoneChanged,
          error: widget.phoneError != null,
        ),
        if (widget.phoneError != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            widget.phoneError!,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: scheme.error, fontWeight: FontWeight.w500),
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            border: Border.all(color: context.semanticColors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppToggleSwitch(
                  label: l10n.captureWhatsApp,
                  caption: l10n.captureSameAsPhone,
                  captionBesideSwitch: true,
                  value: widget.sameAsPhone,
                  onChanged: widget.onSameChanged,
                ),
                _prefixField(
                  context,
                  controller: _whatsApp,
                  focusNode: _whatsAppFocus,
                  enabled: !locked,
                  onChanged: widget.onWhatsAppChanged,
                  error: false,
                  lockedNote: locked ? l10n.captureUsingPhoneAbove : null,
                ),
                if (locked) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    l10n.captureUsingPhoneAboveBody,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _prefixField(
    BuildContext context, {
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool enabled,
    required ValueChanged<String> onChanged,
    required bool error,
    String? lockedNote,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final showPrefix = lockedNote == null;
    final phoneStyle = AppTextStyles.mono(
      Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: AppTextStyles.bodySize * AppTextStyles.wideTracking,
        color: enabled ? scheme.onSurface : scheme.onSurfaceVariant,
      ),
    );
    return CaptureFieldShell(
      focused: enabled && focusNode.hasFocus,
      error: error,
      enabled: enabled,
      fill: enabled ? scheme.surface : scheme.surfaceContainerHighest,
      child: SizedBox(
        height: AppDimensions.inputHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.input),
          child: Row(
            children: [
              if (showPrefix)
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    border: Border(right: BorderSide(color: scheme.outline)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                    child: Center(
                      child: Text(
                        context.l10n.capturePhonePrefix,
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  enabled: enabled,
                  keyboardType: TextInputType.phone,
                  inputFormatters: const [GroupedPhoneFormatter()],
                  style: phoneStyle,
                  decoration: const InputDecoration(
                    filled: false,
                    isCollapsed: true,
                    counterText: '',
                    constraints: BoxConstraints(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                  onChanged: onChanged,
                ),
              ),
              if (lockedNote != null)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: Text(
                    lockedNote,
                    style: Theme.of(context).textTheme.labelMedium
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
