import 'package:flutter/material.dart';

import '../theme/sx_colors.dart';
import '../theme/sx_theme.dart';

class GoldButton extends StatelessWidget {
  const GoldButton({super.key, required this.label, required this.onPressed, this.icon, this.outlined = false});

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final fg = outlined ? SxColors.goldLight : SxColors.goldInk;
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[Icon(icon, size: 18, color: fg), const SizedBox(width: 8)],
        Flexible(child: Text(label, textAlign: TextAlign.center, style: SxText.body(14, color: fg, weight: FontWeight.w600))),
      ],
    );
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(999));
    const padding = EdgeInsets.symmetric(horizontal: 22, vertical: 14);
    return outlined
        ? OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              shape: shape,
              padding: padding,
              side: const BorderSide(color: SxColors.gold),
            ),
            child: child,
          )
        : FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: SxColors.gold,
              foregroundColor: SxColors.goldInk,
              shape: shape,
              padding: padding,
            ),
            child: child,
          );
  }
}
