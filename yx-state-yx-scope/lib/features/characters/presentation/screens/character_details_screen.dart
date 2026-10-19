import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/character.dart';
import '../widgets/status_badge.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'character-${character.id}',
                child: Image.network(
                  character.image,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      const Center(child: Icon(Icons.person, size: 80)),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  character.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: StatusBadge(status: character.status),
                ),
                const SizedBox(height: 24),
                _DetailRow(label: l10n.species, value: character.species),
                _DetailRow(
                  label: l10n.type,
                  value: character.type.isEmpty
                      ? l10n.notSpecified
                      : character.type,
                ),
                _DetailRow(label: l10n.gender, value: character.gender),
                _DetailRow(label: l10n.origin, value: character.origin),
                _DetailRow(
                  label: l10n.lastKnownLocation,
                  value: character.location,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 4),
          Text(
            value.isEmpty ? 'Unknown' : value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Divider(height: 20),
        ],
      ),
    );
  }
}
