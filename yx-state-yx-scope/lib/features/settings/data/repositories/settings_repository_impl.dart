import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  @override
  Future<ThemeMode> getThemeMode() async {
    final value = await _prefs.getString('theme_mode');

    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.light,
    };
  }

  @override
  Future<Locale> getLocale() async {
    final value = await _prefs.getString('locale');

    if (value == null) return Locale('ru');

    return Locale(value);
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) {
    return _prefs.setString('theme_mode', mode.name);
  }

  @override
  Future<void> saveLocale(Locale locale) {
    return _prefs.setString('locale', locale.languageCode);
  }
}
