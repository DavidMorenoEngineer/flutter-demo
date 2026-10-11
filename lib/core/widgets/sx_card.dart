import 'package:flutter/material.dart';

import '../theme/sx_colors.dart';

class SxCard extends StatelessWidget {
  const SxCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.highlight = false,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool highlight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(18);
    return Material(
      color: SxColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: highlight ? SxColors.gold : SxColors.line, width: highlight ? 1.5 : 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(onTap: onTap, child: Padding(padding: padding, child: child)),
    );
  }
}
