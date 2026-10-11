import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Tap-to-flip card with a 3D Y-axis rotation.
class FlipCard extends StatefulWidget {
  const FlipCard({super.key, required this.front, required this.back, this.height = 330});

  final Widget front;
  final Widget back;
  final double height;

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 520));
  late final Animation<double> _angle = CurvedAnimation(parent: _c, curve: Curves.easeInOutCubic);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _toggle() => _c.status == AnimationStatus.completed || _c.status == AnimationStatus.forward
      ? _c.reverse()
      : _c.forward();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: SizedBox(
        height: widget.height,
        child: AnimatedBuilder(
          animation: _angle,
          builder: (context, _) {
            final a = _angle.value * math.pi;
            final showBack = a > math.pi / 2;
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(a),
              child: showBack
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: widget.back,
                    )
                  : widget.front,
            );
          },
        ),
      ),
    );
  }
}
