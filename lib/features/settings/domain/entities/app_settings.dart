import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  final ThemeMode themeMode;
  final Locale locale;

  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('en'),
  });

  AppSettings copyWith({ThemeMode? themeMode, Locale? locale}) =>
    AppSettings(themeMode: themeMode ?? this.themeMode, locale: locale ?? this.locale);

  @override
  List<Object?> get props => [themeMode, locale];
}