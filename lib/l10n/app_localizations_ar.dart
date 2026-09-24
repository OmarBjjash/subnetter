// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'سبنتّر';

  @override
  String get tabSubnet => 'الشبكات';

  @override
  String get tabCidr => 'معلومات CIDR';

  @override
  String get tabSettings => 'الإعدادات';

  @override
  String get subnetTitle => 'حاسبة الشبكات الفرعية';

  @override
  String get subnetSubtitle =>
      'قسّم شبكة إلى شبكات متساوية أو بأطوال متغيّرة (VLSM).';

  @override
  String get cidrTitle => 'معلومات CIDR';

  @override
  String get cidrSubtitle => 'تفاصيل كتلة IP/CIDR واحدة.';

  @override
  String get input => 'المدخلات';

  @override
  String get results => 'النتائج';

  @override
  String get cidrInfo => 'معلومات CIDR';

  @override
  String get ipCidrLabel => 'IP / CIDR';

  @override
  String get numberOfSubnets => 'عدد الشبكات';

  @override
  String get modeEqual => 'متساوية';

  @override
  String get modeVlsm => 'VLSM';

  @override
  String get calculate => 'احسب';

  @override
  String get network => 'عنوان الشبكة';

  @override
  String get broadcast => 'البث';

  @override
  String get firstUsable => 'أول عنوان متاح';

  @override
  String get lastUsable => 'آخر عنوان متاح';

  @override
  String get netmask => 'قناع الشبكة';

  @override
  String get wildcard => 'قناع عكسي';

  @override
  String get usableHosts => 'المضيفون المتاحون';

  @override
  String get totalAddresses => 'إجمالي العناوين';

  @override
  String get ipClass => 'فئة IP';

  @override
  String get private => 'خاص';

  @override
  String get settingsAppearance => 'المظهر';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get clear => 'مسح';
}
