import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import '../core/network/dio_exception_mapper.dart';
import '../core/network/dio_factory.dart';
import '../core/network/api_client.dart';
import '../features/characters/domain/repositories/character_repository.dart';
import '../features/characters/presentation/bloc/character_list_bloc.dart';
import '../features/settings/bloc/settings_bloc.dart';
import '../features/settings/domain/repositories/settings_repository.dart';
import '../features/characters/data/datasources/character_remote_data_source.dart';
import '../features/characters/data/repositories/character_repository_impl.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<DioExceptionMapper>(
    () => const DioExceptionMapper(),
  );

  getIt.registerLazySingleton<Dio>(
    () => DioFactory().create(
      baseUrl: ApiConstants.baseUrl,
      interceptors: [LogInterceptor(requestBody: true, responseBody: true)],
    ),
  );

  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(
      dio: getIt<Dio>(),
      exceptionMapper: getIt<DioExceptionMapper>(),
    ),
  );

  getIt.registerLazySingleton<SettingsRepository>(SettingsRepository.new);

  getIt.registerLazySingleton<SettingsBloc>(
    () => SettingsBloc(getIt<SettingsRepository>()),
  );

  getIt.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSource(apiClient: getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
      remoteDataSource: getIt<CharacterRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<CharacterListBloc>(
    () => CharacterListBloc(characterRepository: getIt<CharacterRepository>()),
  );
}
