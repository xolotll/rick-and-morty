import 'package:equatable/equatable.dart';

import '../../domain/entities/character.dart';
import '../../../../core/error/app_exception.dart';

enum CharacterListStatus { initial, loading, success, failure }

class CharacterListState extends Equatable {
  const CharacterListState({
    this.status = CharacterListStatus.initial,
    this.characters = const [],
    this.query = '',
    this.nextUrl,
    this.isLoadingMore = false,
    this.error,
  });

  final CharacterListStatus status;
  final List<Character> characters;
  final String query;
  final String? nextUrl;
  final bool isLoadingMore;
  final AppException? error;

  bool get isEmpty =>
      status == CharacterListStatus.success && characters.isEmpty;

  CharacterListState copyWith({
    CharacterListStatus? status,
    List<Character>? characters,
    String? query,
    String? nextUrl,
    bool clearNextUrl = false,
    bool? isLoadingMore,
    AppException? error,
    bool clearError = false,
  }) {
    return CharacterListState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      query: query ?? this.query,
      nextUrl: clearNextUrl ? null : nextUrl ?? this.nextUrl,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: clearError ? null : error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    characters,
    query,
    nextUrl,
    isLoadingMore,
    error,
  ];
}
