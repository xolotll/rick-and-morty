import 'package:equatable/equatable.dart';

abstract class CharacterListEvent extends Equatable {
  const CharacterListEvent();

  @override
  List<Object?> get props => [];
}

class CharactersRequested extends CharacterListEvent {
  const CharactersRequested();
}

class CharactersNextPageRequested extends CharacterListEvent {
  const CharactersNextPageRequested();
}

class CharacterSearchChanged extends CharacterListEvent {
  const CharacterSearchChanged({required this.query});

  final String query;

  @override
  List<Object?> get props => [query];
}
