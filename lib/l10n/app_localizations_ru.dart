// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get retry => 'Повторить';

  @override
  String get noCardsYet => 'Пока нет карт';

  @override
  String get emptyHint =>
      'Добавьте первую карту, отсканировав QR-код или штрихкод';

  @override
  String get unknownState => 'Неизвестное состояние';

  @override
  String get languageSystemDefault => 'Системный по умолчанию';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageUkrainian => 'Українська';

  @override
  String get languagePolish => 'Polski';

  @override
  String get actionEdit => 'Редактировать';

  @override
  String get actionDelete => 'Удалить';
}
