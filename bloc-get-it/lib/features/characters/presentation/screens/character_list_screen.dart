import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../settings/presentation/screens/settings_screen.dart';
import '../../domain/entities/character.dart';
import '../bloc/character_list_bloc.dart';
import '../bloc/character_list_event.dart';
import '../bloc/character_list_state.dart';
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
  late final CharacterListBloc _bloc;
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<CharacterListBloc>()..add(const CharactersRequested());
    _scrollController = ScrollController()..addListener(_onScroll);
    _searchController = TextEditingController();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    if (_scrollController.position.extentAfter < 800) {
      _bloc.add(const CharactersNextPageRequested());
    }
  }

  void _openDetails(Character character) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CharacterDetailScreen(character: character),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<CharacterListBloc, CharacterListState>(
        listenWhen: (previous, current) =>
            previous.error?.localize(l10n) != current.error?.localize(l10n) &&
            current.error?.localize(l10n) != null,
        listener: (context, state) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.error?.localize(l10n) ?? l10n.failedToLoadCharacters,
                ),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 4),
              ),
            );
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(l10n.appTitle),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsPage()),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              CharacterSearchField(
                controller: _searchController,
                onChanged: (query) {
                  _bloc.add(CharacterSearchChanged(query: query));
                },
              ),

              Expanded(
                child: BlocBuilder<CharacterListBloc, CharacterListState>(
                  builder: (context, state) {
                    if (state.status == CharacterListStatus.initial ||
                        (state.status == CharacterListStatus.loading &&
                            state.characters.isEmpty)) {
                      return const CharacterLoadingView();
                    }

                    if (state.status == CharacterListStatus.failure &&
                        state.characters.isEmpty) {
                      return CharacterErrorView(
                        message:
                            state.error?.localize(l10n) ??
                            l10n.failedToLoadCharacters,
                        onRetry: () {
                          _bloc.add(const CharactersRequested());
                        },
                      );
                    }

                    if (state.isEmpty) {
                      return CharacterEmptyView(query: state.query);
                    }

                    return CharacterGrid(
                      characters: state.characters,
                      controller: _scrollController,
                      onCharacterTap: _openDetails,
                      isLoadingMore: state.isLoadingMore,
                      errorMessage: state.error?.localize(l10n),
                      onRetry: () {
                        _bloc.add(const CharactersNextPageRequested());
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    _searchController.dispose();
    _bloc.close();

    super.dispose();
  }
}
