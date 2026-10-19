import 'package:flutter/material.dart';

import '../../../../core/error/app_exception.dart';

sealed class SettingsState {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({required this.themeMode, required this.locale});

  final ThemeMode themeMode;
  final Locale locale;
}

class SettingsFailure extends SettingsState {
  const SettingsFailure(this.error);

  final AppException error;
}
