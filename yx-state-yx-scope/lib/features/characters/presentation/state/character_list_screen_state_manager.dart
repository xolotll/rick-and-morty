import 'dart:async';

import 'package:yx_scope/yx_scope.dart';
import 'package:yx_state/yx_state.dart';

import '../../../../core/error/app_exception.dart';
import '../models/character_list_screen_state_model.dart';
import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';

class CharacterListScreenStateManager
    extends StateManager<CharacterListScreenState>
    implements AsyncLifecycle {
  CharacterListScreenStateManager(this.characterRepository)
    : super(const CharacterListScreenInitial());

  final CharacterRepository characterRepository;

  int _operationId = 0;
  Timer? _searchDebounce;

  Future<void> onRequested() async {
    await handle((emit) async {
      final operationId = ++_operationId;

      emit(const CharacterListScreenLoading());
      try {
        final result = await characterRepository.getCharacters();
        if (operationId != _operationId || emit.isDone) return;

        emit(
          CharacterListScreenLoaded(
            characters: result.characters,
            query: '',
            nextUrl: result.nextUrl,
          ),
        );
      } on AppException catch (error, stackTrace) {
        if (operationId != _operationId || emit.isDone) return;

        addError(error, stackTrace);
        emit(CharacterListScreenFailure(error: error));
      }
    });
  }

  void onSearchChanged(String value) {
    final query = value.trim();
    final operationId = ++_operationId;

    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      unawaited(
        handle((emit) async {
          if (operationId != _operationId || emit.isDone) return;

          emit(const CharacterListScreenLoading());

          try {
            final result = await characterRepository.getCharacters(
              query: query,
            );

            if (operationId != _operationId || emit.isDone) return;

            emit(
              CharacterListScreenLoaded(
                characters: result.characters,
                query: query,
                nextUrl: result.nextUrl,
              ),
            );
          } on AppException catch (error, stackTrace) {
            if (operationId != _operationId || emit.isDone) return;

            addError(error, stackTrace);

            if (error.type == AppErrorType.nothingFound) {
              emit(
                CharacterListScreenLoaded(
                  isLoadingMore: false,
                  characters: [],
                  query: query,
                ),
              );
            } else {
              emit(CharacterListScreenFailure(error: error, query: query));
            }
          }
        }),
      );
    });
  }

  Future<void> onNextPageRequested() async {
    await handle((emit) async {
      final currentState = state;

      final List<Character> characters;
      final String query;
      final String? nextUrl;

      switch (currentState) {
        case CharacterListScreenLoaded():
          if (currentState.isLoadingMore) return;

          characters = currentState.characters;
          query = currentState.query;
          nextUrl = currentState.nextUrl;

        case CharacterListScreenFailure():
          if (currentState.characters.isEmpty) return;

          characters = currentState.characters;
          query = currentState.query;
          nextUrl = currentState.nextUrl;

        default:
          return;
      }

      if (nextUrl == null) return;

      final operationId = _operationId;

      emit(
        CharacterListScreenLoaded(
          characters: characters,
          query: query,
          nextUrl: nextUrl,
          isLoadingMore: true,
        ),
      );
      try {
        final result = await characterRepository.getCharacters(url: nextUrl);
        if (operationId != _operationId || emit.isDone) return;

        final latestState = state;
        if (latestState is! CharacterListScreenLoaded ||
            latestState.query != query ||
            latestState.nextUrl != nextUrl) {
          return;
        }
        emit(
          CharacterListScreenLoaded(
            characters: [...latestState.characters, ...result.characters],
            query: query,
            nextUrl: result.nextUrl,
          ),
        );
      } on AppException catch (error, stackTrace) {
        if (operationId != _operationId || emit.isDone) return;

        addError(error, stackTrace);
        emit(
          CharacterListScreenFailure(
            error: error,
            characters: characters,
            query: query,
            nextUrl: nextUrl,
          ),
        );
      }
    });
  }

  @override
  Future<void> init() async {}

  @override
  Future<void> dispose() async {
    _searchDebounce?.cancel();
  }
}
