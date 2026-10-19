import 'package:dio/dio.dart';
import 'package:yx_scope/yx_scope.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';
import 'package:flutter/material.dart';

import '../features/characters/di/characters_module.dart';
import '../core/constants/api_constants.dart';
import '../core/network/api_client.dart';
import '../features/settings/di/settings_module.dart';

abstract class AppScope implements Scope {
  SettingsScope get settingsModule;

  CharactersScope get charactersModule;

  Dio get apiClient;
}

class AppScopeContainer extends ScopeContainer implements AppScope {
  late final _apiClientDep = dep(
    () => ApiClient.createDio(baseUrl: ApiConstants.baseUrl),
  );

  @override
  late final settingsModule = SettingsScopeModule(this);

  @override
  late final charactersModule = CharactersScopeModule(this);

  @override
  Dio get apiClient => _apiClientDep.get;

  @override
  List<Set<AsyncDep>> get initializeQueue => [
    {settingsModule.stateManagerDep, charactersModule.stateManagerDep},
  ];
}

class AppScopeHolder extends ScopeHolder<AppScopeContainer> {
  @override
  AppScopeContainer createContainer() => AppScopeContainer();
}

extension AppScopeExtension on BuildContext {
  AppScope get appScope => ScopeProvider.of<AppScope>(this)!;

  ScopeStateHolder<AppScope?> get appScopeHolder =>
      ScopeProvider.scopeHolderOf<AppScope>(this);
}
