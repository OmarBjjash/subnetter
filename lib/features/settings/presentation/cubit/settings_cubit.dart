import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/settings_repository.dart';
import '../../domain/entities/app_settings.dart';

class SettingsCubit extends Cubit<AppSettings> {
  final SettingsRepository _repo;
  SettingsCubit(this._repo) : super(const AppSettings());

  Future<void> init() async => emit(await _repo.load());

  Future<void> setTheme(ThemeMode m) async {
    emit(state.copyWith(themeMode: m));
    await _repo.save(state);
  }

  Future<void> setLocale(Locale l) async {
    emit(state.copyWith(locale: l));
    await _repo.save(state);
  }
}