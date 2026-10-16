import 'dart:ui' show DisplayFeature, DisplayFeatureType;

import 'package:flutter/material.dart';

import 'app_breakpoints.dart';

/// Fold / hinge facts about the current window, derived from
/// `MediaQueryData.displayFeatures`.
///
/// `DisplayFeature.bounds` are reported in logical pixels by the engine, so no
/// device-pixel-ratio conversion is needed.
@immutable
class FoldInfo {
  const FoldInfo({this.hingeAxis, this.hingeBounds});

  /// No hinge or fold (phones, tablets, desktop windows).
  static const FoldInfo none = FoldInfo();

  /// Orientation of the crease: vertical separates left/right, horizontal
  /// separates top/bottom.
  final Axis? hingeAxis;

  /// Bounds of the obstructed strip, in the coordinate space of the Flutter view.
  final Rect? hingeBounds;

  bool get hasHinge => hingeAxis != null;

  /// Book posture — the window is split into left and right panes.
  bool get isBook => hingeAxis == Axis.vertical;

  /// Tabletop / half-opened posture — the window is split top and bottom.
  bool get isTabletop => hingeAxis == Axis.horizontal;

  /// Logical width of the obstructed strip when the hinge is vertical.
  double get verticalGap => isBook ? (hingeBounds?.width ?? 0) : 0;

  /// Logical height of the obstructed strip when the hinge is horizontal.
  double get horizontalGap => isTabletop ? (hingeBounds?.height ?? 0) : 0;

  /// Only real folds/hinges are considered: cutouts are handled by `SafeArea`.
  factory FoldInfo.fromDisplayFeatures(List<DisplayFeature>? features) {
    if (features == null || features.isEmpty) return FoldInfo.none;

    final folds = features
        .where(
          (f) =>
              (f.type == DisplayFeatureType.hinge ||
                  f.type == DisplayFeatureType.fold) &&
              f.bounds.width > 0 &&
              f.bounds.height > 0,
        )
        .toList(growable: false);
    if (folds.isEmpty) return FoldInfo.none;

    final f = folds.first;
    return FoldInfo(
      hingeAxis: f.bounds.width > f.bounds.height
          ? Axis.vertical
          : Axis.horizontal,
      hingeBounds: f.bounds,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is FoldInfo &&
      other.hingeAxis == hingeAxis &&
      other.hingeBounds == hingeBounds;

  @override
  int get hashCode => Object.hash(hingeAxis, hingeBounds);
}

/// A snapshot of the space the app is allowed to draw in.
///
/// Deliberately built from `BoxConstraints` (via [ResponsiveBuilder]) rather
/// than the device size, so it stays correct inside split views, nested
/// widgets and resizable desktop windows.
@immutable
class ResponsiveMetrics {
  const ResponsiveMetrics({
    required this.sizeClass,
    required this.size,
    required this.safePadding,
    required this.textScaler,
    required this.fold,
  });

  /// Derives metrics from a `MediaQueryData` (fallback when no
  /// [ResponsiveBuilder] ancestor exists).
  factory ResponsiveMetrics.fromMediaQueryData(MediaQueryData data) =>
      ResponsiveMetrics(
        sizeClass: WindowSizeClass.fromWidth(data.size.width),
        size: data.size,
        safePadding: data.padding,
        textScaler: data.textScaler,
        fold: FoldInfo.fromDisplayFeatures(data.displayFeatures),
      );

  final WindowSizeClass sizeClass;

  /// Available space, not the physical screen size.
  final Size size;

  /// Notch / punch-hole / gesture-bar insets. Zero on desktop.
  final EdgeInsets safePadding;

  /// The user's OS font scaling — passed through untouched, never clamped.
  final TextScaler textScaler;

  final FoldInfo fold;

  double get width => size.width;
  double get height => size.height;

  /// Window shaped landscape (derived from the window, not the sensor).
  bool get isLandscape => size.width >= size.height;

  /// Effective OS text scale, 1.0 being the platform default.
  double get textScaleFactor => textScaler.scale(14) / 14;

  @override
  bool operator ==(Object other) =>
      other is ResponsiveMetrics &&
      other.sizeClass == sizeClass &&
      other.size == size &&
      other.safePadding == safePadding &&
      other.textScaler == textScaler &&
      other.fold == fold;

  @override
  int get hashCode =>
      Object.hash(sizeClass, size, safePadding, textScaler, fold);
}

/// Publishes [ResponsiveMetrics] to the subtree below.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, ResponsiveMetrics metrics)
  builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final data = _mediaQueryDataOf(context);
        final width = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : data.size.width;
        final height = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : data.size.height;

        final metrics = ResponsiveMetrics(
          sizeClass: WindowSizeClass.fromWidth(width),
          size: Size(width, height),
          safePadding: data.padding,
          textScaler: data.textScaler,
          fold: FoldInfo.fromDisplayFeatures(data.displayFeatures),
        );

        return _ResponsiveScope(
          metrics: metrics,
          child: Builder(builder: (context) => builder(context, metrics)),
        );
      },
    );
  }
}

/// Reads the window `MediaQuery`, falling back to the root view when called
/// above `MaterialApp` (where no `MediaQuery` exists yet).
MediaQueryData _mediaQueryDataOf(BuildContext context) {
  final data = MediaQuery.maybeOf(context);
  if (data != null) return data;

  final view = View.maybeOf(context);
  if (view != null) return MediaQueryData.fromView(view);

  return MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.first,
  );
}

class _ResponsiveScope extends InheritedWidget {
  const _ResponsiveScope({required this.metrics, required super.child});

  final ResponsiveMetrics metrics;

  static ResponsiveMetrics? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ResponsiveScope>()?.metrics;

  @override
  bool updateShouldNotify(_ResponsiveScope oldWidget) =>
      metrics != oldWidget.metrics;
}

extension ResponsiveContextX on BuildContext {
  /// Metrics of the nearest enclosing [ResponsiveBuilder].
  ///
  /// When the app is not wrapped in one (tests, isolated widgets) the metrics
  /// fall back to the window `MediaQuery`.
  ResponsiveMetrics get responsive =>
      _ResponsiveScope.maybeOf(this) ??
      ResponsiveMetrics.fromMediaQueryData(_mediaQueryDataOf(this));

  /// Shorthand for `context.responsive.sizeClass`.
  WindowSizeClass get sizeClass => responsive.sizeClass;

  /// Centers a column of content and caps its width so text lines and forms
  /// stay readable on wide windows.
  Widget constrainContentWidth(Widget child) => Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: sizeClass.contentMaxWidth),
      child: child,
    ),
  );
}
