import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';

import '../../localizations/localizations.dart';
import '../../providers/provider.dart';

class SettingsViewModel extends BaseViewModel {
  final _localizationService = GetIt.instance<LocalizationService>();
  final _appStateManager = GetIt.instance.get<AppStateManager>();

  Locale? _selectedLocale;
  Locale? get selectedLocale => _selectedLocale;
  List<Locale> get supportedLocales =>
      _localizationService.supportedLocales;

  Future<void> initialize() async {
    _selectedLocale = _localizationService.locale;
  }

  void onLocaleChanged(Locale? locale) {
    _selectedLocale = locale;
    notifyListeners();
  }

  String getLocaleName(Locale locale) =>
      _localizationService.getLocaleName(locale);

  Future<void> save(BuildContext context) async {
    if (_selectedLocale == null) return;

    await runBusyFuture(_localizationService.setLocale(
      _selectedLocale!,
      context: context,
    ));
    _appStateManager.setCancelSettings();
  }

  void cancel() {
    _appStateManager.setCancelSettings();
  }

}