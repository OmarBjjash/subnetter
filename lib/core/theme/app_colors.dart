import 'package:flutter/material.dart';

/// Warm, low-saturation palette — muted teal + amber.
/// No default blue/purple, no neon.
abstract final class AppColors {
  // Light
  static const lightBg              = Color(0xFFF7F4EF);
  static const lightSurface         = Color(0xFFFFFFFF);
  static const lightSurfaceVar      = Color(0xFFEFEBE3);
  static const lightPrimary         = Color(0xFF3D6E68);
  static const lightPrimaryCont     = Color(0xFFD6E4E0);
  static const lightOnPrimary       = Color(0xFFFFFFFF);
  static const lightSecondary       = Color(0xFFB8733D);
  static const lightText            = Color(0xFF2A2825);
  static const lightTextMuted       = Color(0xFF6E6862);
  static const lightBorder          = Color(0xFFE0DAD0);
  static const lightCode            = Color(0xFFF2EEE6);
  static const lightSuccess         = Color(0xFF5F7A4E);
  static const lightError           = Color(0xFFB54C3E);

  // Dark
  static const darkBg               = Color(0xFF191816);
  static const darkSurface          = Color(0xFF232120);
  static const darkSurfaceVar       = Color(0xFF2E2B28);
  static const darkPrimary          = Color(0xFF8FBFB7);
  static const darkPrimaryCont      = Color(0xFF2A4A46);
  static const darkOnPrimary        = Color(0xFF0F1A19);
  static const darkSecondary        = Color(0xFFD4945E);
  static const darkText             = Color(0xFFEDE9E2);
  static const darkTextMuted        = Color(0xFF9A938A);
  static const darkBorder           = Color(0xFF3A3633);
  static const darkCode             = Color(0xFF1E1C1A);
  static const darkSuccess          = Color(0xFFA8C092);
  static const darkError            = Color(0xFFE08A7C);
}