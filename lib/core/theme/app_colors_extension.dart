import 'package:flutter/material.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color textMuted;
  final Color border;
  final Color codeBackground;
  final Color success;
  final Color danger;
  final Color sectionBackground;

  const AppColorsExtension({
    required this.textMuted,
    required this.border,
    required this.codeBackground,
    required this.success,
    required this.danger,
    required this.sectionBackground,
  });

  @override
  AppColorsExtension copyWith({
    Color? textMuted, Color? border, Color? codeBackground,
    Color? success, Color? danger, Color? sectionBackground,
  }) => AppColorsExtension(
    textMuted: textMuted ?? this.textMuted,
    border: border ?? this.border,
    codeBackground: codeBackground ?? this.codeBackground,
    success: success ?? this.success,
    danger: danger ?? this.danger,
    sectionBackground: sectionBackground ?? this.sectionBackground,
  );

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      border: Color.lerp(border, other.border, t)!,
      codeBackground: Color.lerp(codeBackground, other.codeBackground, t)!,
      success: Color.lerp(success, other.success, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      sectionBackground: Color.lerp(sectionBackground, other.sectionBackground, t)!,
    );
  }
}

extension AppThemeX on BuildContext {
  AppColorsExtension get ext => Theme.of(this).extension<AppColorsExtension>()!;
}