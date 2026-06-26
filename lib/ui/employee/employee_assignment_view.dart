import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../localizations/localizations.dart';
import '../../routing/routing.dart';
import '../ui.dart';

class EmployeeAssignmentView extends StatefulWidget {
  const EmployeeAssignmentView({super.key});

  static MaterialPage page() {
    return const MaterialPage(
      name: AppLinkLocationKeys.employeeAssignmentView,
      key: ValueKey(AppLinkLocationKeys.employeeAssignmentView),
      child: EmployeeAssignmentView(),
    );
  }

  @override
  State<EmployeeAssignmentView> createState() => _AssignmentViewState();
}

class _AssignmentViewState extends State<EmployeeAssignmentView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EmployeeAssignmentViewModel>.reactive(
      viewModelBuilder: () => EmployeeAssignmentViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(LocaleKeys.navbar_assignment.tr())],
              ),
            ),
          ],
        );
      },
    );
  }
}