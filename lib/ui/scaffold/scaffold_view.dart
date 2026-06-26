import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../ui.dart';
import '../../localizations/localizations.dart';
import '../../constants/constants.dart';

class ScaffoldView extends StatelessWidget {
  const ScaffoldView({super.key, required this.viewModel});
  final ScaffoldViewModel viewModel;

  static MaterialPage page() {
    return MaterialPage(
      name: MainScaffoldIds.routeName,
      key: const ValueKey(MainScaffoldIds.routeKey),
      child: ViewModelBuilder<ScaffoldViewModel>.reactive(
        viewModelBuilder: () => ScaffoldViewModel(),
        onViewModelReady: (viewModel) => viewModel.initialize(),
        builder: (context, viewModel, child) => ScaffoldView(viewModel: viewModel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final navButtonStyle = TextButton.styleFrom(
      foregroundColor: ScaffoldColors.navTextColor,
    );

    const navTextStyle = TextStyle(fontSize: ScaffoldTextSize.navTitle);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => viewModel.onNavigationItemClicked(0),
                    style: navButtonStyle,
                    child: Text(LocaleKeys.navbar_home.tr(), style: navTextStyle),
                  ),
                  const SizedBox(width: ScaffoldSpacing.navGap),
                  TextButton(
                    onPressed: () => viewModel.onNavigationItemClicked(1),
                    style: navButtonStyle,
                    child: Text(LocaleKeys.navbar_employee.tr(), style: navTextStyle),
                  ),
                  const SizedBox(width: ScaffoldSpacing.navGap),
                  TextButton(
                    onPressed: () => viewModel.onNavigationItemClicked(2),
                    style: navButtonStyle,
                    child: Text(LocaleKeys.navbar_product.tr(), style: navTextStyle),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(ScaffoldIcons.settings),
              onPressed: viewModel.onSettingsTabChanged,
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              if (viewModel.currentNavIndex == 0) const HomeView(),
              if (viewModel.currentNavIndex == 1) const Positioned.fill(child: EmployeeView()),
              if (viewModel.currentNavIndex == 2) const Positioned.fill(child: ProductView()),
              if (viewModel.setSettingsIndex == 1)
                const Center(
                  child: SizedBox(
                    width: ScaffoldSpacing.settingsWidth,
                    height: ScaffoldSpacing.settingsHeight,
                    child: SettingsView(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
