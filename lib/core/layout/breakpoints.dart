import 'package:flutter/widgets.dart';

/// Window-width classes, in logical pixels.
///  - compact  < 600  : phones            -> bottom navigation
///  - medium   < 900  : large phones/tablets -> bottom navigation, 2 columns
///  - expanded >= 900 : tablets/desktop/web  -> top navigation like the website
enum WindowClass { compact, medium, expanded }

abstract final class Breakpoints {
  static const medium = 600.0;
  static const expanded = 900.0;
  static const contentMaxWidth = 1120.0;

  static WindowClass of(double width) => width >= expanded
      ? WindowClass.expanded
      : width >= medium
          ? WindowClass.medium
          : WindowClass.compact;
}

extension ResponsiveContext on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  WindowClass get windowClass => Breakpoints.of(width);
  bool get isCompact => windowClass == WindowClass.compact;
  bool get isExpanded => windowClass == WindowClass.expanded;

  /// Horizontal page padding that grows with the window.
  double get gutter => switch (windowClass) {
        WindowClass.compact => 20,
        WindowClass.medium => 32,
        WindowClass.expanded => 48,
      };
}
