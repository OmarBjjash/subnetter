import 'package:flutter/material.dart';

abstract final class AppTypography {
  static const _family = 'Inter'; // falls back to system if not bundled

  static TextTheme textTheme = const TextTheme(
    displaySmall:   TextStyle(fontFamily: _family, fontSize: 32, fontWeight: FontWeight.w600, letterSpacing: -0.5),
    headlineSmall:  TextStyle(fontFamily: _family, fontSize: 22, fontWeight: FontWeight.w600, letterSpacing: -0.2),
    titleMedium:    TextStyle(fontFamily: _family, fontSize: 16, fontWeight: FontWeight.w600),
    titleSmall:     TextStyle(fontFamily: _family, fontSize: 14, fontWeight: FontWeight.w600),
    bodyLarge:      TextStyle(fontFamily: _family, fontSize: 15, fontWeight: FontWeight.w400, height: 1.4),
    bodyMedium:     TextStyle(fontFamily: _family, fontSize: 13, fontWeight: FontWeight.w400, height: 1.4),
    bodySmall:      TextStyle(fontFamily: _family, fontSize: 12, fontWeight: FontWeight.w400, height: 1.35),
    labelLarge:     TextStyle(fontFamily: _family, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1),
    labelMedium:    TextStyle(fontFamily: _family, fontSize: 12, fontWeight: FontWeight.w500),
  );

  static const mono = TextStyle(
    fontFamily: 'monospace',
    fontFeatures: [FontFeature.tabularFigures()],
    fontSize: 13,
    height: 1.4,
  );
}