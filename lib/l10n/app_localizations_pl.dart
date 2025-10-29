// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get retry => 'Ponów';

  @override
  String get noCardsYet => 'Brak kart';

  @override
  String get emptyHint =>
      'Dodaj pierwszą kartę, skanując kod QR lub kod kreskowy';

  @override
  String get unknownState => 'Nieznany stan';

  @override
  String get languageSystemDefault => 'Język systemu';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageUkrainian => 'Українська';

  @override
  String get languagePolish => 'Polski';

  @override
  String get actionEdit => 'Edytuj';

  @override
  String get actionDelete => 'Usuń';
}
