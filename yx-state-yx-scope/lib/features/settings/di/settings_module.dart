import 'package:yx_scope/yx_scope.dart';

import '../../../app/app_scope.dart';
import '../data/repositories/settings_repository_impl.dart';
import '../domain/repositories/settings_repository.dart';
import '../domain/state/settings_state_manager.dart';

abstract class SettingsScope implements Scope {
  SettingsRepository get repository;

  SettingsStateManager get stateManager;

  AsyncDep get stateManagerDep;
}

class SettingsScopeModule extends ScopeModule<AppScopeContainer>
    implements SettingsScope {
  SettingsScopeModule(super.container);

  late final _repositoryDep = dep(() => SettingsRepositoryImpl());

  late final _stateManagerDep = rawAsyncDep(
    () => SettingsStateManager(repository),
    init: (dep) async => dep.init(),
    dispose: (dep) async => dep.dispose(),
  );

  @override
  SettingsRepository get repository => _repositoryDep.get;

  @override
  SettingsStateManager get stateManager => _stateManagerDep.get;

  @override
  AsyncDep get stateManagerDep => _stateManagerDep;
}
