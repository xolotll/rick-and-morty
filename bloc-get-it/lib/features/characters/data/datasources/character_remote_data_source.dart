import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/network/api_client.dart';
import '../models/character_page_model/character_page_model.dart';

class CharacterRemoteDataSource {
  CharacterRemoteDataSource({required this._apiClient});

  final ApiClient _apiClient;

  Future<CharacterPageModel> getCharacters({
    String? url,
    String query = '',
  }) async {
    final response = await _apiClient.get<Map<String, dynamic>>(
      url ?? ApiConstants.charactersPath,
      queryParameters: url == null
          ? {if (query.trim().isNotEmpty) 'name': query.trim()}
          : null,
    );

    final data = response.data;

    if (data == null) {
      throw const AppException(AppErrorType.unknown);
    }

    return CharacterPageModel.fromJson(data);
  }
}
