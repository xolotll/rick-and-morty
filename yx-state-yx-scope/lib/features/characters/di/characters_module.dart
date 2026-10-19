import 'package:yx_scope/yx_scope.dart';

import '../../../app/app_scope.dart';
import '../data/datasources/character_remote_data_source.dart';
import '../data/repositories/character_repository_impl.dart';
import '../domain/usecases/get_characters.dart';
import '../presentation/state/character_list_screen_state_manager.dart';

abstract class CharactersScope implements Scope {
  CharacterListScreenStateManager get stateManager;

  AsyncDep get stateManagerDep;
}

class CharactersScopeModule extends ScopeModule<AppScopeContainer>
    implements CharactersScope {
  CharactersScopeModule(super.container);

  late final _characterRemoteDataSourceDep = dep(
    () => CharacterRemoteDataSource(dio: container.apiClient),
  );

  late final _characterRepositoryImplDep = dep(
    () => CharacterRepositoryImpl(
      remoteDataSource: _characterRemoteDataSourceDep.get,
    ),
  );

  late final _getCharactersDep = dep(
    () => GetCharacters(repository: _characterRepositoryImplDep.get),
  );

  late final _stateManagerDep = rawAsyncDep(
    () => CharacterListScreenStateManager(_getCharactersDep.get),
    init: (dep) async => dep.init(),
    dispose: (dep) async => dep.dispose(),
  );

  late final _characterListScreenStateManagerDep = dep(
    () => CharacterListScreenStateManager(_getCharactersDep.get),
  );

  @override
  CharacterListScreenStateManager get stateManager =>
      _characterListScreenStateManagerDep.get;

  @override
  AsyncDep get stateManagerDep => _stateManagerDep;
}
