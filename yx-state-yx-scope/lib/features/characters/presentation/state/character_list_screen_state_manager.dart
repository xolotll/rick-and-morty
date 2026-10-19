import 'dart:async';
import 'package:yx_scope/yx_scope.dart';
import 'package:yx_state/yx_state.dart';

import '../../../../core/error/app_exception.dart';
import '../../data/models/character_list_screen_state_model.dart';
import '../../domain/entities/character.dart';
import '../../domain/usecases/get_characters.dart';

class CharacterListScreenStateManager
    extends StateManager<CharacterListScreenState>
    implements AsyncLifecycle {
  CharacterListScreenStateManager(this._getCharacters)
    : super(const CharacterListScreenInitial());

  final GetCharacters _getCharacters;

  int _operationId = 0;
  bool _isLoadingNextPage = false;
  Timer? _searchDebounce;

  Future<void> onRequested() async {
    await handle((emit) async {
      final operationId = ++_operationId;

      emit(const CharacterListScreenLoading());
      try {
        final result = await _getCharacters();
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

    _searchDebounce = Timer(
      const Duration(milliseconds: 350),
          () {
        unawaited(
          handle((emit) async {
            if (operationId != _operationId || emit.isDone) return;

            emit(const CharacterListScreenLoading());

            try {
              final result = await _getCharacters(query: query);

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

              emit(
                CharacterListScreenFailure(
                  error: error,
                  query: query,
                ),
              );
            }
          }),
        );
      },
    );
  }

  Future<void> onNextPageRequested() async {
    await handle((emit) async {
      if (_isLoadingNextPage) return;

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

      _isLoadingNextPage = true;

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
        final result = await _getCharacters(url: nextUrl);
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
      } finally {
        _isLoadingNextPage = false;
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
