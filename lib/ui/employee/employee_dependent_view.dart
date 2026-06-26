import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../localizations/localizations.dart';
import '../../routing/routing.dart';
import '../ui.dart';

class EmployeeDependentView extends StatefulWidget {
  const EmployeeDependentView({super.key});

  static MaterialPage page() {
    return const MaterialPage(
      name: AppLinkLocationKeys.employeeDependentView,
      key: ValueKey(AppLinkLocationKeys.employeeDependentView),
      child: EmployeeDependentView(),
    );
  }

  @override
  State<EmployeeDependentView> createState() => _DependentViewState();
}

class _DependentViewState extends State<EmployeeDependentView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EmployeeDependentViewModel>.reactive(
      viewModelBuilder: () => EmployeeDependentViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(LocaleKeys.navbar_dependent.tr())],
              ),
            ),
          ],
        );
      },
    );
  }
}