import 'package:flutter/material.dart';

import '../layout/breakpoints.dart';

/// Scrollable page with centred, max-width content — the one place that turns
/// a phone layout into a desktop-width one.
class PageBody extends StatelessWidget {
  const PageBody({super.key, required this.children, this.bottomInset = 120});

  final List<Widget> children;

  /// Extra scroll room so content clears the floating "Talk to Kix" button.
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(context.gutter, 24, context.gutter, bottomInset),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.contentMaxWidth),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
        ),
      ),
    );
  }
}
