import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../localizations/localizations.dart';
import '../../routing/routing.dart';
import '../ui.dart';

class EmployeeEmploymentView extends StatefulWidget {
  const EmployeeEmploymentView({super.key});

  static MaterialPage page() {
    return const MaterialPage(
      name: AppLinkLocationKeys.employeeEmploymentView,
      key: ValueKey(AppLinkLocationKeys.employeeEmploymentView),
      child: EmployeeEmploymentView(),
    );
  }

  @override
  State<EmployeeEmploymentView> createState() => _EmploymentViewState();
}

class _EmploymentViewState extends State<EmployeeEmploymentView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EmployeeEmploymentViewModel>.reactive(
      viewModelBuilder: () => EmployeeEmploymentViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(LocaleKeys.navbar_employment.tr())],
              ),
            ),
          ],
        );
      },
    );
  }
}