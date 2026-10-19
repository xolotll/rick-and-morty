import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/repositories/settings_repository.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository repository;

  SettingsBloc(this.repository) : super(const SettingsState()) {
    on<SettingsStarted>(_onStarted);
    on<ThemeChanged>(_onThemeChanged);
    on<LocaleChanged>(_onLocaleChanged);
  }

  Future<void> _onStarted(
    SettingsStarted event,
    Emitter<SettingsState> emit,
  ) async {
    final themeMode = await repository.getThemeMode();
    final locale = await repository.getLocale();

    emit(
      state.copyWith(themeMode: themeMode, locale: locale, isLoading: false),
    );
  }

  Future<void> _onThemeChanged(
    ThemeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(themeMode: event.themeMode));

    await repository.saveThemeMode(event.themeMode);
  }

  Future<void> _onLocaleChanged(
    LocaleChanged event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(locale: event.locale));

    await repository.saveLocale(event.locale);
  }
}
