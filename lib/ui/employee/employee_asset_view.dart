import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../localizations/localizations.dart';
import '../../routing/routing.dart';
import '../ui.dart';

class EmployeeAssetView extends StatefulWidget {
  const EmployeeAssetView({super.key});

  static MaterialPage page() {
    return const MaterialPage(
      name: AppLinkLocationKeys.employeeAssetsView,
      key: ValueKey(AppLinkLocationKeys.employeeAssetsView),
      child: EmployeeAssetView(),
    );
  }

  @override
  State<EmployeeAssetView> createState() => _AssetsViewState();
}

class _AssetsViewState extends State<EmployeeAssetView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EmployeeAssetViewModel>.reactive(
      viewModelBuilder: () => EmployeeAssetViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(LocaleKeys.navbar_asset.tr())],
              ),
            ),
          ],
        );
      },
    );
  }
}