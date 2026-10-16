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
  String get resultsEmptyHint =>
      'Enter a network, then press Calculate to see its subnets.';

  @override
  String get cidrInfo => 'CIDR information';

  @override
  String get cidrEmptyHint =>
      'Enter an IP/CIDR, then press Calculate to see its details.';

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
  String get network => 'Network: ';

  @override
  String get broadcast => 'Broadcast: ';

  @override
  String get firstUsable => 'First usable: ';

  @override
  String get lastUsable => 'Last usable: ';

  @override
  String get netmask => 'Netmask: ';

  @override
  String get wildcard => 'Wildcard: ';

  @override
  String get usableHosts => 'Usable hosts: ';

  @override
  String get totalAddresses => 'Total addresses: ';

  @override
  String get ipClass => 'IP class: ';

  @override
  String get private => 'Private: ';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsTerms => 'Terms & definitions';

  @override
  String get settingsTermsSubtitle =>
      'Plain-language explanations of the networking terms used in the app.';

  @override
  String get settingsAbout => 'About';

  @override
  String get appDescription => 'A modern subnet calculator for all platforms.';

  @override
  String get versionLabel => 'Version';

  @override
  String get developer => 'Developer: ';

  @override
  String get termsTitle => 'Terms & definitions';

  @override
  String get termsSubtitle =>
      'Plain-language explanations of the networking terms used in the app.';

  @override
  String get termCidr => 'CIDR';

  @override
  String get termCidrDef =>
      'Classless Inter-Domain Routing. A way of writing an IP address together with its network size as a single value, such as 192.168.0.0/24. The number after the slash is the prefix length.';

  @override
  String get termIpAddress => 'IP address';

  @override
  String get termIpAddressDef =>
      'A unique numeric label given to a device on a network so it can send and receive data. IPv4 addresses look like 192.168.0.10.';

  @override
  String get termSubnet => 'Subnet';

  @override
  String get termSubnetDef =>
      'A smaller network carved out of a larger one. Splitting a network into subnets keeps traffic organized and reduces congestion.';

  @override
  String get termSubnetMask => 'Subnet mask';

  @override
  String get termSubnetMaskDef =>
      'A 32-bit number that marks which part of an IP address is the network and which part is the host, for example 255.255.255.0.';

  @override
  String get termPrefixLength => 'Prefix length';

  @override
  String get termPrefixLengthDef =>
      'How many leading bits of the address belong to the network. Written after a slash, for example /24 means the first 24 bits are the network part.';

  @override
  String get termNetworkAddress => 'Network address';

  @override
  String get termNetworkAddressDef =>
      'The very first address in a subnet, where all host bits are zero. It identifies the subnet itself and cannot be assigned to a device.';

  @override
  String get termBroadcastAddress => 'Broadcast address';

  @override
  String get termBroadcastAddressDef =>
      'The very last address in a subnet, where all host bits are one. Data sent here reaches every device in the subnet, so it cannot be assigned to one device.';

  @override
  String get termFirstUsable => 'First usable address';

  @override
  String get termFirstUsableDef =>
      'The first address after the network address. This is the lowest address you can actually give to a device.';

  @override
  String get termLastUsable => 'Last usable address';

  @override
  String get termLastUsableDef =>
      'The address right before the broadcast address. This is the highest address you can give to a device.';

  @override
  String get termWildcard => 'Wildcard mask';

  @override
  String get termWildcardDef =>
      'The bitwise inverse of the subnet mask. Where the mask has 1 the wildcard has 0 and vice versa; it is used in access lists and routing rules.';

  @override
  String get termUsableHosts => 'Usable hosts';

  @override
  String get termUsableHostsDef =>
      'How many devices can be given an address in the subnet. It is the total addresses minus the network address and the broadcast address.';

  @override
  String get termTotalAddresses => 'Total addresses';

  @override
  String get termTotalAddressesDef =>
      'The full count of addresses in the subnet, including the network and broadcast addresses.';

  @override
  String get termIpClass => 'IP class';

  @override
  String get termIpClassDef =>
      'A legacy grouping of IPv4 addresses (A, B or C) based on the first bits. It is shown for reference; modern networks use CIDR instead.';

  @override
  String get termPrivateIp => 'Private IP';

  @override
  String get termPrivateIpDef =>
      'An address reserved for use inside local networks (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16). Private addresses are not routed on the public internet.';

  @override
  String get termVlsm => 'VLSM';

  @override
  String get termVlsmDef =>
      'Variable Length Subnet Masking. Splitting a network into subnets of different sizes so each one gets only as many addresses as it needs.';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get clear => 'Clear';

  @override
  String get subnetMask => 'Subnet mask';

  @override
  String get ipAddress => 'IP Address';

  @override
  String get copySubnetInfo => 'Copy subnet info';

  @override
  String get subNetCopied => 'Subnet copied to clipboard';

  @override
  String get copyAllSubnets => 'Copy all subnets';

  @override
  String get subnetsCopied => 'All subnets copied to clipboard';

  @override
  String get copyFormatBlocks => 'Plain text blocks';

  @override
  String get copyFormatBlocksHint =>
      'Aligned fields, one block per subnet. Good for files.';

  @override
  String get copyFormatMarkdown => 'Markdown table';

  @override
  String get copyFormatMarkdownHint =>
      'Renders as a table in Slack, Notion and GitHub.';

  @override
  String get subnetCountError => 'Subnet count must be >= 1';

  @override
  String get cidrInfoCopied => 'CIDR info copied';

  @override
  String get copyCIDRInfo => 'Copy CIDR info';

  @override
  String get invalidOctet => 'Invalid octet';

  @override
  String get invalidIPv4 => 'Invalid IPv4';

  @override
  String get missingPrefix => 'Missing \"/prefix\"';

  @override
  String get prefixOutOfRange => 'Prefix must be between 0 and 32';

  @override
  String get unexpectedError => 'Something went wrong. Please try again.';

  @override
  String get tooManySubnets => 'Too many subnets for this prefix';
}
