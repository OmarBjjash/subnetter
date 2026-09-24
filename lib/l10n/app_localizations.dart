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

  /// No description provided for @cidrInfo.
  ///
  /// In en, this message translates to:
  /// **'CIDR information'**
  String get cidrInfo;

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
  /// **'Network'**
  String get network;

  /// No description provided for @broadcast.
  ///
  /// In en, this message translates to:
  /// **'Broadcast'**
  String get broadcast;

  /// No description provided for @firstUsable.
  ///
  /// In en, this message translates to:
  /// **'First usable'**
  String get firstUsable;

  /// No description provided for @lastUsable.
  ///
  /// In en, this message translates to:
  /// **'Last usable'**
  String get lastUsable;

  /// No description provided for @netmask.
  ///
  /// In en, this message translates to:
  /// **'Netmask'**
  String get netmask;

  /// No description provided for @wildcard.
  ///
  /// In en, this message translates to:
  /// **'Wildcard'**
  String get wildcard;

  /// No description provided for @usableHosts.
  ///
  /// In en, this message translates to:
  /// **'Usable hosts'**
  String get usableHosts;

  /// No description provided for @totalAddresses.
  ///
  /// In en, this message translates to:
  /// **'Total addresses'**
  String get totalAddresses;

  /// No description provided for @ipClass.
  ///
  /// In en, this message translates to:
  /// **'IP class'**
  String get ipClass;

  /// No description provided for @private.
  ///
  /// In en, this message translates to:
  /// **'Private'**
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
