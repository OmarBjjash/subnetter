import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Makes scrolling feel native on pointer-driven devices.
///
/// Material's default behavior already wraps vertical scrollables in a
/// `Scrollbar` on desktop/web; this adds mouse dragging and trackpad panning so
/// a mouse user can also pull a list, and keeps touch behavior untouched.
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => const {
    PointerDeviceKind.touch,
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.mouse,
  };
}
