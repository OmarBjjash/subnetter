// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Subnetter';

  @override
  String get tabSubnet => 'Subnets';

  @override
  String get tabCidr => 'CIDR Info';

  @override
  String get tabSettings => 'Settings';

  @override
  String get subnetTitle => 'Subnet Calculator';

  @override
  String get subnetSubtitle =>
      'Split a network into equal-size or VLSM subnets.';

  @override
  String get cidrTitle => 'CIDR Information';

  @override
  String get cidrSubtitle => 'Details about a single IP/CIDR block.';

  @override
  String get input => 'Input';

  @override
  String get results => 'Results';

  @override
  String get cidrInfo => 'CIDR information';

  @override
  String get ipCidrLabel => 'IP / CIDR';

  @override
  String get numberOfSubnets => 'Number of subnets';

  @override
  String get modeEqual => 'Equal-size';

  @override
  String get modeVlsm => 'VLSM';

  @override
  String get calculate => 'Calculate';

  @override
  String get network => 'Network';

  @override
  String get broadcast => 'Broadcast';

  @override
  String get firstUsable => 'First usable';

  @override
  String get lastUsable => 'Last usable';

  @override
  String get netmask => 'Netmask';

  @override
  String get wildcard => 'Wildcard';

  @override
  String get usableHosts => 'Usable hosts';

  @override
  String get totalAddresses => 'Total addresses';

  @override
  String get ipClass => 'IP class';

  @override
  String get private => 'Private';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get clear => 'Clear';
}
