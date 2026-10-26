import 'package:dio/dio.dart';

import '../error/app_exception.dart';

class DioExceptionMapper {
  const DioExceptionMapper();

  AppException map(DioException error) {
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

    if (statusCode == 404) {
      return const AppException(AppErrorType.nothingFounded);
    }

    if (statusCode != null && statusCode >= 500) {
      return const AppException(AppErrorType.serverUnavailable);
    }

    return const AppException(AppErrorType.unknown);
  }
}
