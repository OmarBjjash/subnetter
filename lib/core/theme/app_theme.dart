import 'package:flutter/material.dart';
import 'package:subnetter/core/theme/app_components_theme.dart';

import 'app_colors.dart';
import 'app_colors_extension.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData light() => _base(
    brightness: Brightness.light,
    bg: AppColors.lightBg,
    surface: AppColors.lightSurface,
    surfaceVar: AppColors.lightSurfaceVar,
    primary: AppColors.lightPrimary,
    primaryCont: AppColors.lightPrimaryCont,
    onPrimary: AppColors.lightOnPrimary,
    secondary: AppColors.lightSecondary,
    text: AppColors.lightText,
    muted: AppColors.lightTextMuted,
    border: AppColors.lightBorder,
    code: AppColors.lightCode,
    success: AppColors.lightSuccess,
    danger: AppColors.lightError,
  );

  static ThemeData dark() => _base(
    brightness: Brightness.dark,
    bg: AppColors.darkBg,
    surface: AppColors.darkSurface,
    surfaceVar: AppColors.darkSurfaceVar,
    primary: AppColors.darkPrimary,
    primaryCont: AppColors.darkPrimaryCont,
    onPrimary: AppColors.darkOnPrimary,
    secondary: AppColors.darkSecondary,
    text: AppColors.darkText,
    muted: AppColors.darkTextMuted,
    border: AppColors.darkBorder,
    code: AppColors.darkCode,
    success: AppColors.darkSuccess,
    danger: AppColors.darkError,
  );

  static ThemeData _base({
    required Brightness brightness,
    required Color bg,
    required Color surface,
    required Color surfaceVar,
    required Color primary,
    required Color primaryCont,
    required Color onPrimary,
    required Color secondary,
    required Color text,
    required Color muted,
    required Color border,
    required Color code,
    required Color success,
    required Color danger,
  }) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryCont,
      onPrimaryContainer: text,
      secondary: secondary,
      onSecondary: onPrimary,
      surface: surface,
      onSurface: text,
      surfaceContainerHighest: surfaceVar,
      outline: border,
      error: danger,
      onError: onPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: bg,
      textTheme: AppTypography.textTheme.apply(
        bodyColor: text,
        displayColor: text,
      ),
      splashFactory: InkSparkle.splashFactory,

      extensions: [
        AppColorsExtension(
          textMuted: muted,
          border: border,
          codeBackground: code,
          success: success,
          danger: danger,
          sectionBackground: surface,
        ),
        brightness == Brightness.light
            ? AppComponentsTheme.light()
            : AppComponentsTheme.dark(),
      ],

      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        foregroundColor: text,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.textTheme.titleMedium?.copyWith(
          color: text,
        ),
      ),

      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: BorderSide(color: border, width: 1),
        ),
      ),

      dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVar,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        hintStyle: TextStyle(color: muted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: danger),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: text,
          side: BorderSide(color: border),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
      ),

      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? primaryCont : surfaceVar,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? primary : text,
          ),
          side: WidgetStateProperty.all(BorderSide(color: border)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
          ),
          textStyle: WidgetStateProperty.all(
            AppTypography.textTheme.labelLarge,
          ),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: primary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 68,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: 24,
            color: selected ? onPrimary : text.withOpacity(0.75),
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return AppTypography.textTheme.labelMedium?.copyWith(
            color: selected ? primary : text.withOpacity(0.75),
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          );
        }),
      ),

      listTileTheme: ListTileThemeData(
        iconColor: text,
        textColor: text,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
      ),

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: surfaceVar,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          border: Border.all(color: border),
        ),
        textStyle: AppTypography.textTheme.bodySmall?.copyWith(color: text),
      ),
    );
  }
}
