// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Subnetter';

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
  String get resultsEmptyHint =>
      'أدخل الشبكة ثم اضغط «احسب» لعرض الشبكات الفرعية.';

  @override
  String get cidrInfo => 'معلومات CIDR';

  @override
  String get cidrEmptyHint =>
      'أدخل عنوان IP/CIDR ثم اضغط «احسب» لعرض التفاصيل.';

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
  String get network => 'عنوان الشبكة: ';

  @override
  String get broadcast => 'عنوان البث: ';

  @override
  String get firstUsable => 'أول عنوان متاح: ';

  @override
  String get lastUsable => 'آخر عنوان متاح: ';

  @override
  String get netmask => 'قناع الشبكة: ';

  @override
  String get wildcard => 'قناع عكسي: ';

  @override
  String get usableHosts => 'المضيفون المتاحون: ';

  @override
  String get totalAddresses => 'إجمالي العناوين: ';

  @override
  String get ipClass => 'فئة الـ IP: ';

  @override
  String get private => 'خاص: ';

  @override
  String get settingsAppearance => 'المظهر';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsTerms => 'المصطلحات والتعريفات';

  @override
  String get settingsTermsSubtitle =>
      'شرح مبسّط للمصطلحات الشبكية المستخدمة في التطبيق.';

  @override
  String get settingsAbout => 'حول التطبيق';

  @override
  String get appDescription => 'حاسبة شبكات فرعية حديثة تعمل على جميع المنصات.';

  @override
  String get versionLabel => 'الإصدار';

  @override
  String get developer => 'تطوير: ';

  @override
  String get termsTitle => 'المصطلحات والتعريفات';

  @override
  String get termsSubtitle =>
      'شرح مبسّط للمصطلحات الشبكية المستخدمة في التطبيق.';

  @override
  String get termCidr => 'CIDR';

  @override
  String get termCidrDef =>
      'التوجيه بين النطاقات بلا فئات (Classless Inter-Domain Routing). طريقة لكتابة عنوان IP مع حجم الشبكة في قيمة واحدة، مثل 192.168.0.0/24. الرقم بعد الشرطة المائلة هو طول البادئة.';

  @override
  String get termIpAddress => 'عنوان IP';

  @override
  String get termIpAddressDef =>
      'تسمية رقمية فريدة تُمنح لجهاز على الشبكة ليتمكن من إرسال البيانات واستقبالها. تبدو عناوين IPv4 هكذا 192.168.0.10.';

  @override
  String get termSubnet => 'الشبكة الفرعية (Subnet)';

  @override
  String get termSubnetDef =>
      'شبكة أصغر مقتطعة من شبكة أكبر. تقسيم الشبكة إلى شبكات فرعية ينظّم حركة المرور ويقلّل الازدحام.';

  @override
  String get termSubnetMask => 'قناع الشبكة الفرعية (Subnet mask)';

  @override
  String get termSubnetMaskDef =>
      'عدد من 32 بت يحدّد أي جزء من عنوان IP هو الشبكة وأي جزء هو المضيف، مثل 255.255.255.0.';

  @override
  String get termPrefixLength => 'طول البادئة (Prefix Length)';

  @override
  String get termPrefixLengthDef =>
      'عدد البتات الأولى من العنوان التي تنتمي إلى الشبكة. يُكتب بعد الشرطة المائلة، فمثلًا /24 يعني أن أول 24 بت هي جزء الشبكة.';

  @override
  String get termNetworkAddress => 'عنوان الشبكة (Network Address)';

  @override
  String get termNetworkAddressDef =>
      'أول عنوان في الشبكة الفرعية، حيث تكون جميع بتات المضيف صفرًا. يحدّد الشبكة الفرعية نفسها ولا يمكن منحه لجهاز.';

  @override
  String get termBroadcastAddress => 'عنوان البث (Broadcast Address)';

  @override
  String get termBroadcastAddressDef =>
      'آخر عنوان في الشبكة الفرعية، حيث تكون جميع بتات المضيف واحدًا. البيانات المرسلة إليه تصل إلى كل الأجهزة في الشبكة الفرعية، لذا لا يمكن منحه لجهاز واحد.';

  @override
  String get termFirstUsable => 'أول عنوان متاح (First Usable Address)';

  @override
  String get termFirstUsableDef =>
      'أول عنوان بعد عنوان الشبكة. وهو أدنى عنوان يمكن فعليًا منحه لجهاز.';

  @override
  String get termLastUsable => 'آخر عنوان متاح (Last Usable Address)';

  @override
  String get termLastUsableDef =>
      'العنوان الذي يسبق عنوان البث مباشرة. وهو أعلى عنوان يمكن منحه لجهاز.';

  @override
  String get termWildcard => 'القناع العكسي (Wildcard)';

  @override
  String get termWildcardDef =>
      'المعكوس البتّي لقناع الشبكة الفرعية. حيث يكون في القناع 1 يكون في العكسي 0 والعكس صحيح؛ ويُستخدم في قوائم الوصول وقواعد التوجيه.';

  @override
  String get termUsableHosts => 'المضيفون المتاحون (Usable hosts)';

  @override
  String get termUsableHostsDef =>
      'عدد الأجهزة التي يمكن منحها عنوانًا في الشبكة الفرعية. وهو إجمالي العناوين ناقص عنوان الشبكة وعنوان البث.';

  @override
  String get termTotalAddresses => 'إجمالي العناوين';

  @override
  String get termTotalAddressesDef =>
      'العدد الكامل للعناوين في الشبكة الفرعية، بما في ذلك عنوان الشبكة وعنوان البث.';

  @override
  String get termIpClass => 'IP Class \'فئة الـ IP\'';

  @override
  String get termIpClassDef =>
      'تصنيف قديم لعناوين IPv4 (A أو B أو C) بناءً على البتات الأولى. يُعرض للعلم فقط؛ فالشبكات الحديثة تستخدم CIDR بدلًا منه.';

  @override
  String get termPrivateIp => 'عنوان IP الخاص';

  @override
  String get termPrivateIpDef =>
      'عنوان محجوز للاستخدام داخل الشبكات المحلية (10.0.0.0/8 و 172.16.0.0/12 و 192.168.0.0/16). العناوين الخاصة لا تُوجَّه عبر الإنترنت العام.';

  @override
  String get termVlsm => 'VLSM';

  @override
  String get termVlsmDef =>
      'أقنعة الشبكات الفرعية متغيّرة الطول (Variable Length Subnet Masking). تقسيم الشبكة إلى شبكات فرعية بأحجام مختلفة لتحصل كل شبكة على عدد العناوين الذي تحتاجه فقط.';

  @override
  String get themeSystem => 'حسب النظام';

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
  String get copyAllSubnets => 'نسخ كل الشبكات الفرعية';

  @override
  String get subnetsCopied => 'تم نسخ كل الشبكات الفرعية إلى الحافظة';

  @override
  String get copyFormatBlocks => 'نص عادي';

  @override
  String get copyFormatBlocksHint =>
      'حقول متراصة، كتلة لكل شبكة فرعية. مناسبة للملفات.';

  @override
  String get copyFormatMarkdown => 'جدول Markdown';

  @override
  String get copyFormatMarkdownHint => 'يظهر كجدول في Slack وNotion وGitHub.';

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
  String get missingPrefix => 'الصيغة تنقصها البادئة \"/prefix\"';

  @override
  String get prefixOutOfRange => 'يجب أن تكون البادئة بين 0 و 32';

  @override
  String get unexpectedError => 'حدث خطأ غير متوقع. حاول مرة أخرى.';

  @override
  String get tooManySubnets => 'عدد كبير من الشبكات من هذا الـ prefix';
}
