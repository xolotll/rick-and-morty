import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../app/app_scope.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../settings/presentation/screens/settings_screen.dart';
import '../../data/models/character_list_screen_state_model.dart';
import '../../domain/entities/character.dart';
import '../state/character_list_screen_state_manager.dart';
import '../widgets/character_empty_view.dart';
import '../widgets/character_error_view.dart';
import '../widgets/character_grid.dart';
import '../widgets/character_loading_view.dart';
import '../widgets/character_search_field.dart';
import 'character_details_screen.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late final CharacterListScreenStateManager _stateManager;
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;
  late StreamSubscription<CharacterListScreenState> _stateSubscription;

  bool _initialized = false;
  String? _lastErrorMessage;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _searchController.dispose();
    _stateManager.dispose();
    _stateSubscription.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;

    _stateManager = context.appScope.charactersModule.stateManager;

    _stateSubscription = _stateManager.stream.listen(_listenState);

    _initialized = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _stateManager.onRequested();
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final state = _stateManager.state;
    if (state is! CharacterListScreenLoaded ||
        state.isLoadingMore ||
        state.nextUrl == null) {
      return;
    }

    if (_scrollController.position.extentAfter < 1200) {
      _stateManager.onNextPageRequested();
    }
  }

  void _listenState(CharacterListScreenState state) {
    final l10n = AppLocalizations.of(context)!;

    final error = switch (state) {
      CharacterListScreenFailure() => state.error,
      _ => null,
    };

    final message = error?.localize(l10n);

    if (message == null) {
      _lastErrorMessage = null;
      return;
    }

    if (message == _lastErrorMessage) return;

    _lastErrorMessage = message;

    final messenger = ScaffoldMessenger.of(context);

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
  }

  void _openDetails(Character character) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CharacterDetailScreen(character: character),
      ),
    );
  }

  void _openSettings() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const SettingsPage()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: _openSettings,
          ),
        ],
      ),
      body: Column(
        children: [
          CharacterSearchField(
            controller: _searchController,
            onChanged: _stateManager.onSearchChanged,
          ),
          Expanded(
            child: StreamBuilder<CharacterListScreenState>(
              stream: _stateManager.stream,
              initialData: _stateManager.state,
              builder: (context, snapshot) {
                final state = snapshot.data;

                switch (state) {
                  case null:
                  case CharacterListScreenInitial():
                  case CharacterListScreenLoading():
                    return const CharacterLoadingView();

                  case CharacterListScreenFailure():
                    if (state.characters.isEmpty) {
                      return CharacterErrorView(
                        message: state.error.localize(l10n),
                        onRetry: state.query.isEmpty
                            ? _stateManager.onRequested
                            : () => _stateManager.onSearchChanged(state.query),
                      );
                    }

                    return CharacterGrid(
                      characters: state.characters,
                      controller: _scrollController,
                      onCharacterTap: _openDetails,
                      isLoadingMore: false,
                      errorMessage: state.error.localize(l10n),
                      onRetry: _stateManager.onNextPageRequested,
                    );

                  case CharacterListScreenLoaded():
                    if (state.characters.isEmpty) {
                      return CharacterEmptyView(query: state.query);
                    }

                    return CharacterGrid(
                      characters: state.characters,
                      controller: _scrollController,
                      onCharacterTap: _openDetails,
                      isLoadingMore: state.isLoadingMore,
                      errorMessage: null,
                      onRetry: _stateManager.onNextPageRequested,
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
