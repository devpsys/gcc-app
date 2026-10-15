import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/capture_field_shell.dart';

class ShopIdentityFields extends StatefulWidget {
  const ShopIdentityFields({
    required this.shopName,
    required this.ownerName,
    required this.onShopNameChanged,
    required this.onOwnerNameChanged,
    required this.middle,
    this.shopNameError,
    this.ownerNameError,
    super.key,
  });

  final String shopName;
  final String ownerName;
  final ValueChanged<String> onShopNameChanged;
  final ValueChanged<String> onOwnerNameChanged;
  final Widget middle;
  final String? shopNameError;
  final String? ownerNameError;

  @override
  State<ShopIdentityFields> createState() => _ShopIdentityFieldsState();
}

class _ShopIdentityFieldsState extends State<ShopIdentityFields> {
  late final TextEditingController _shopName;
  late final TextEditingController _ownerName;
  late final FocusNode _shopNameFocus;
  late final FocusNode _ownerNameFocus;

  @override
  void initState() {
    super.initState();
    _shopName = TextEditingController(text: widget.shopName);
    _ownerName = TextEditingController(text: widget.ownerName);
    _shopNameFocus = FocusNode()..addListener(_onFocus);
    _ownerNameFocus = FocusNode()..addListener(_onFocus);
  }

  void _onFocus() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(ShopIdentityFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sync(_shopName, widget.shopName);
    _sync(_ownerName, widget.ownerName);
  }

  void _sync(TextEditingController controller, String value) {
    if (controller.text == value) {
      return;
    }
    controller.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }

  @override
  void dispose() {
    _shopNameFocus.removeListener(_onFocus);
    _ownerNameFocus.removeListener(_onFocus);
    _shopNameFocus.dispose();
    _ownerNameFocus.dispose();
    _shopName.dispose();
    _ownerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _labeled(
          context,
          label: l10n.captureShopName,
          errorText: widget.shopNameError,
          field: _box(
            context,
            key: const Key('capture.shopNameField'),
            controller: _shopName,
            focusNode: _shopNameFocus,
            hintText: l10n.captureShopNameHint,
            onChanged: widget.onShopNameChanged,
            error: widget.shopNameError != null,
            textCapitalization: TextCapitalization.words,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        widget.middle,
        const SizedBox(height: AppSpacing.md),
        _labeled(
          context,
          label: l10n.captureOwnerName,
          errorText: widget.ownerNameError,
          field: _box(
            context,
            controller: _ownerName,
            focusNode: _ownerNameFocus,
            hintText: l10n.captureOwnerNameHint,
            onChanged: widget.onOwnerNameChanged,
            error: widget.ownerNameError != null,
            textCapitalization: TextCapitalization.words,
          ),
        ),
      ],
    );
  }

  Widget _labeled(
    BuildContext context, {
    required String label,
    required Widget field,
    String? errorText,
  }) {
    final error = errorText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: error == null ? null : Theme.of(context).colorScheme.error,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        field,
        if (error != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            error,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _box(
    BuildContext context, {
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required ValueChanged<String> onChanged,
    required bool error,
    Key? key,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    final hintStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w400,
    );
    return CaptureFieldShell(
      key: key,
      focused: focusNode.hasFocus,
      error: error,
      child: SizedBox(
        height: AppDimensions.inputHeight,
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            textCapitalization: textCapitalization,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle,
              filled: false,
              isCollapsed: true,
              constraints: const BoxConstraints(),
              contentPadding: const EdgeInsets.symmetric(
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
      ),
    );
  }
}
