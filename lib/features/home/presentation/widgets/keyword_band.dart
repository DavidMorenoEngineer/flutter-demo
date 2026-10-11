import 'package:flutter/material.dart';

import '../../../../core/theme/sx_colors.dart';
import '../../../../core/theme/sx_theme.dart';

/// Endlessly scrolling keyword strip under the hero.
class KeywordBand extends StatefulWidget {
  const KeywordBand({super.key, required this.keywords});

  final List<String> keywords;

  @override
  State<KeywordBand> createState() => _KeywordBandState();
}

class _KeywordBandState extends State<KeywordBand> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 28))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final k in widget.keywords) ...[
          Text(k.toUpperCase(), style: SxText.label(size: 12, color: SxColors.goldLight)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Icon(Icons.auto_awesome, size: 11, color: SxColors.gold),
          ),
        ],
      ],
    );
    return Container(
      height: 52,
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: SxColors.line)),
      ),
      child: ClipRect(
        child: LayoutBuilder(builder: (context, c) {
          return AnimatedBuilder(
            animation: _c,
            builder: (context, _) => OverflowBox(
              alignment: Alignment.centerLeft,
              maxWidth: double.infinity,
              child: FractionalTranslation(
                translation: Offset(-_c.value * 0.5, 0),
                child: Row(mainAxisSize: MainAxisSize.min, children: [row, row, row, row]),
              ),
            ),
          );
        }),
      ),
    );
  }
}
