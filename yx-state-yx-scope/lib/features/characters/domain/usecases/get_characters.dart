import '../entities/character_page.dart';
import '../repositories/character_repository.dart';

class GetCharacters {
  const GetCharacters({required this.repository});

  final CharacterRepository repository;

  Future<CharacterPage> call({String? url, String query = ''}) {
    return repository.getCharacters(url: url, query: query);
  }
}
