import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/character.dart';

part 'character_model.freezed.dart';

part 'character_model.g.dart';

@freezed
abstract class CharacterModel with _$CharacterModel {
  const CharacterModel._();

  const factory CharacterModel({
    @Default(0) int id,
    @Default('Unknown') String name,
    @Default('unknown') String status,
    @Default('Unknown') String species,
    @Default('') String type,
    @Default('Unknown') String gender,
    @JsonKey(defaultValue: 'Unknown', readValue: _readNestedName)
    @Default('Unknown')
    String origin,
    @JsonKey(defaultValue: 'Unknown', readValue: _readNestedName)
    @Default('Unknown')
    String location,
    @Default('') String image,
  }) = _CharacterModel;

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
      origin: origin,
      location: location,
      image: image,
    );
  }
}

Object? _readNestedName(Map json, String key) {
  final value = json[key];

  if (value is Map) {
    return value['name'];
  }

  return null;
}
