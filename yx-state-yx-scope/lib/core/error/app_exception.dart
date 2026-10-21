import '../../l10n/app_localizations.dart';

enum AppErrorType {
  timeout,
  noInternet,
  tooManyRequests,
  serverUnavailable,
  nothingFound,
  unknown,
}

class AppException implements Exception {
  const AppException(this.type, {this.retryAfter});

  final AppErrorType type;
  final Duration? retryAfter;

  String localize(AppLocalizations l10n) {
    switch (type) {
      case AppErrorType.timeout:
        return l10n.errorTimeout;

      case AppErrorType.noInternet:
        return l10n.errorNoInternet;

      case AppErrorType.tooManyRequests:
        return l10n.errorTooManyRequests(retryAfter?.inSeconds ?? 10);

      case AppErrorType.serverUnavailable:
        return l10n.errorServerUnavailable;

      case AppErrorType.unknown:
        return l10n.errorUnknown;

      case AppErrorType.nothingFound:
        return l10n.nothingFound;
    }
  }

  @override
  String toString() => type.name;
}
