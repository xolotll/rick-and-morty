import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

import '../features/settings/data/models/settings_state_model.dart';
import '../features/characters/presentation/screens/character_list_screen.dart';
import '../features/settings/presentation/widgets/settings_failure_view.dart';
import '../l10n/app_localizations.dart';
import 'app_scope.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static final _lightTheme = ThemeData.light();
  static final _darkTheme = ThemeData.dark();
  late final AppScopeHolder _appScopeHolder;

  @override
  void initState() {
    super.initState();
    _appScopeHolder = AppScopeHolder();
    _appScopeHolder.create();
  }

  @override
  void dispose() {
    _appScopeHolder.drop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopeProvider<AppScope>(
      holder: _appScopeHolder,
      child: ScopeBuilder<AppScope>.withPlaceholder(
        builder: (context, appScope) {
          return StateBuilder<SettingsState>(
            stateReadable: appScope.settingsModule.stateManager,
            builder: (context, state, _) {
              final themeMode = switch (state) {
                SettingsLoaded(:final themeMode) => themeMode,
                _ => ThemeMode.system,
              };

              final locale = switch (state) {
                SettingsLoaded(:final locale) => locale,
                _ => const Locale('ru'),
              };

              return MaterialApp(
                title: 'Rick and Morty',
                debugShowCheckedModeBanner: false,

                themeMode: themeMode,
                theme: _lightTheme,
                darkTheme: _darkTheme,

                locale: locale,
                supportedLocales: const [Locale('en'), Locale('ru')],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],

                home: switch (state) {
                  SettingsInitial() || SettingsLoading() => const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  ),
                  SettingsLoaded() => const CharacterListScreen(),
                  SettingsFailure() => Builder(
                    builder: (context) {
                      final l10n = AppLocalizations.of(context)!;

                      return SettingsFailureView(
                        message: state.error.localize(l10n),
                        onRetry: () {
                          appScope.settingsModule.stateManager.init();
                        },
                      );
                    },
                  ),
                },
              );
            },
          );
        },
        placeholder: MaterialApp(
          title: 'Rick and Morty',
          debugShowCheckedModeBanner: false,
          theme: _lightTheme,
          darkTheme: _darkTheme,
          home: const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
