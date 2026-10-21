// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CharacterModel _$CharacterModelFromJson(Map<String, dynamic> json) =>
    _CharacterModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? 'Unknown',
      status: json['status'] as String? ?? 'unknown',
      species: json['species'] as String? ?? 'Unknown',
      type: json['type'] as String? ?? '',
      gender: json['gender'] as String? ?? 'Unknown',
      origin: _readNestedName(json, 'origin') as String? ?? 'Unknown',
      location: _readNestedName(json, 'location') as String? ?? 'Unknown',
      image: json['image'] as String? ?? '',
    );

Map<String, dynamic> _$CharacterModelToJson(_CharacterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'origin': instance.origin,
      'location': instance.location,
      'image': instance.image,
    };
