// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Rick and Morty';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get english => 'English';

  @override
  String get russian => 'Russian';

  @override
  String get findCharacter => 'Find character...';

  @override
  String get failedToLoadCharacters => 'Failed to load characters';

  @override
  String get refresh => 'Refresh';

  @override
  String get nothingFound => 'Nothing found for your request';

  @override
  String get loadingCharacters => 'Loading Characters...';

  @override
  String get species => 'Species';

  @override
  String get type => 'Type';

  @override
  String get notSpecified => 'Not specified';

  @override
  String get gender => 'Gender';

  @override
  String get origin => 'Origin';

  @override
  String get lastKnownLocation => 'Last known location';

  @override
  String get errorTimeout => 'The server response timed out';

  @override
  String get errorNoInternet => 'No internet connection';

  @override
  String errorTooManyRequests(int seconds) {
    return 'Too many requests, try again in $seconds sec.';
  }

  @override
  String get errorServerUnavailable =>
      'The server is temporarily unavailable. Please try again later.';

  @override
  String get errorUnknown => 'Failed to load characters';
}
