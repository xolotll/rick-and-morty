import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/character_repository.dart';
import '../../../../core/error/app_exception.dart';
import 'character_list_event.dart';
import 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListBloc({required this.characterRepository})
    : super(const CharacterListState()) {
    on<CharactersRequested>(_onRequested, transformer: restartable());
    on<CharacterSearchChanged>(_onSearchChanged, transformer: restartable());
    on<CharactersNextPageRequested>(
      _onNextPageRequested,
      transformer: droppable(),
    );
  }

  final CharacterRepository characterRepository;

  Future<void> _onRequested(
    CharactersRequested event,
    Emitter<CharacterListState> emit,
  ) async {
    emit(state.copyWith(status: CharacterListStatus.loading, clearError: true));
    try {
      final result = await characterRepository.getCharacters(
        query: state.query,
      );

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
    final url = state.nextUrl;

    if (state.isLoadingMore || url == null) return;

    emit(state.copyWith(isLoadingMore: true, clearError: true));

    try {
      final result = await characterRepository.getCharacters(url: url);

      if (emit.isDone) return;

      emit(
        state.copyWith(
          status: CharacterListStatus.success,
          characters: [...state.characters, ...result.characters],
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
      final result = await characterRepository.getCharacters(query: query);

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

      if (error.type == AppErrorType.nothingFound) {
        emit(
          state.copyWith(
            status: CharacterListStatus.success,
            isLoadingMore: false,
            characters: [],
          ),
        );
      } else {
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
}
