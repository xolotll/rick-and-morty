import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../features/settings/bloc/settings_bloc.dart';
import '../features/settings/bloc/settings_event.dart';
import '../features/settings/bloc/settings_state.dart';
import '../features/characters/presentation/screens/character_list_screen.dart';
import '../l10n/app_localizations.dart';
import 'di.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SettingsBloc>()..add(const SettingsStarted()),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Rick and Morty',
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            locale: state.locale,
            supportedLocales: const [Locale('en'), Locale('ru')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const CharacterListScreen(),
          );
        },
      ),
    );
  }
}
