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

  static const _pages = [SubnetPage(), CidrPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _index, children: _pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.call_split_outlined),
            selectedIcon: const Icon(Icons.call_split),
            label: l10n.tabSubnet),
          NavigationDestination(icon: const Icon(Icons.info_outline),
            selectedIcon: const Icon(Icons.info),
            label: l10n.tabCidr),
          NavigationDestination(icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.tabSettings),
        ],
      ),
    );
  }
}