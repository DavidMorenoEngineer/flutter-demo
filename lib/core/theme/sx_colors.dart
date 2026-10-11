import 'package:flutter/painting.dart';

/// Design tokens read from the public SideKix site's CSS: a warm near-black
/// canvas, gold accents, and a muted parchment text scale.
abstract final class SxColors {
  static const bgDeep = Color(0xFF060502);
  static const bg = Color(0xFF0E0C09);
  static const surface = Color(0xFF17150E);
  static const surfaceHigh = Color(0xFF26241F);
  static const line = Color(0xFF3C3A35);

  static const gold = Color(0xFFD4A856);
  static const goldLight = Color(0xFFF3E4A8);
  static const goldBright = Color(0xFFFFD166);
  static const goldInk = Color(0xFF1B1400);

  static const text = Color(0xFFDDD8CA);
  static const textSoft = Color(0xFFCEC9BC);
  static const muted = Color(0xFFB7AF9E);
  static const dim = Color(0xFF877F6F);

  static const coral = Color(0xFFFF6367);
  static const teal = Color(0xFF5FB6A6);
  static const sky = Color(0xFF6FB0E0);
  static const violet = Color(0xFFB18BE4);
}
