import 'package:dio/dio.dart';

import 'dio_exception_mapper.dart';

class ApiClient {
  ApiClient({required this._dio, required this._exceptionMapper});

  final Dio _dio;
  final DioExceptionMapper _exceptionMapper;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } on DioException catch (error) {
      throw _exceptionMapper.map(error);
    }
  }
}
