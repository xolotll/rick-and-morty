import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../models/character_list_screen_bottom_model.dart';

class ScrollBottomStatusBar extends StatelessWidget {
  const ScrollBottomStatusBar({
    super.key,
    required this.bottom,
    required this.onRetry,
  });

  final CharacterListScreenBottomModel bottom;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (bottom) {
      case CharacterListScreenBottomInitial():
      case CharacterListScreenBottomLoaded():
        return SizedBox(height: 60);

      case CharacterListScreenBottomLoading():
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Center(child: CircularProgressIndicator()),
              SizedBox(height: 60),
            ],
          ),
        );

      case CharacterListScreenBottomFailure(:final error):
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_off_outlined),
                const SizedBox(height: 8),
                Text(error.localize(l10n)),
                TextButton(onPressed: onRetry, child: Text(l10n.refresh)),
                SizedBox(height: 60),
              ],
            ),
          ),
        );
    }
  }
}
