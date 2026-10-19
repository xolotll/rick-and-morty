import '../../domain/entities/character.dart';

class CharacterModel {
  const CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
  });

  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String origin;
  final String location;
  final String image;

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final originJson = json['origin'] as Map<String, dynamic>? ?? {};
    final locationJson = json['location'] as Map<String, dynamic>? ?? {};

    return CharacterModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? 'Unknown',
      status: json['status'] as String? ?? 'unknown',
      species: json['species'] as String? ?? 'Unknown',
      type: json['type'] as String? ?? '',
      gender: json['gender'] as String? ?? 'Unknown',
      origin: originJson['name'] as String? ?? 'Unknown',
      location: locationJson['name'] as String? ?? 'Unknown',
      image: json['image'] as String? ?? '',
    );
  }

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
