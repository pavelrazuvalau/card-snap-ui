/// 🔶 Locale Controller
///
/// Centralized controller for managing current app locale.
/// Similar to Angular service that exposes current language and a setter.
library core.platform.locale_controller;

import 'package:flutter/widgets.dart';

class LocaleController {
  LocaleController._internal();

  static final LocaleController instance = LocaleController._internal();

  /// Holds the currently selected locale. `null` means "follow system".
  final ValueNotifier<Locale?> locale = ValueNotifier<Locale?>(null);

  void setLocale(Locale? newLocale) {
    locale.value = newLocale;
  }

  /// Shared resolver to keep fallback policy in one place.
  static Locale resolveLocale(Locale? deviceLocale, Iterable<Locale> supported) {
    if (supported.isEmpty) {
      return const Locale('en');
    }
    if (deviceLocale == null) {
      return supported.first;
    }
    for (final l in supported) {
      if (l.languageCode == deviceLocale.languageCode) return l;
    }
    return supported.first; // fallback to first (en)
  }
}


