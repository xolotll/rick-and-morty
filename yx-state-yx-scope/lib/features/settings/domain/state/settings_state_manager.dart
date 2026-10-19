import 'package:flutter/material.dart';
import 'package:yx_scope/yx_scope.dart';
import 'package:yx_state/yx_state.dart';

import '../../../../core/error/app_exception.dart';
import '../../data/models/settings_state_model.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsStateManager extends StateManager<SettingsState>
    implements AsyncLifecycle {
  SettingsStateManager(this._settingsRepository)
    : super(const SettingsInitial());

  final SettingsRepository _settingsRepository;

  @override
  Future<void> init() => handle((emit) async {
    try {
      emit(SettingsLoading());

      final themeMode = await _settingsRepository.getThemeMode();
      final locale = await _settingsRepository.getLocale();

      emit(SettingsLoaded(themeMode: themeMode, locale: locale));
    } on AppException catch (error, stackTrace) {
      addError(error, stackTrace);

      emit(SettingsFailure(error));
    }
  });

  Future<void> changeThemeModeTo(ThemeMode themeMode) => handle((emit) async {
    try {
      await _settingsRepository.saveThemeMode(themeMode);

      final currentState = state;
      if (currentState is! SettingsLoaded) return;

      emit(SettingsLoaded(themeMode: themeMode, locale: currentState.locale));
    } on AppException catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  });

  Future<void> changeLocale(Locale locale) => handle((emit) async {
    try {
      await _settingsRepository.saveLocale(locale);

      final currentState = state;
      if (currentState is! SettingsLoaded) return;

      emit(SettingsLoaded(themeMode: currentState.themeMode, locale: locale));
    } on AppException catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  });

  @override
  Future<void> dispose() async {}
}
