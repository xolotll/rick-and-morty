// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Рик и Морти';

  @override
  String get language => 'Язык';

  @override
  String get theme => 'Тема';

  @override
  String get lightTheme => 'Светлая';

  @override
  String get darkTheme => 'Тёмная';

  @override
  String get english => 'Английский';

  @override
  String get russian => 'Русский';

  @override
  String get findCharacter => 'Найти персонажа...';

  @override
  String get failedToLoadCharacters => 'Не удалось загрузить персонажей';

  @override
  String get refresh => 'Повторить';

  @override
  String get nothingFound => 'Ничего не найдено по запросу';

  @override
  String get loadingCharacters => 'Загружаем персонажей...';

  @override
  String get species => 'Разновидность';

  @override
  String get type => 'Тип';

  @override
  String get notSpecified => 'Не указан';

  @override
  String get gender => 'Гендер';

  @override
  String get origin => 'Происхождение';

  @override
  String get lastKnownLocation => 'Последнее известное местоположение';

  @override
  String get errorTimeout => 'Превышено время ожидания ответа сервера';

  @override
  String get errorNoInternet => 'Нет подключения к интернету';

  @override
  String errorTooManyRequests(int seconds) {
    return 'Слишком много запросов, попробуйте через $seconds сек.';
  }

  @override
  String get errorServerUnavailable =>
      'Сервер временно недоступен, попробуйте позже';

  @override
  String get errorUnknown => 'Не удалось загрузить персонажей';
}
