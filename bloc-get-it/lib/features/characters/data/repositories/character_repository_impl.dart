import '../../domain/entities/character_page.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/character_remote_data_source.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  CharacterRepositoryImpl({required this._remoteDataSource});

  final CharacterRemoteDataSource _remoteDataSource;

  @override
  Future<CharacterPage> getCharacters({String? url, String query = ''}) async {
    final model = await _remoteDataSource.getCharacters(url: url, query: query);

    return model.toEntity();
  }
}
