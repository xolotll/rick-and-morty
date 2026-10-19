import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/app_exception.dart';
import '../models/character_page_model.dart';

class CharacterRemoteDataSource {
  CharacterRemoteDataSource({required this._dio});

  final Dio _dio;

  Future<CharacterPageModel> getCharacters({
    String? url,
    String query = '',
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        url ?? ApiConstants.charactersPath,
        queryParameters: url == null
            ? {if (query.trim().isNotEmpty) 'name': query.trim()}
            : null,
      );
      // print(response);
      // print('');
      // print('-' * 25);
      // print('');

      final data = response.data;

      if (data == null) {
        throw const AppException(AppErrorType.unknown);
      }

      return CharacterPageModel.fromJson(data);
    } on DioException catch (error) {
      if (error.response?.statusCode == 404) {
        return const CharacterPageModel(characters: []);
      }

      throw _exceptionFor(error);
    }
  }

  AppException _exceptionFor(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return const AppException(AppErrorType.timeout);
    }

    if (error.type == DioExceptionType.connectionError) {
      return const AppException(AppErrorType.noInternet);
    }

    final statusCode = error.response?.statusCode;

    if (statusCode == 429) {
      final retryAfter = error.response?.headers.value('retry-after');
      final seconds = int.tryParse(retryAfter ?? '');
      return AppException(
        AppErrorType.tooManyRequests,
        retryAfter: seconds == null ? null : Duration(seconds: seconds),
      );
    }

    if (statusCode != null && statusCode >= 500) {
      return const AppException(AppErrorType.serverUnavailable);
    }

    return const AppException(AppErrorType.unknown);
  }
}
