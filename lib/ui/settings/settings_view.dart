import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../routing/routing.dart';
import '../../localizations/localizations.dart';
import '../ui.dart';
import '../../constants/constants.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  static MaterialPage page() {
    return MaterialPage(
      name: AppLinkLocationKeys.settingsView,
      key: const ValueKey(AppLinkLocationKeys.settingsView),
      child: const SettingsView(),
    );
  }

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Center(
              child: SizedBox(
                width: SettingsSize.dialogWidth,
                height: SettingsSize.dialogHeight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SettingsRadius.dialog),
                    border: Border.all(
                      color: SettingsColors.border,
                      width: SettingsBorder.width,
                    ),
                    color: SettingsColors.background,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: SettingsSpacing.topGapSmall),
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                LocaleKeys.settingsInfo_settingsPage.tr(),
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: viewModel.cancel,
                            icon: const Icon(SettingsIcons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: SettingsSpacing.gapMedium),
                      DropdownButton<Locale>(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SettingsSpacing.dropdownPaddingHorizontal,
                        ),
                        value: viewModel.selectedLocale,
                        hint: Text(LocaleKeys.settingsInfo_selectLanguage.tr()),
                        isExpanded: true,
                        items: viewModel.supportedLocales.map((locale) {
                          return DropdownMenuItem(
                            value: locale,
                            child: Text(viewModel.getLocaleName(locale)),
                          );
                        }).toList(),
                        onChanged: viewModel.onLocaleChanged,
                      ),
                      const SizedBox(height: SettingsSpacing.gapMedium),
                      ElevatedButton(
                        onPressed: () => viewModel.save(context),
                        child: Text(LocaleKeys.buttons_save.tr()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (viewModel.isBusy) const Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }
}
