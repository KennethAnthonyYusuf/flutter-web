import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../localizations/localizations.dart';
import '../../routing/routing.dart';
import '../ui.dart';

class EmployeeEmergencyView extends StatefulWidget {
  const EmployeeEmergencyView({super.key});

  static MaterialPage page() {
    return const MaterialPage(
      name: AppLinkLocationKeys.employeeEmergencyView,
      key: ValueKey(AppLinkLocationKeys.employeeEmergencyView),
      child: EmployeeEmergencyView(),
    );
  }

  @override
  State<EmployeeEmergencyView> createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmployeeEmergencyView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EmployeeEmergencyViewModel>.reactive(
      viewModelBuilder: () => EmployeeEmergencyViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(LocaleKeys.navbar_emergency.tr())],
              ),
            ),
          ],
        );
      },
    );
  }
}