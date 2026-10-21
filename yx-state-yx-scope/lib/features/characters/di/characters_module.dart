import 'package:yx_scope/yx_scope.dart';

import '../../../app/app_scope.dart';
import '../data/datasources/character_remote_data_source.dart';
import '../data/repositories/character_repository_impl.dart';
import '../domain/repositories/character_repository.dart';
import '../presentation/state/character_list_screen_state_manager.dart';

abstract class CharactersScope implements Scope {
  CharacterListScreenStateManager get stateManager;

  AsyncDep get stateManagerDep;
}

class CharactersScopeModule extends ScopeModule<AppScopeContainer>
    implements CharactersScope {
  CharactersScopeModule(super.container);

  late final _characterRemoteDataSourceDep = dep(
    () => CharacterRemoteDataSource(apiClient: container.apiClient),
  );

  late final _characterRepositoryDep = dep<CharacterRepository>(
    () => CharacterRepositoryImpl(
      remoteDataSource: _characterRemoteDataSourceDep.get,
    ),
  );

  late final _stateManagerDep = rawAsyncDep(
    () => CharacterListScreenStateManager(_characterRepositoryDep.get),
    init: (dep) async => dep.init(),
    dispose: (dep) async => dep.dispose(),
  );

  late final _characterListScreenStateManagerDep = dep(
    () => CharacterListScreenStateManager(_characterRepositoryDep.get),
  );

  @override
  CharacterListScreenStateManager get stateManager =>
      _characterListScreenStateManagerDep.get;

  @override
  AsyncDep get stateManagerDep => _stateManagerDep;
}
