import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import 'subnet_page.dart';
import 'cidr_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';

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

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _index, children: pages),
      ),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.ltr,
        child: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.call_split_outlined),
              selectedIcon: const Icon(Icons.call_split),
              label: l10n.tabSubnet,
            ),
            NavigationDestination(
              icon: const Icon(Icons.info_outline),
              selectedIcon: const Icon(Icons.info),
              label: l10n.tabCidr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings),
              label: l10n.tabSettings,
            ),
          ],
        ),
      ),
    );
  }
}
