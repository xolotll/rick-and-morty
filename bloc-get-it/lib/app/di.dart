import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../features/characters/domain/usecases/get_characters.dart';
import '../features/characters/presentation/bloc/character_list_bloc.dart';
import '../core/constants/api_constants.dart';
import '../core/network/api_client.dart';
import '../features/settings/bloc/settings_bloc.dart';
import '../features/settings/domain/repositories/settings_repository.dart';
import '../features/characters/data/datasources/character_remote_data_source.dart';
import '../features/characters/data/repositories/character_repository_impl.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<Dio>(
    () => ApiClient.createDio(baseUrl: ApiConstants.baseUrl),
  );

  getIt.registerLazySingleton<SettingsRepository>(SettingsRepository.new);

  getIt.registerLazySingleton<SettingsBloc>(
    () => SettingsBloc(getIt<SettingsRepository>()),
  );

  getIt.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSource(dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton<CharacterRepositoryImpl>(
    () => CharacterRepositoryImpl(
      remoteDataSource: getIt<CharacterRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetCharacters>(
    () => GetCharacters(repository: getIt<CharacterRepositoryImpl>()),
  );

  getIt.registerLazySingleton<CharacterListBloc>(
    () => CharacterListBloc(getCharacters: getIt<GetCharacters>()),
  );
}
