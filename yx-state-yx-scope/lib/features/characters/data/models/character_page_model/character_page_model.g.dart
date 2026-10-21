// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CharacterPageModel _$CharacterPageModelFromJson(Map<String, dynamic> json) =>
    _CharacterPageModel(
      characters:
          (json['characters'] as List<dynamic>?)
              ?.map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CharacterModel>[],
      nextUrl: json['nextUrl'] as String?,
    );

Map<String, dynamic> _$CharacterPageModelToJson(_CharacterPageModel instance) =>
    <String, dynamic>{
      'characters': instance.characters,
      'nextUrl': instance.nextUrl,
    };
