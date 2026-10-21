import '../../../../core/error/app_exception.dart';
import '../../domain/entities/character.dart';

sealed class CharacterListScreenState {
  const CharacterListScreenState();
}

class CharacterListScreenInitial extends CharacterListScreenState {
  const CharacterListScreenInitial();
}

class CharacterListScreenLoading extends CharacterListScreenState {
  const CharacterListScreenLoading();
}

class CharacterListScreenLoaded extends CharacterListScreenState {
  const CharacterListScreenLoaded({
    this.characters = const [],
    this.query = '',
    this.nextUrl,
    this.isLoadingMore = false,
  });

  final List<Character> characters;
  final String query;
  final String? nextUrl;
  final bool isLoadingMore;
}

class CharacterListScreenFailure extends CharacterListScreenState {
  const CharacterListScreenFailure({
    required this.error,
    this.characters = const [],
    this.query = '',
    this.nextUrl,
  });

  final AppException error;
  final List<Character> characters;
  final String query;
  final String? nextUrl;
}
