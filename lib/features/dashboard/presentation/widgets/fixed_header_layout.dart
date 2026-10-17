import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Pins [header] above [body].
///
/// The header keeps its own height and does not scroll with [body]. When the
/// header is taller than the slot, it is clipped to the space that remains
/// after a short body strip, so a large text scale cannot overflow the page.
class FixedHeaderLayout extends MultiChildRenderObjectWidget {
  FixedHeaderLayout({required Widget header, required Widget body, super.key})
    : super(children: [header, body]);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderFixedHeaderLayout();
  }
}

class _FixedHeaderParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderFixedHeaderLayout extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _FixedHeaderParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _FixedHeaderParentData> {
  static const double _minimumBodyExtent = 48;

  double _headerExtent = 0;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _FixedHeaderParentData) {
      child.parentData = _FixedHeaderParentData();
    }
  }

  @override
  bool get sizedByParent => true;

  @override
  Size computeDryLayout(BoxConstraints constraints) => constraints.biggest;

  @override
  void performLayout() {
    final header = firstChild!;
    final body = childAfter(header)!;
    final width = constraints.maxWidth;
    header.layout(
      BoxConstraints(minWidth: width, maxWidth: width),
      parentUsesSize: true,
    );
    final available = constraints.maxHeight;
    final headerExtent = header.size.height <= available
        ? header.size.height
        : math.max(0.0, available - _minimumBodyExtent);
    final bodyExtent = math.max(0.0, available - headerExtent);
    body.layout(
      BoxConstraints.tightFor(width: width, height: bodyExtent),
      parentUsesSize: true,
    );
    (header.parentData! as _FixedHeaderParentData).offset = Offset.zero;
    (body.parentData! as _FixedHeaderParentData).offset = Offset(
      0,
      headerExtent,
    );
    _headerExtent = headerExtent;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final header = firstChild!;
    final body = childAfter(header)!;
    final headerData = header.parentData! as _FixedHeaderParentData;
    final bodyData = body.parentData! as _FixedHeaderParentData;
    context.pushClipRect(
      needsCompositing,
      offset + headerData.offset,
      Offset.zero & Size(size.width, _headerExtent),
      (context, offset) => context.paintChild(header, offset),
    );
    context.paintChild(body, offset + bodyData.offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final header = firstChild!;
    final body = childAfter(header)!;
    final bodyData = body.parentData! as _FixedHeaderParentData;
    if (body.hitTest(result, position: position - bodyData.offset)) {
      return true;
    }
    final headerData = header.parentData! as _FixedHeaderParentData;
    final headerPosition = position - headerData.offset;
    if (headerPosition.dy < 0 || headerPosition.dy >= _headerExtent) {
      return false;
    }
    return header.hitTest(result, position: headerPosition);
  }
}
