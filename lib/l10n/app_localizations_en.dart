// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get retry => 'Retry';

  @override
  String get noCardsYet => 'No cards yet';

  @override
  String get emptyHint =>
      'Add your first loyalty card by scanning a QR code or barcode';

  @override
  String get unknownState => 'Unknown state';

  @override
  String get languageSystemDefault => 'System default';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageUkrainian => 'Українська';

  @override
  String get languagePolish => 'Polski';

  @override
  String get actionEdit => 'Edit';

  @override
  String get actionDelete => 'Delete';
}
