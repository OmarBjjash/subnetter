/// Single source of truth for window size classes.
///
/// Never hard-code these numbers anywhere else in the app: import
/// [AppBreakpoints] / [WindowSizeClass] instead.
library;

/// Window size class breakpoints, in logical pixels (dp).
///
/// These are the Material 3 window size classes.
abstract final class AppBreakpoints {
  const AppBreakpoints._();

  /// compact → medium (large phone landscape, small tablet).
  static const double mediumMin = 600;

  /// medium → expanded (tablet landscape, small desktop window).
  static const double expandedMin = 840;

  /// expanded → large (desktop).
  static const double largeMin = 1200;

  /// large → extraLarge (external monitor).
  static const double extraLargeMin = 1600;

  /// Widest a single column of text/form content is allowed to grow.
  static const double readableContentMaxWidth = 720;
}

/// Material 3 window size classes, derived from the *available* width.
enum WindowSizeClass {
  /// < 600 — phones (portrait/landscape), folded foldables.
  compact,

  /// 600–839 — large phones landscape, small tablets, unfolded foldable portrait.
  medium,

  /// 840–1199 — tablet landscape, small desktop windows.
  expanded,

  /// 1200–1599 — desktop.
  large,

  /// >= 1600 — large desktop / external monitors.
  extraLarge;

  /// Maps an available width to its window size class.
  static WindowSizeClass fromWidth(double width) => switch (width) {
    >= AppBreakpoints.extraLargeMin => WindowSizeClass.extraLarge,
    >= AppBreakpoints.largeMin => WindowSizeClass.large,
    >= AppBreakpoints.expandedMin => WindowSizeClass.expanded,
    >= AppBreakpoints.mediumMin => WindowSizeClass.medium,
    _ => WindowSizeClass.compact,
  };

  /// Ordering helpers so call sites read like `sizeClass >= WindowSizeClass.expanded`.
  bool operator >=(WindowSizeClass other) => index >= other.index;
  bool operator <=(WindowSizeClass other) => index <= other.index;
  bool operator >(WindowSizeClass other) => index > other.index;
  bool operator <(WindowSizeClass other) => index < other.index;

  bool get isCompact => this == WindowSizeClass.compact;
  bool get isMedium => this == WindowSizeClass.medium;

  /// Master–detail panes shown side by side.
  bool get supportsTwoPane => this >= WindowSizeClass.expanded;

  /// Desktop-class affordances (hover, shortcuts, visible scrollbars).
  bool get isDesktopClass => this >= WindowSizeClass.expanded;

  /// Horizontal page gutter, stepping up with the window width.
  double get gutter => switch (this) {
    WindowSizeClass.compact => 16,
    WindowSizeClass.medium => 24,
    WindowSizeClass.expanded => 32,
    WindowSizeClass.large => 40,
    WindowSizeClass.extraLarge => 48,
  };

  /// Vertical gap between stacked blocks on a page.
  double get blockGap => switch (this) {
    WindowSizeClass.compact => 16,
    WindowSizeClass.medium => 20,
    WindowSizeClass.expanded => 24,
    WindowSizeClass.large => 24,
    WindowSizeClass.extraLarge => 28,
  };

  /// Max width for a single column of content before it is centered.
  double get contentMaxWidth => switch (this) {
    WindowSizeClass.compact || WindowSizeClass.medium => double.infinity,
    WindowSizeClass.expanded => 1000,
    WindowSizeClass.large => 1200,
    WindowSizeClass.extraLarge => 1400,
  };
}
