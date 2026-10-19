import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../app/app_scope.dart';
import '../../data/models/settings_state_model.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settingsStateManager = context.appScope.settingsModule.stateManager;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: StreamBuilder<SettingsState>(
        stream: settingsStateManager.stream,
        initialData: settingsStateManager.state,
        builder: (context, snapshot) {
          final state = snapshot.data;

          if (state is! SettingsLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: [
              ListTile(
                title: Text(l10n.theme),
                trailing: DropdownButton<ThemeMode>(
                  value: state.themeMode,
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('Light'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('Dark'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      settingsStateManager.changeThemeModeTo(value);
                    }
                  },
                ),
              ),
              ListTile(
                title: Text(l10n.language),
                trailing: DropdownButton<String>(
                  value: state.locale.languageCode,
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'ru', child: Text('Русский')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      settingsStateManager.changeLocale(Locale(value));
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
