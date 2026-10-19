import '../../domain/entities/character_page.dart';
import 'character_model.dart';

class CharacterPageModel {
  const CharacterPageModel({required this.characters, this.nextUrl});

  final List<CharacterModel> characters;
  final String? nextUrl;

  factory CharacterPageModel.fromJson(Map<String, dynamic> json) {
    final results = json['results'] as List<dynamic>? ?? [];
    final info = json['info'] as Map<String, dynamic>? ?? {};

    return CharacterPageModel(
      characters: results
          .whereType<Map<String, dynamic>>()
          .map(CharacterModel.fromJson)
          .toList(),
      nextUrl: info['next'],
    );
  }

  CharacterPage toEntity() {
    return CharacterPage(
      characters: characters.map((item) => item.toEntity()).toList(),
      nextUrl: nextUrl,
    );
  }
}
