import 'app_breakpoints.dart';

/// Breakpoint-driven typography.
///
/// The OS text scale (`MediaQuery.textScaler`) is never overridden, clamped or
/// ignored: Flutter keeps applying it on top of these base sizes. We only nudge
/// the *base* sizes on very wide windows — where the extra pixels make small
/// text look tiny — and damp that nudge when the user already enlarged text so
/// the two factors cannot compound into overflow.
abstract final class ResponsiveTypography {
  const ResponsiveTypography._();

  /// Multiplier applied to every base font size in the text theme.
  static double fontSizeFactor({
    required WindowSizeClass sizeClass,
    double textScaleFactor = 1.0,
  }) {
    final boost = switch (sizeClass) {
      WindowSizeClass.compact ||
      WindowSizeClass.medium ||
      WindowSizeClass.expanded => 0.0,
      WindowSizeClass.large => 0.04,
      WindowSizeClass.extraLarge => 0.08,
    };
    if (boost == 0) return 1.0;

    final damp = (textScaleFactor - 1.0).clamp(0.0, 1.0);
    return 1.0 + boost * (1.0 - damp);
  }
}
