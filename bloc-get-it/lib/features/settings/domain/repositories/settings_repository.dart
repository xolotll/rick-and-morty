import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  Future<ThemeMode> getThemeMode() async {
    final value = await _prefs.getString('theme_mode');

    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.light,
    };
  }

  Future<Locale?> getLocale() async {
    final value = await _prefs.getString('locale');

    if (value == null) return null;

    return Locale(value);
  }

  Future<void> saveThemeMode(ThemeMode mode) {
    return _prefs.setString('theme_mode', mode.name);
  }

  Future<void> saveLocale(Locale locale) {
    return _prefs.setString('locale', locale.languageCode);
  }
}
