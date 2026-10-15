import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_capture/presentation/widgets/capture_field_shell.dart';

class SpatialHierarchyCard extends StatefulWidget {
  const SpatialHierarchyCard({
    required this.market,
    required this.zone,
    required this.line,
    required this.landmark,
    required this.onLandmarkChanged,
    super.key,
  });

  final String market;
  final String zone;
  final String line;
  final String landmark;
  final ValueChanged<String> onLandmarkChanged;

  @override
  State<SpatialHierarchyCard> createState() => _SpatialHierarchyCardState();
}

class _SpatialHierarchyCardState extends State<SpatialHierarchyCard> {
  late final TextEditingController _landmark;
  late final FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _landmark = TextEditingController(text: widget.landmark);
    _focus = FocusNode()..addListener(_onFocus);
  }

  void _onFocus() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(SpatialHierarchyCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_landmark.text == widget.landmark) {
      return;
    }
    _landmark.value = TextEditingValue(
      text: widget.landmark,
      selection: TextSelection.collapsed(offset: widget.landmark.length),
    );
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocus);
    _focus.dispose();
    _landmark.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final market = widget.market.trim();
    final zone = widget.zone.trim();
    final line = widget.line.trim();
    final current = market.isEmpty
        ? 0
        : zone.isEmpty
        ? 1
        : 2;
    final steps = [
      _PathStep(label: l10n.captureMarket, value: market),
      _PathStep(label: l10n.captureZone, value: zone),
      _PathStep(
        label: current == 2 ? l10n.captureLineCurrent : l10n.captureLine,
        value: line,
        emphasize: current == 2,
      ),
    ];
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.secondaryContainer.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: scheme.primaryContainer),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.captureHierarchyTitle.toUpperCase(),
                    style: AppTextStyles.mono(
                      Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: scheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (market.isNotEmpty) ...[
                  const SizedBox(width: AppSpacing.xs),
                  Flexible(
                    child: _cluster(context, l10n.captureClusterChip(market)),
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            for (var index = 0; index < steps.length; index++)
              _row(
                context,
                step: steps[index],
                mark: index < current
                    ? _PathMark.complete
                    : index == current
                    ? _PathMark.current
                    : _PathMark.upcoming,
                connect: true,
              ),
            _row(
              context,
              step: _PathStep(label: l10n.captureLandmark, value: ''),
              mark: _PathMark.upcoming,
              connect: false,
              child: CaptureFieldShell(
                focused: _focus.hasFocus,
                child: SizedBox(
                  height: AppDimensions.inputHeight,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      controller: _landmark,
                      focusNode: _focus,
                      textCapitalization: TextCapitalization.sentences,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: l10n.captureLandmarkHint,
                        hintStyle: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(
                              color: scheme.onSurfaceVariant,
                              fontWeight: FontWeight.w400,
                            ),
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
                      onChanged: widget.onLandmarkChanged,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cluster(BuildContext context, String label) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppRadii.input),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xxs,
          vertical: AppSpacing.xxs / 2,
        ),
        child: Text(
          label.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.mono(
            Theme.of(context).textTheme.labelSmall!
                .copyWith(color: scheme.secondary, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _row(
    BuildContext context, {
    required _PathStep step,
    required _PathMark mark,
    required bool connect,
    Widget? child,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final value = step.value;
    final emphasize = mark == _PathMark.current || step.emphasize;
    return Padding(
      padding: EdgeInsets.only(bottom: connect ? AppSpacing.sm : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _node(context, mark),
              if (connect)
                Container(
                  width: AppDimensions.borderWidth,
                  height: AppSpacing.lg,
                  color: scheme.primaryContainer,
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xxs / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.label.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: emphasize
                          ? scheme.primary
                          : scheme.onSurfaceVariant,
                      fontWeight: emphasize ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  child ??
                      Text(
                        value.isEmpty ? context.l10n.captureNotSet : value,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: value.isEmpty
                              ? scheme.onSurfaceVariant
                              : emphasize
                              ? scheme.secondary
                              : scheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _node(BuildContext context, _PathMark mark) {
    final scheme = Theme.of(context).colorScheme;
    final complete = mark == _PathMark.complete;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: complete ? scheme.primary : scheme.surface,
        shape: BoxShape.circle,
        border: complete
            ? null
            : Border.all(
                color: mark == _PathMark.current
                    ? scheme.primary
                    : scheme.outline,
                width: mark == _PathMark.current
                    ? AppDimensions.borderWidth * 2
                    : AppDimensions.borderWidth,
              ),
      ),
      child: SizedBox(
        width: AppDimensions.iconMd,
        height: AppDimensions.iconMd,
        child: complete
            ? Icon(Icons.check, size: AppSpacing.sm, color: scheme.onPrimary)
            : Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: mark == _PathMark.current
                        ? scheme.primary
                        : scheme.surface,
                    shape: BoxShape.circle,
                  ),
                  child: const SizedBox(
                    width: AppSpacing.xs,
                    height: AppSpacing.xs,
                  ),
                ),
              ),
      ),
    );
  }
}

class _PathStep {
  const _PathStep({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final bool emphasize;
}

enum _PathMark { complete, current, upcoming }
