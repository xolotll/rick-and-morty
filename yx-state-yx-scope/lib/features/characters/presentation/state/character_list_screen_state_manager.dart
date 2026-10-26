import 'dart:async';

import 'package:yx_scope/yx_scope.dart';
import 'package:yx_state/yx_state.dart';
import 'package:yx_state_transformers/yx_state_transformers.dart';

import '../../../../core/error/app_exception.dart';
import '../models/character_list_screen_bottom_model.dart';
import '../models/character_list_screen_state_model.dart';
import '../../domain/repositories/character_repository.dart';

class CharacterListScreenStateManager
    extends StateManager<CharacterListScreenState>
    implements AsyncLifecycle {
  CharacterListScreenStateManager(this.characterRepository)
    : super(const CharacterListScreenInitial(), handler: droppable());

  final CharacterRepository characterRepository;

  Timer? _searchDebounce;

  Future<void> onRequested() async {
    await handle((emit) async {
      emit(const CharacterListScreenLoading());
      try {
        final result = await characterRepository.getCharacters();
        if (emit.isDone) return;

        emit(
          CharacterListScreenLoaded(
            characters: result.characters,
            query: null,
            bottom: CharacterListScreenBottomInitial(nextUrl: result.nextUrl),
          ),
        );
      } on AppException catch (error, stackTrace) {
        if (emit.isDone) return;
        addError(error, stackTrace);
        emit(CharacterListScreenFailure(error: error));
      }
    });
  }

  void onSearchChanged(String value) {
    final query = value.trim();

    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      unawaited(
        handle((emit) async {
          if (emit.isDone) return;

          emit(const CharacterListScreenLoading());

          try {
            final result = await characterRepository.getCharacters(
              query: query,
            );

            if (emit.isDone) return;

            emit(
              CharacterListScreenLoaded(
                characters: result.characters,
                query: query,
                bottom: CharacterListScreenBottomInitial(
                  nextUrl: result.nextUrl,
                ),
              ),
            );
          } on AppException catch (error, stackTrace) {
            if (emit.isDone) return;

            addError(error, stackTrace);

            if (error.type == AppErrorType.nothingFounded) {
              emit(CharacterListScreenNothingFounded(query: query));
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

      if (currentState is CharacterListScreenLoaded) {
        if (currentState.bottom is CharacterListScreenBottomLoading ||
            currentState.bottom.nextUrl == null) {
          return;
        } else {
          emit(
            CharacterListScreenLoaded(
              characters: currentState.characters,
              query: currentState.query,
              bottom: CharacterListScreenBottomLoading(),
            ),
          );
        }
      } else {
        return;
      }

      try {
        final result = await characterRepository.getCharacters(
          url: currentState.bottom.nextUrl,
        );
        if (emit.isDone) return;

        emit(
          CharacterListScreenLoaded(
            characters: [...currentState.characters, ...result.characters],
            query: currentState.query,
            bottom: CharacterListScreenBottomLoaded(nextUrl: result.nextUrl),
          ),
        );
      } on AppException catch (error, stackTrace) {
        if (emit.isDone) return;

        addError(error, stackTrace);

        emit(
          CharacterListScreenLoaded(
            characters: currentState.characters,
            query: currentState.query,
            bottom: CharacterListScreenBottomFailure(
              nextUrl: currentState.bottom.nextUrl,
              error: error,
            ),
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
