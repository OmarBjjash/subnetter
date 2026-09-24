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
  String get broadcast => 'عنوان البث';

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
  String get ipClass => 'فئة الـ IP';

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

  @override
  String get subnetMask => 'قناع الشبكه';

  @override
  String get ipAddress => 'عنوان الـ IP';

  @override
  String get copySubnetInfo => 'نسخ معلومات الشبكة';

  @override
  String get subNetCopied => 'تم نسخ معلومات الشبكه الى الحافظة';

  @override
  String get subnetCountError => 'يجب ان تكون عدد الشبكات المراد تقسيمها >= 1';

  @override
  String get cidrInfoCopied => 'تم نسخ معلومات شبكة الـ CIDR';

  @override
  String get copyCIDRInfo => 'نسخ معلومات شبكة الـ CIDR';

  @override
  String get invalidOctet => 'أُكتيت غير صالح';

  @override
  String get invalidIPv4 => 'IPv4 غير صالح';

  @override
  String get tooManySubnets => 'عدد كبير من الشبكات من هذا الـ prefix';
}
