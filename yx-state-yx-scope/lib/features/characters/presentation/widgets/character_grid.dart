import 'package:flutter/material.dart';

import '../widgets/scroll_bottom_status_bar.dart';
import '../../domain/entities/character.dart';
import '../models/character_list_screen_bottom_model.dart';
import 'character_card.dart';

class CharacterGrid extends StatelessWidget {
  const CharacterGrid({
    super.key,
    required this.characters,
    required this.controller,
    required this.onCharacterTap,
    required this.bottom,
    required this.onRetry,
  });

  final List<Character> characters;
  final ScrollController controller;
  final ValueChanged<Character> onCharacterTap;
  final CharacterListScreenBottomModel bottom;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
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
        SliverToBoxAdapter(
          child: ScrollBottomStatusBar(bottom: bottom, onRetry: onRetry),
        ),
      ],
    );
  }
}
