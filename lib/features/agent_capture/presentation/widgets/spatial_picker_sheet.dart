import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/capture_field_shell.dart';

Future<String?> showSpatialPicker({
  required BuildContext context,
  required String title,
  required String initial,
  String? caption,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (context) {
      final media = MediaQuery.of(context);
      return Padding(
        padding: EdgeInsets.only(
          top: media.padding.top,
          bottom: media.padding.bottom,
        ),
        child: SizedBox(
          height: media.size.height - media.padding.vertical,
          child: SpatialPickerSheet(
            title: title,
            initial: initial,
            caption: caption,
          ),
        ),
      );
    },
  );
}

class SpatialPickerSheet extends StatefulWidget {
  const SpatialPickerSheet({
    required this.title,
    required this.initial,
    this.caption,
    super.key,
  });

  final String title;
  final String initial;
  final String? caption;

  @override
  State<SpatialPickerSheet> createState() => _SpatialPickerSheetState();
}

class _SpatialPickerSheetState extends State<SpatialPickerSheet> {
  late final TextEditingController _query;
  late final FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _query = TextEditingController(text: widget.initial);
    _focus = FocusNode()..addListener(_onFocus);
  }

  void _onFocus() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocus);
    _focus.dispose();
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final query = _query.text.trim();
    final caption = widget.caption;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: AppDimensions.topBarHeight,
          child: Row(
            children: [
              IconButton(
                tooltip: l10n.authBack,
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    if (caption != null && caption.isNotEmpty)
                      Text(
                        caption.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                  ],
                ),
              ),
              TextButton(
                onPressed: query.isEmpty ? null : () => _select(query),
                child: Text(l10n.capturePickerDone),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: CaptureFieldShell(
            focused: _focus.hasFocus,
            child: SizedBox(
              height: AppDimensions.inputHeight,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.sm),
                    child: Icon(
                      Icons.search,
                      size: AppDimensions.iconMd,
                      color: _focus.hasFocus
                          ? scheme.primary
                          : scheme.onSurfaceVariant,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _query,
                      focusNode: _focus,
                      textCapitalization: TextCapitalization.words,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: l10n.capturePickerSearch,
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
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (query.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text(
              l10n.capturePickerEmpty,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          )
        else
          InkWell(
            onTap: () => _select(query),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Text(
                    l10n.capturePickerUnlisted,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      l10n.capturePickerCustom(query),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: AppPrimaryButton(
            label: query.isEmpty
                ? l10n.capturePickerDone
                : l10n.capturePickerSelect(query),
            onPressed: query.isEmpty ? null : () => _select(query),
            disabledReason: l10n.capturePickerEmpty,
          ),
        ),
      ],
    );
  }

  void _select(String value) => Navigator.of(context).pop(value);
}
