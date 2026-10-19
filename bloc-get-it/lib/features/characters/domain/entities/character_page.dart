import 'package:equatable/equatable.dart';

import 'character.dart';

class CharacterPage extends Equatable {
  const CharacterPage({required this.characters, this.nextUrl});

  final List<Character> characters;
  final String? nextUrl;

  @override
  List<Object?> get props => [characters, nextUrl];
}
