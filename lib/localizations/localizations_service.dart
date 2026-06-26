import 'package:flutter/widgets.dart';

abstract class LocalizationService {
  Future<void> initialize();

  Locale get defaultLocale;
  List<Locale> get supportedLocales;
  Locale get locale;
  String get localeHeader;

  String getLocaleID(Locale locale);
  String getLocaleName(Locale locale);

  Future resetLocale({BuildContext? context});
  Future setLocale(Locale locale, {BuildContext? context});
}
