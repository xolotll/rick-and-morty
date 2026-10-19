import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../bloc/settings_bloc.dart';
import '../../bloc/settings_event.dart';
import '../../bloc/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final bloc = context.read<SettingsBloc>();

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
                      bloc.add(ThemeChanged(value));
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
                      bloc.add(LocaleChanged(Locale(value)));
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
