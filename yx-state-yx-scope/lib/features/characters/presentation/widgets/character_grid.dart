import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/character.dart';
import 'character_card.dart';

class CharacterGrid extends StatelessWidget {
  const CharacterGrid({
    super.key,
    required this.characters,
    required this.controller,
    required this.onCharacterTap,
    required this.isLoadingMore,
    required this.errorMessage,
    required this.onRetry,
  });

  final List<Character> characters;
  final ScrollController controller;
  final ValueChanged<Character> onCharacterTap;
  final bool isLoadingMore;
  final String? errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 240,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.6,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final character = characters[index];

              return CharacterCard(
                character: character,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  onCharacterTap(character);
                },
              );
            }, childCount: characters.length),
          ),
        ),

        if (isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            ),
          )
        else if (errorMessage != null)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off_outlined),
                    const SizedBox(height: 8),
                    Text(errorMessage!),
                    TextButton(onPressed: onRetry, child: Text(l10n.refresh)),
                  ],
                ),
              ),
            ),
          ),

        SliverToBoxAdapter(child: SizedBox(height: 50)),
      ],
    );
  }
}
