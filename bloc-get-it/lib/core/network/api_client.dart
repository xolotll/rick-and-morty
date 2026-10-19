import 'package:dio/dio.dart';

class ApiClient {
  ApiClient._();

  static Dio createDio({required String baseUrl}) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: const {'Accept': 'application/json'},
      ),
    );
  }
}
