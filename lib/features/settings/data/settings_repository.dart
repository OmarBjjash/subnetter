import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/entities/app_settings.dart';

class SettingsRepository {
  static const _kTheme = 'theme_mode';
  static const _kLocale = 'locale';

  Future<AppSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIdx = prefs.getInt(_kTheme) ?? ThemeMode.system.index;
    final lang = prefs.getString(_kLocale) ?? 'en';
    return AppSettings(
      themeMode: ThemeMode.values[themeIdx],
      locale: Locale(lang),
    );
  }

  Future<void> save(AppSettings s) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kTheme, s.themeMode.index);
    await prefs.setString(_kLocale, s.locale.languageCode);
  }
}