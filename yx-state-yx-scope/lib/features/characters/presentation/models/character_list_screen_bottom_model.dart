import '../../../../core/error/app_exception.dart';

sealed class CharacterListScreenBottomModel {
  const CharacterListScreenBottomModel({this.nextUrl});

  final String? nextUrl;
}

class CharacterListScreenBottomInitial extends CharacterListScreenBottomModel {
  CharacterListScreenBottomInitial({super.nextUrl});
}

class CharacterListScreenBottomLoading extends CharacterListScreenBottomModel {
  CharacterListScreenBottomLoading({super.nextUrl});
}

class CharacterListScreenBottomLoaded extends CharacterListScreenBottomModel {
  CharacterListScreenBottomLoaded({super.nextUrl});
}

class CharacterListScreenBottomFailure extends CharacterListScreenBottomModel {
  CharacterListScreenBottomFailure({super.nextUrl, required this.error});

  final AppException error;
}
