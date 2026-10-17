import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/agent_here_pulse.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_pin.dart';

/// The field map: city blocks, streets, shop pins and the agent's position.
///
/// No tile SDK is wired up, so the canvas is drawn rather than fetched. That
/// is not a stand-in for its own sake — it keeps every state the design frames
/// reachable and testable, including the uncached hatch, without inventing a
/// map backend.
///
/// When the view has no cached vector data the canvas is covered by a 45° hatch,
/// which is the design's signal that nothing here will load.
class MapCanvas extends StatelessWidget {
  const MapCanvas({required this.shops, required this.hatched, super.key});
  final List<MapShop> shops;

  /// Whether this view has no cached vector data.
  final bool hatched;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: scheme.surfaceContainerLow),
            CustomPaint(painter: _CityBlocksPainter(scheme: scheme)),
            CustomPaint(painter: _StreetPainter(scheme: scheme)),
            for (final shop in shops)
              if (shop.offset case final offset?)
                MapPin(
                  shop: shop,
                  center: Offset(offset.x * size.width, offset.y * size.height),
                ),
            const AgentHerePulse(),
            if (hatched)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest.withValues(
                      alpha: 0.55,
                    ),
                  ),
                  child: CustomPaint(painter: const _UncachedHatchPainter()),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// One shop pin.
///
/// Three shapes carry the status — a tick disc for verified, a filled dot for
/// this agent's own shops, a hollow ring for a lead — so a pin is still
/// readable without colour.
/// The pulsing "you are here" marker at the centre of the view.
/// City blocks, so the map reads as built-up rather than blank.
class _CityBlocksPainter extends CustomPainter {
  const _CityBlocksPainter({required this.scheme});
  final ColorScheme scheme;
  @override
  void paint(Canvas canvas, Size size) {
    final fill = Paint()..color = scheme.surfaceContainerHighest;
    const block = 34.0;
    const gapX = 14.0;
    const gapY = 10.0;
    for (var row = 0; row < 5; row++) {
      for (var column = 0; column < 4; column++) {
        final left = 8 + column * (block + gapX);
        final top = 8 + row * (block + gapY);
        if (left + block > size.width || top + block > size.height) continue;
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(left, top, block, block),
            const Radius.circular(2),
          ),
          fill,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_CityBlocksPainter old) => old.scheme != scheme;
}

/// The streets, with the arterial road drawn heavier than the side streets.
class _StreetPainter extends CustomPainter {
  const _StreetPainter({required this.scheme});
  final ColorScheme scheme;
  @override
  void paint(Canvas canvas, Size size) {
    final minor = Paint()
      ..color = scheme.outlineVariant
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final arterial = Paint()
      ..color = scheme.outline
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    for (final t in const [0.2, 0.52, 0.84]) {
      canvas.drawLine(
        Offset(0, size.height * t),
        Offset(size.width, size.height * t),
        minor,
      );
    }
    canvas.drawLine(
      Offset(size.width * 0.3, 0),
      Offset(size.width * 0.3, size.height),
      arterial,
    );
    canvas.drawLine(
      Offset(size.width * 0.74, 0),
      Offset(size.width * 0.74, size.height),
      minor,
    );
  }

  @override
  bool shouldRepaint(_StreetPainter old) => old.scheme != scheme;
}

/// The 45° hatch marking an area with no cached tiles.
///
/// Private because it has nothing to configure: the stroke is a theme token and
/// the backdrop comes from whatever it is painted over.
class _UncachedHatchPainter extends CustomPainter {
  const _UncachedHatchPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.uncachedHatch
      ..strokeWidth = 2;
    const step = 20.0;
    for (var x = -size.height; x < size.width; x += step) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_UncachedHatchPainter old) => false;
}
