import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Subnetter'**
  String get appTitle;

  /// No description provided for @tabSubnet.
  ///
  /// In en, this message translates to:
  /// **'Subnets'**
  String get tabSubnet;

  /// No description provided for @tabCidr.
  ///
  /// In en, this message translates to:
  /// **'CIDR Info'**
  String get tabCidr;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;

  /// No description provided for @subnetTitle.
  ///
  /// In en, this message translates to:
  /// **'Subnet Calculator'**
  String get subnetTitle;

  /// No description provided for @subnetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Split a network into equal-size or VLSM subnets.'**
  String get subnetSubtitle;

  /// No description provided for @cidrTitle.
  ///
  /// In en, this message translates to:
  /// **'CIDR Information'**
  String get cidrTitle;

  /// No description provided for @cidrSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Details about a single IP/CIDR block.'**
  String get cidrSubtitle;

  /// No description provided for @input.
  ///
  /// In en, this message translates to:
  /// **'Input'**
  String get input;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @resultsEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a network, then press Calculate to see its subnets.'**
  String get resultsEmptyHint;

  /// No description provided for @cidrInfo.
  ///
  /// In en, this message translates to:
  /// **'CIDR information'**
  String get cidrInfo;

  /// No description provided for @cidrEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Enter an IP/CIDR, then press Calculate to see its details.'**
  String get cidrEmptyHint;

  /// No description provided for @ipCidrLabel.
  ///
  /// In en, this message translates to:
  /// **'IP / CIDR'**
  String get ipCidrLabel;

  /// No description provided for @numberOfSubnets.
  ///
  /// In en, this message translates to:
  /// **'Number of subnets'**
  String get numberOfSubnets;

  /// No description provided for @modeEqual.
  ///
  /// In en, this message translates to:
  /// **'Equal-size'**
  String get modeEqual;

  /// No description provided for @modeVlsm.
  ///
  /// In en, this message translates to:
  /// **'VLSM'**
  String get modeVlsm;

  /// No description provided for @calculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculate;

  /// No description provided for @network.
  ///
  /// In en, this message translates to:
  /// **'Network: '**
  String get network;

  /// No description provided for @broadcast.
  ///
  /// In en, this message translates to:
  /// **'Broadcast: '**
  String get broadcast;

  /// No description provided for @firstUsable.
  ///
  /// In en, this message translates to:
  /// **'First usable: '**
  String get firstUsable;

  /// No description provided for @lastUsable.
  ///
  /// In en, this message translates to:
  /// **'Last usable: '**
  String get lastUsable;

  /// No description provided for @netmask.
  ///
  /// In en, this message translates to:
  /// **'Netmask: '**
  String get netmask;

  /// No description provided for @wildcard.
  ///
  /// In en, this message translates to:
  /// **'Wildcard: '**
  String get wildcard;

  /// No description provided for @usableHosts.
  ///
  /// In en, this message translates to:
  /// **'Usable hosts: '**
  String get usableHosts;

  /// No description provided for @totalAddresses.
  ///
  /// In en, this message translates to:
  /// **'Total addresses: '**
  String get totalAddresses;

  /// No description provided for @ipClass.
  ///
  /// In en, this message translates to:
  /// **'IP class: '**
  String get ipClass;

  /// No description provided for @private.
  ///
  /// In en, this message translates to:
  /// **'Private: '**
  String get private;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms & definitions'**
  String get settingsTerms;

  /// No description provided for @settingsTermsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Plain-language explanations of the networking terms used in the app.'**
  String get settingsTermsSubtitle;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'A modern subnet calculator for all platforms.'**
  String get appDescription;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get versionLabel;

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Developer: '**
  String get developer;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms & definitions'**
  String get termsTitle;

  /// No description provided for @termsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Plain-language explanations of the networking terms used in the app.'**
  String get termsSubtitle;

  /// No description provided for @termCidr.
  ///
  /// In en, this message translates to:
  /// **'CIDR'**
  String get termCidr;

  /// No description provided for @termCidrDef.
  ///
  /// In en, this message translates to:
  /// **'Classless Inter-Domain Routing. A way of writing an IP address together with its network size as a single value, such as 192.168.0.0/24. The number after the slash is the prefix length.'**
  String get termCidrDef;

  /// No description provided for @termIpAddress.
  ///
  /// In en, this message translates to:
  /// **'IP address'**
  String get termIpAddress;

  /// No description provided for @termIpAddressDef.
  ///
  /// In en, this message translates to:
  /// **'A unique numeric label given to a device on a network so it can send and receive data. IPv4 addresses look like 192.168.0.10.'**
  String get termIpAddressDef;

  /// No description provided for @termSubnet.
  ///
  /// In en, this message translates to:
  /// **'Subnet'**
  String get termSubnet;

  /// No description provided for @termSubnetDef.
  ///
  /// In en, this message translates to:
  /// **'A smaller network carved out of a larger one. Splitting a network into subnets keeps traffic organized and reduces congestion.'**
  String get termSubnetDef;

  /// No description provided for @termSubnetMask.
  ///
  /// In en, this message translates to:
  /// **'Subnet mask'**
  String get termSubnetMask;

  /// No description provided for @termSubnetMaskDef.
  ///
  /// In en, this message translates to:
  /// **'A 32-bit number that marks which part of an IP address is the network and which part is the host, for example 255.255.255.0.'**
  String get termSubnetMaskDef;

  /// No description provided for @termPrefixLength.
  ///
  /// In en, this message translates to:
  /// **'Prefix length'**
  String get termPrefixLength;

  /// No description provided for @termPrefixLengthDef.
  ///
  /// In en, this message translates to:
  /// **'How many leading bits of the address belong to the network. Written after a slash, for example /24 means the first 24 bits are the network part.'**
  String get termPrefixLengthDef;

  /// No description provided for @termNetworkAddress.
  ///
  /// In en, this message translates to:
  /// **'Network address'**
  String get termNetworkAddress;

  /// No description provided for @termNetworkAddressDef.
  ///
  /// In en, this message translates to:
  /// **'The very first address in a subnet, where all host bits are zero. It identifies the subnet itself and cannot be assigned to a device.'**
  String get termNetworkAddressDef;

  /// No description provided for @termBroadcastAddress.
  ///
  /// In en, this message translates to:
  /// **'Broadcast address'**
  String get termBroadcastAddress;

  /// No description provided for @termBroadcastAddressDef.
  ///
  /// In en, this message translates to:
  /// **'The very last address in a subnet, where all host bits are one. Data sent here reaches every device in the subnet, so it cannot be assigned to one device.'**
  String get termBroadcastAddressDef;

  /// No description provided for @termFirstUsable.
  ///
  /// In en, this message translates to:
  /// **'First usable address'**
  String get termFirstUsable;

  /// No description provided for @termFirstUsableDef.
  ///
  /// In en, this message translates to:
  /// **'The first address after the network address. This is the lowest address you can actually give to a device.'**
  String get termFirstUsableDef;

  /// No description provided for @termLastUsable.
  ///
  /// In en, this message translates to:
  /// **'Last usable address'**
  String get termLastUsable;

  /// No description provided for @termLastUsableDef.
  ///
  /// In en, this message translates to:
  /// **'The address right before the broadcast address. This is the highest address you can give to a device.'**
  String get termLastUsableDef;

  /// No description provided for @termWildcard.
  ///
  /// In en, this message translates to:
  /// **'Wildcard mask'**
  String get termWildcard;

  /// No description provided for @termWildcardDef.
  ///
  /// In en, this message translates to:
  /// **'The bitwise inverse of the subnet mask. Where the mask has 1 the wildcard has 0 and vice versa; it is used in access lists and routing rules.'**
  String get termWildcardDef;

  /// No description provided for @termUsableHosts.
  ///
  /// In en, this message translates to:
  /// **'Usable hosts'**
  String get termUsableHosts;

  /// No description provided for @termUsableHostsDef.
  ///
  /// In en, this message translates to:
  /// **'How many devices can be given an address in the subnet. It is the total addresses minus the network address and the broadcast address.'**
  String get termUsableHostsDef;

  /// No description provided for @termTotalAddresses.
  ///
  /// In en, this message translates to:
  /// **'Total addresses'**
  String get termTotalAddresses;

  /// No description provided for @termTotalAddressesDef.
  ///
  /// In en, this message translates to:
  /// **'The full count of addresses in the subnet, including the network and broadcast addresses.'**
  String get termTotalAddressesDef;

  /// No description provided for @termIpClass.
  ///
  /// In en, this message translates to:
  /// **'IP class'**
  String get termIpClass;

  /// No description provided for @termIpClassDef.
  ///
  /// In en, this message translates to:
  /// **'A legacy grouping of IPv4 addresses (A, B or C) based on the first bits. It is shown for reference; modern networks use CIDR instead.'**
  String get termIpClassDef;

  /// No description provided for @termPrivateIp.
  ///
  /// In en, this message translates to:
  /// **'Private IP'**
  String get termPrivateIp;

  /// No description provided for @termPrivateIpDef.
  ///
  /// In en, this message translates to:
  /// **'An address reserved for use inside local networks (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16). Private addresses are not routed on the public internet.'**
  String get termPrivateIpDef;

  /// No description provided for @termVlsm.
  ///
  /// In en, this message translates to:
  /// **'VLSM'**
  String get termVlsm;

  /// No description provided for @termVlsmDef.
  ///
  /// In en, this message translates to:
  /// **'Variable Length Subnet Masking. Splitting a network into subnets of different sizes so each one gets only as many addresses as it needs.'**
  String get termVlsmDef;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @subnetMask.
  ///
  /// In en, this message translates to:
  /// **'Subnet mask'**
  String get subnetMask;

  /// No description provided for @ipAddress.
  ///
  /// In en, this message translates to:
  /// **'IP Address'**
  String get ipAddress;

  /// No description provided for @copySubnetInfo.
  ///
  /// In en, this message translates to:
  /// **'Copy subnet info'**
  String get copySubnetInfo;

  /// No description provided for @subNetCopied.
  ///
  /// In en, this message translates to:
  /// **'Subnet copied to clipboard'**
  String get subNetCopied;

  /// No description provided for @copyAllSubnets.
  ///
  /// In en, this message translates to:
  /// **'Copy all subnets'**
  String get copyAllSubnets;

  /// No description provided for @subnetsCopied.
  ///
  /// In en, this message translates to:
  /// **'All subnets copied to clipboard'**
  String get subnetsCopied;

  /// No description provided for @copyFormatBlocks.
  ///
  /// In en, this message translates to:
  /// **'Plain text blocks'**
  String get copyFormatBlocks;

  /// No description provided for @copyFormatBlocksHint.
  ///
  /// In en, this message translates to:
  /// **'Aligned fields, one block per subnet. Good for files.'**
  String get copyFormatBlocksHint;

  /// No description provided for @copyFormatMarkdown.
  ///
  /// In en, this message translates to:
  /// **'Markdown table'**
  String get copyFormatMarkdown;

  /// No description provided for @copyFormatMarkdownHint.
  ///
  /// In en, this message translates to:
  /// **'Renders as a table in Slack, Notion and GitHub.'**
  String get copyFormatMarkdownHint;

  /// No description provided for @subnetCountError.
  ///
  /// In en, this message translates to:
  /// **'Subnet count must be >= 1'**
  String get subnetCountError;

  /// No description provided for @cidrInfoCopied.
  ///
  /// In en, this message translates to:
  /// **'CIDR info copied'**
  String get cidrInfoCopied;

  /// No description provided for @copyCIDRInfo.
  ///
  /// In en, this message translates to:
  /// **'Copy CIDR info'**
  String get copyCIDRInfo;

  /// No description provided for @invalidOctet.
  ///
  /// In en, this message translates to:
  /// **'Invalid octet'**
  String get invalidOctet;

  /// No description provided for @invalidIPv4.
  ///
  /// In en, this message translates to:
  /// **'Invalid IPv4'**
  String get invalidIPv4;

  /// No description provided for @missingPrefix.
  ///
  /// In en, this message translates to:
  /// **'Missing \"/prefix\"'**
  String get missingPrefix;

  /// No description provided for @prefixOutOfRange.
  ///
  /// In en, this message translates to:
  /// **'Prefix must be between 0 and 32'**
  String get prefixOutOfRange;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get unexpectedError;

  /// No description provided for @tooManySubnets.
  ///
  /// In en, this message translates to:
  /// **'Too many subnets for this prefix'**
  String get tooManySubnets;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
