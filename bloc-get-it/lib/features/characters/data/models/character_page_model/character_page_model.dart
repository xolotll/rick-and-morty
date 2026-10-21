import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/character_page.dart';
import '../character_model/character_model.dart';

part 'character_page_model.freezed.dart';

part 'character_page_model.g.dart';

@freezed
abstract class CharacterPageModel with _$CharacterPageModel {
  const CharacterPageModel._();

  const factory CharacterPageModel({
    @Default(<CharacterModel>[]) List<CharacterModel> characters,
    String? nextUrl,
  }) = _CharacterPageModel;

  factory CharacterPageModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterPageModelFromJson({
        'characters': json['results'],
        'nextUrl': (json['info'] as Map<String, dynamic>?)?['next'],
      });

  CharacterPage toEntity() {
    return CharacterPage(
      characters: characters.map((item) => item.toEntity()).toList(),
      nextUrl: nextUrl,
    );
  }
}
