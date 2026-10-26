import '../../../../core/error/app_exception.dart';
import '../../domain/entities/character.dart';
import 'character_list_screen_bottom_model.dart';

sealed class CharacterListScreenState {
  const CharacterListScreenState({this.query});

  final String? query;
}

class CharacterListScreenInitial extends CharacterListScreenState {
  const CharacterListScreenInitial({super.query});
}

class CharacterListScreenLoading extends CharacterListScreenState {
  const CharacterListScreenLoading({super.query});
}

class CharacterListScreenNothingFounded extends CharacterListScreenState {
  const CharacterListScreenNothingFounded({super.query});
}

class CharacterListScreenLoaded extends CharacterListScreenState {
  const CharacterListScreenLoaded({
    super.query,
    this.characters = const [],
    required this.bottom,
  });

  final List<Character> characters;
  final CharacterListScreenBottomModel bottom;
}

class CharacterListScreenFailure extends CharacterListScreenState {
  const CharacterListScreenFailure({super.query, required this.error});

  final AppException error;
}
