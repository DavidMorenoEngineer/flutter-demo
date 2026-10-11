import 'package:flutter/material.dart';

import '../../../../core/theme/sx_colors.dart';
import '../../../../core/theme/sx_theme.dart';

class KixAvatar extends StatelessWidget {
  const KixAvatar({super.key, this.size = 36});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [SxColors.goldLight, SxColors.gold],
        ),
      ),
      child: Text('K', style: SxText.display(size * 0.62, color: SxColors.goldInk, weight: FontWeight.w700)),
    );
  }
}
