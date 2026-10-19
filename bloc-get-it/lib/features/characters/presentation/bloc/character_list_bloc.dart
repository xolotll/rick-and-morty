import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/app_exception.dart';
import '../../domain/entities/character.dart';
import '../../domain/usecases/get_characters.dart';
import 'character_list_event.dart';
import 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListBloc({required this.getCharacters})
    : super(const CharacterListState()) {
    on<CharactersRequested>(_onRequested, transformer: restartable());
    on<CharacterSearchChanged>(_onSearchChanged, transformer: restartable());
    on<CharactersNextPageRequested>(
      _onNextPageRequested,
      transformer: droppable(),
    );
  }

  final GetCharacters getCharacters;

  Future<void> _onRequested(
    CharactersRequested event,
    Emitter<CharacterListState> emit,
  ) async {
    emit(state.copyWith(status: CharacterListStatus.loading, clearError: true));
    try {
      final result = await getCharacters(query: state.query);

      if (emit.isDone) return;

      emit(
        state.copyWith(
          status: CharacterListStatus.success,
          query: state.query,
          characters: result.characters,
          nextUrl: result.nextUrl,
          isLoadingMore: false,
          clearError: true,
        ),
      );
    } on AppException catch (error) {
      if (emit.isDone) return;

      emit(
        state.copyWith(
          status: CharacterListStatus.failure,
          error: error,
          isLoadingMore: false,
        ),
      );
    }
  }

  Future<void> _onNextPageRequested(
    CharactersNextPageRequested event,
    Emitter<CharacterListState> emit,
  ) async {
    try {
      if (state.isLoadingMore || state.nextUrl == null) {
        return;
      }
      emit(state.copyWith(isLoadingMore: true, clearError: true));

      final result = await getCharacters(url: state.nextUrl);

      if (emit.isDone) return;

      final combined = <Character>[...state.characters, ...result.characters];

      emit(
        state.copyWith(
          status: CharacterListStatus.success,
          characters: combined,
          nextUrl: result.nextUrl,
          clearNextUrl: result.nextUrl == null,
          isLoadingMore: false,
          clearError: true,
        ),
      );
    } on AppException catch (error) {
      if (emit.isDone) return;

      emit(state.copyWith(isLoadingMore: false, error: error));
    }
  }

  Future<void> _onSearchChanged(
    CharacterSearchChanged event,
    Emitter<CharacterListState> emit,
  ) async {
    final query = event.query.trim();

    emit(CharacterListState(status: CharacterListStatus.loading, query: query));

    await Future.delayed(const Duration(milliseconds: 350));

    if (emit.isDone) return;

    try {
      final result = await getCharacters(query: query);

      if (emit.isDone) return;

      emit(
        state.copyWith(
          status: CharacterListStatus.success,
          query: query,
          characters: result.characters,
          nextUrl: result.nextUrl,
          clearNextUrl: result.nextUrl == null,
          isLoadingMore: false,
          clearError: true,
        ),
      );
    } on AppException catch (error) {
      if (emit.isDone) return;

      emit(
        state.copyWith(
          status: CharacterListStatus.failure,
          error: error,
          isLoadingMore: false,
        ),
      );
    }
  }
}
