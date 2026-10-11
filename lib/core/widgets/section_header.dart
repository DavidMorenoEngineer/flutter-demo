import 'package:flutter/material.dart';

import '../layout/breakpoints.dart';
import '../theme/sx_colors.dart';
import '../theme/sx_theme.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.eyebrow, required this.title, this.subtitle, this.center = false});

  final String eyebrow;
  final String title;
  final String? subtitle;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final size = switch (context.windowClass) {
      WindowClass.compact => 38.0,
      WindowClass.medium => 48.0,
      WindowClass.expanded => 62.0,
    };
    final align = center ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = center ? TextAlign.center : TextAlign.start;
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(eyebrow.toUpperCase(), style: SxText.label(), textAlign: textAlign),
        const SizedBox(height: 14),
        Text(title, style: SxText.display(size), textAlign: textAlign),
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(subtitle!, style: SxText.body(15, color: SxColors.muted), textAlign: textAlign),
          ),
        ],
      ],
    );
  }
}
