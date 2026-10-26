import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class CharacterEmptyView extends StatelessWidget {
  const CharacterEmptyView({super.key, required this.query});

  final String? query;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.search_off, size: 56),
          const SizedBox(height: 16),
          Text('${l10n.nothingFound}${(query != null) ? ' «$query»' : ''}'),
        ],
      ),
    );
  }
}
