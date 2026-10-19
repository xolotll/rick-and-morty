import 'package:flutter/material.dart';

abstract interface class SettingsRepository {
  Future<ThemeMode> getThemeMode();

  Future<Locale> getLocale();

  Future<void> saveThemeMode(ThemeMode themeMode);

  Future<void> saveLocale(Locale locale);
}
