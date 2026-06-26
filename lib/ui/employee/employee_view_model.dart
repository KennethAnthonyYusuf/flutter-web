import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import '../../models/models.dart';
import '../../providers/app_state_manager.dart';
import '../../repositories/repositories.dart';

class EmployeeViewModel extends BaseViewModel {
  final AppStateManager _appStateManager = GetIt.instance.get<AppStateManager>();
  final EmployeeRepository _employeeRepository = GetIt.instance<EmployeeRepository>();

  Employee? employee;
  int _currentNavigationIndex = 0;
  int get currentNavIndex => _currentNavigationIndex;

  Future<void> initialize() async {
    _appStateManager.addListener(_appStateUpdated);
    _appStateUpdated();
    await runBusyFuture(fetchEmployeeDataFromApi());
  }

  Future<void> fetchEmployeeDataFromApi() async {
    employee = await _employeeRepository.getEmployee();
    notifyListeners();
  }

  Future<void> reLoadEmployeeData() async {
    await runBusyFuture(fetchEmployeeDataFromApi());
  }

  void _appStateUpdated() {
    if (_appStateManager.employeeGeneralView) {
      _currentNavigationIndex = 0;
    } else if (_appStateManager.employeeEmploymentView) {
      _currentNavigationIndex = 1;
    } else if (_appStateManager.employeeAssignmentView) {
      _currentNavigationIndex = 2;
    } else if (_appStateManager.employeeAssetsView) {
      _currentNavigationIndex = 3;
    } else if (_appStateManager.employeeEmergencyView) {
      _currentNavigationIndex = 4;
    } else if (_appStateManager.employeeDependentView) {
      _currentNavigationIndex = 5;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _appStateManager.removeListener(_appStateUpdated);
    super.dispose();
  }

  Future onNavigationItemClicked(int index) async {
    _currentNavigationIndex = index;
    switch (index) {
      case 0:
        _appStateManager.setEmployeeGeneral();
        break;
      case 1:
        _appStateManager.setEmployeeEmployment();
        break;
      case 2:
        _appStateManager.setEmployeeAssignment();
        break;
      case 3:
        _appStateManager.setEmployeeAssets();
        break;
      case 4:
        _appStateManager.setEmployeeEmergency();
        break;
      case 5:
        _appStateManager.setEmployeeDependent();
        break;
    }
  }
}