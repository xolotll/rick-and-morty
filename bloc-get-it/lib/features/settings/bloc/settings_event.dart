import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsStarted extends SettingsEvent {
  const SettingsStarted();
}

class ThemeChanged extends SettingsEvent {
  final ThemeMode themeMode;

  const ThemeChanged(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class LocaleChanged extends SettingsEvent {
  final Locale locale;

  const LocaleChanged(this.locale);

  @override
  List<Object?> get props => [locale];
}
