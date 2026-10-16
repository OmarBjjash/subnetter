import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// One navigable destination of the [AdaptiveScaffold].
@immutable
class AdaptiveDestination {
  const AdaptiveDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.tooltip,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;

  /// Hover tooltip. Falls back to [label] when null.
  final String? tooltip;
}

/// The navigation shell used on every window size class.
///
/// Navigation deliberately stays in a bottom `NavigationBar` at *every* size —
/// on wide windows the freed-up vertical space goes to the two-pane content
/// layout instead of a side rail.
///
/// The bar is always visible; the selected destination is owned by the caller,
/// so a window resize, rotation or fold/unfold never resets navigation state.
class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.body,
  });

  final List<AdaptiveDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return AdaptiveShortcuts(
      destinationCount: destinations.length,
      onDestinationSelected: onDestinationSelected,
      child: Scaffold(
        body: SafeArea(child: body),
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.ltr,
          child: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            destinations: [
              for (final d in destinations)
                NavigationDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: d.label,
                  tooltip: d.tooltip,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Desktop/web keyboard shortcuts for destination switching.
///
/// `Ctrl`/`Cmd` + `1…9` selects the matching destination. A focusable node is
/// installed so the shortcuts work before the user tabs into any control;
/// key events from focused children (text fields, rail items) bubble up here.
class AdaptiveShortcuts extends StatelessWidget {
  const AdaptiveShortcuts({
    super.key,
    required this.destinationCount,
    required this.onDestinationSelected,
    required this.child,
  });

  final int destinationCount;
  final ValueChanged<int> onDestinationSelected;
  final Widget child;

  static const List<LogicalKeyboardKey> _digits = [
    LogicalKeyboardKey.digit1,
    LogicalKeyboardKey.digit2,
    LogicalKeyboardKey.digit3,
    LogicalKeyboardKey.digit4,
    LogicalKeyboardKey.digit5,
    LogicalKeyboardKey.digit6,
    LogicalKeyboardKey.digit7,
    LogicalKeyboardKey.digit8,
    LogicalKeyboardKey.digit9,
  ];

  @override
  Widget build(BuildContext context) {
    final bindings = <ShortcutActivator, VoidCallback>{};
    final count = destinationCount < _digits.length
        ? destinationCount
        : _digits.length;
    for (var i = 0; i < count; i++) {
      bindings[SingleActivator(_digits[i], control: true)] = () =>
          onDestinationSelected(i);
      bindings[SingleActivator(_digits[i], meta: true)] = () =>
          onDestinationSelected(i);
    }

    return CallbackShortcuts(
      bindings: bindings,
      child: Focus(autofocus: true, child: child),
    );
  }
}
