import 'package:flutter/material.dart';

import '../../../../core/responsive/adaptive_scaffold.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import 'cidr_page.dart';
import 'subnet_page.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // NOTE: don't use a `static const` list here. The pages must be
    // regular (non-canonical) instances so that on theme / locale change
    // Flutter rebuilds them and re-registers their InheritedWidget
    // dependencies on the new elements. `static const` skips the rebuild
    // and leaves stale dependency references behind, which triggers
    // "not a descendant" assertions inside the framework.
    final pages = <Widget>[
      const SubnetPage(key: ValueKey('subnet_page')),
      const CidrPage(key: ValueKey('cidr_page')),
      const SettingsPage(key: ValueKey('settings_page')),
    ];

    // The selected tab lives here, so changing window size class (resize,
    // rotate, fold/unfold) swaps only the navigation chrome around it.
    return AdaptiveScaffold(
      destinations: [
        AdaptiveDestination(
          icon: Icons.hub_outlined,
          selectedIcon: Icons.hub_outlined,
          label: l10n.tabSubnet,
        ),
        AdaptiveDestination(
          icon: Icons.device_hub_rounded,
          selectedIcon: Icons.device_hub_rounded,
          label: l10n.tabCidr,
        ),
        AdaptiveDestination(
          icon: Icons.settings_outlined,
          selectedIcon: Icons.settings,
          label: l10n.tabSettings,
        ),
      ],
      selectedIndex: _index,
      onDestinationSelected: (i) => setState(() => _index = i),
      body: IndexedStack(index: _index, children: pages),
    );
  }
}
