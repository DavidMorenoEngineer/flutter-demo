import 'dart:math' as math;
import 'dart:ui' show PathMetric;

import 'package:flutter/material.dart';

import '../../../../core/theme/sx_colors.dart';

/// Hero artwork: a winding dotted path with a glowing node travelling along
/// it — "the next step lights up" from the site's concept, drawn in code.
class JourneyPathArt extends StatefulWidget {
  const JourneyPathArt({super.key});

  @override
  State<JourneyPathArt> createState() => _JourneyPathArtState();
}

class _JourneyPathArtState extends State<JourneyPathArt> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 7))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      RepaintBoundary(child: CustomPaint(painter: _PathPainter(_c), size: Size.infinite));
}

class _PathPainter extends CustomPainter {
  _PathPainter(this.t) : super(repaint: t);

  final Animation<double> t;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final path = Path()
      ..moveTo(w * 0.08, h * 0.88)
      ..cubicTo(w * 0.40, h * 0.95, w * 0.10, h * 0.55, w * 0.42, h * 0.52)
      ..cubicTo(w * 0.74, h * 0.49, w * 0.55, h * 0.20, w * 0.90, h * 0.10);

    // Soft glow behind the path.
    canvas.drawCircle(
      Offset(w * 0.55, h * 0.45),
      math.min(w, h) * 0.5,
      Paint()
        ..shader = RadialGradient(colors: [SxColors.gold.withValues(alpha: 0.22), Colors.transparent])
            .createShader(Rect.fromCircle(center: Offset(w * 0.55, h * 0.45), radius: math.min(w, h) * 0.5)),
    );

    final metric = path.computeMetrics().first;
    final progress = Curves.easeInOut.transform(t.value);
    final lit = metric.length * progress;

    // Grey ("grey wall of how") ahead of the node, gold behind it.
    _dots(canvas, metric, 0, lit, SxColors.gold, 1);
    _dots(canvas, metric, lit, metric.length, SxColors.dim, 0.55);

    final head = metric.getTangentForOffset(lit)!.position;
    canvas.drawCircle(head, 22, Paint()..color = SxColors.goldBright.withValues(alpha: 0.18));
    canvas.drawCircle(head, 11, Paint()..color = SxColors.goldBright.withValues(alpha: 0.4));
    canvas.drawCircle(head, 6, Paint()..color = SxColors.goldLight);

    // Milestone markers.
    for (final f in [0.0, 0.34, 0.68, 1.0]) {
      final p = metric.getTangentForOffset(metric.length * f)!.position;
      final reached = metric.length * f <= lit;
      canvas.drawCircle(p, 8, Paint()..color = SxColors.bg);
      canvas.drawCircle(
        p,
        8,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = reached ? SxColors.gold : SxColors.dim,
      );
    }
  }

  void _dots(Canvas canvas, PathMetric m, double from, double to, Color color, double alpha) {
    final paint = Paint()..color = color.withValues(alpha: alpha);
    for (var d = from; d < to; d += 11) {
      canvas.drawCircle(m.getTangentForOffset(d)!.position, 2.2, paint);
    }
  }

  @override
  bool shouldRepaint(_PathPainter old) => false;
}
