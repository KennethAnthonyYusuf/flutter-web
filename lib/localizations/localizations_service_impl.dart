import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl_standalone.dart'
    if (dart.library.html) 'package:intl/intl_browser.dart';

import 'localizations.dart';

class LocalizationServiceImpl extends LocalizationService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late Locale _locale;

  @override
  Future<void> initialize() async {
    late Locale result;
    var lang = await _storage.read(key: 'locale_preference');
    if (lang != null) {
      result = _toSupportedLocale(lang);
    } else {
      result = await _getDeviceLocale();
    }

    if (supportedLocales.contains(result)) {
      _locale = result;
    } else {
      _locale = defaultLocale;
    }
  }

  @override
  Locale get defaultLocale => const Locale('en');

  @override
  List<Locale> get supportedLocales => const [
        Locale('en'),
        Locale('id'),
      ];

  @override
  Locale get locale => _locale;

  @override
  String get localeHeader {
    return getLocaleID(_locale);
  }

  @override
  String getLocaleID(Locale locale) {
    var localeString = locale.toString();
    return localeString;
  }

  @override
  String getLocaleName(Locale locale) {
    return LocaleKeys.languageName.tr(gender: locale.toString());
  }

  @override
  Future setLocale(Locale locale, {BuildContext? context}) async {
    if (supportedLocales.contains(locale)) {
      _locale = locale;
    } else {
      _locale = defaultLocale;
    }

    await _storage.write(key: 'locale_preference', value: _locale.toString());

    if (context != null && context.mounted) {
      await context.setLocale(_locale);
    }
  }

  @override
  Future resetLocale({BuildContext? context}) async {
    await _storage.delete(key: 'locale_preference');
    var locale = await _getDeviceLocale();
    if (supportedLocales.contains(locale)) {
      _locale = locale;
    } else {
      _locale = defaultLocale;
    }

    if (context != null && context.mounted) {
      try {
        await context.setLocale(_locale);
      } catch (_) {}
    }
  }

  Future<Locale> _getDeviceLocale() async {
    final platformLocale = await findSystemLocale();
    return _toSupportedLocale(platformLocale);
  }

  Locale _toSupportedLocale(String value) {
    if (value.startsWith('en')) {
      return defaultLocale;
    } else {
      return value.toLocale();
    }
  }
}
