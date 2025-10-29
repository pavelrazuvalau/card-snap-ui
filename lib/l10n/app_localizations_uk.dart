// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get retry => 'Спробувати ще раз';

  @override
  String get noCardsYet => 'Поки немає карт';

  @override
  String get emptyHint =>
      'Додайте першу карту, відсканувавши QR-код або штрихкод';

  @override
  String get unknownState => 'Невідомий стан';

  @override
  String get languageSystemDefault => 'Мова системи';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageUkrainian => 'Українська';

  @override
  String get languagePolish => 'Polski';

  @override
  String get actionEdit => 'Редагувати';

  @override
  String get actionDelete => 'Видалити';
}
