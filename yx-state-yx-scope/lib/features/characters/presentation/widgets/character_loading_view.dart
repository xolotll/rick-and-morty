import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class CharacterLoadingView extends StatelessWidget {
  const CharacterLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(l10n.loadingCharacters),
        ],
      ),
    );
  }
}
