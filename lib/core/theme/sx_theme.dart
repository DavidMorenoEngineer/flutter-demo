import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'sx_colors.dart';

/// Switch for web-font loading. `google_fonts` fetches over the network, so
/// tests turn it off and fall back to the platform font.
abstract final class SxFonts {
  static bool enabled = true;
}

/// Typography follows the site: Cormorant Garamond for display, Poppins for
/// body copy, Space Grotesk for small uppercase labels.
abstract final class SxText {
  static TextStyle display(double size, {Color color = SxColors.goldLight, FontWeight weight = FontWeight.w600}) {
    final base = TextStyle(fontSize: size, height: 1.05, fontWeight: weight, color: color);
    return SxFonts.enabled ? GoogleFonts.cormorantGaramond(textStyle: base) : base;
  }

  static TextStyle body(double size, {Color color = SxColors.text, FontWeight weight = FontWeight.w400}) {
    final base = TextStyle(fontSize: size, height: 1.55, fontWeight: weight, color: color);
    return SxFonts.enabled ? GoogleFonts.poppins(textStyle: base) : base;
  }

  static TextStyle label({double size = 11, Color color = SxColors.gold}) {
    final base = TextStyle(fontSize: size, height: 1.2, fontWeight: FontWeight.w600, letterSpacing: 1.6, color: color);
    return SxFonts.enabled ? GoogleFonts.spaceGrotesk(textStyle: base) : base;
  }
}

abstract final class SxTheme {
  static ThemeData get dark {
    const scheme = ColorScheme.dark(
      surface: SxColors.surface,
      onSurface: SxColors.text,
      primary: SxColors.gold,
      onPrimary: SxColors.goldInk,
      secondary: SxColors.goldLight,
      onSecondary: SxColors.goldInk,
      outline: SxColors.line,
      error: SxColors.coral,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: SxColors.bg,
      fontFamily: SxFonts.enabled ? GoogleFonts.poppins().fontFamily : null,
      splashFactory: InkSparkle.splashFactory,
      dividerColor: SxColors.line,
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(color: SxColors.surfaceHigh, borderRadius: BorderRadius.circular(6)),
        textStyle: SxText.body(12),
      ),
    );
  }
}
