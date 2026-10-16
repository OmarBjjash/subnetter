import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'app_breakpoints.dart';
import 'responsive_metrics.dart';

/// Master–detail container.
///
/// Shows [primary] and [secondary] side by side once the available width
/// reaches [minTwoPaneWidth]; below that [singlePane] is shown instead — pass
/// the combined, single-scroll version of both here. When [singlePane] is null
/// [primary] is used as the fallback.
///
/// [primary] is always pinned to the physical right-hand side, in both text
/// directions — the row order is flipped for LTR so the input pane does not
/// change sides when the language changes.
///
/// On a book-posture foldable the crease becomes the gap between the two panes,
/// so neither pane is ever drawn under the hinge.
class AdaptiveTwoPane extends StatelessWidget {
  const AdaptiveTwoPane({
    super.key,
    required this.primary,
    this.secondary,
    this.singlePane,
    this.primaryFlex = 1,
    this.secondaryFlex = 1,
    this.gap = AppSpacing.lg,
    this.minTwoPaneWidth = AppBreakpoints.expandedMin,
  });

  final Widget primary;
  final Widget? secondary;

  /// Narrow-window layout: both sections in one scroll.
  final Widget? singlePane;

  final int primaryFlex;
  final int secondaryFlex;
  final double gap;
  final double minTwoPaneWidth;

  @override
  Widget build(BuildContext context) {
    final detail = secondary;
    final stacked = singlePane ?? primary;
    if (detail == null) return stacked;

    return ResponsiveBuilder(
      builder: (context, metrics) {
        if (metrics.width < minTwoPaneWidth) return stacked;

        final hingeGap = metrics.fold.isBook ? metrics.fold.verticalGap : 0.0;
        final spacer = SizedBox(width: hingeGap > 0 ? hingeGap : gap);

        final primaryPane = Expanded(flex: primaryFlex, child: primary);
        final secondaryPane = Expanded(flex: secondaryFlex, child: detail);

        // A row lays its first child at the start edge, which is the left in
        // LTR and the right in RTL — so the order is reversed for LTR to keep
        // [primary] on the right in both directions.
        final isLtr = Directionality.of(context) == TextDirection.ltr;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: isLtr
              ? [secondaryPane, spacer, primaryPane]
              : [primaryPane, spacer, secondaryPane],
        );
      },
    );
  }
}
