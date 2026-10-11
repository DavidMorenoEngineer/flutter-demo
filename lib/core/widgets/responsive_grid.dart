import 'package:flutter/material.dart';

/// Lays children out in as many equal columns as fit `minTileWidth`. Tiles in
/// the same row stretch to the tallest one, so cards line up like the site.
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.minTileWidth = 300,
    this.spacing = 16,
    this.maxColumns = 4,
  });

  final List<Widget> children;
  final double minTileWidth;
  final double spacing;
  final int maxColumns;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final cols = ((c.maxWidth + spacing) / (minTileWidth + spacing)).floor().clamp(1, maxColumns);
      if (cols == 1) {
        return Column(children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) SizedBox(height: spacing),
            SizedBox(width: double.infinity, child: children[i]),
          ],
        ]);
      }
      final rows = <Widget>[];
      for (var start = 0; start < children.length; start += cols) {
        final slice = children.skip(start).take(cols).toList();
        rows.add(Padding(
          padding: EdgeInsets.only(top: start == 0 ? 0 : spacing),
          child: IntrinsicHeight(
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              for (var i = 0; i < cols; i++) ...[
                if (i > 0) SizedBox(width: spacing),
                Expanded(child: i < slice.length ? slice[i] : const SizedBox.shrink()),
              ],
            ]),
          ),
        ));
      }
      return Column(children: rows);
    });
  }
}
