import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

class EmployeeGeneralViewModel extends BaseViewModel {
  EmployeeGeneralViewModel(this.employee, this.onReload);
  final Employee? employee;
  final Future<void> Function() onReload;

  bool editMode = false;
  final EmployeeRepository _employeeRepository = GetIt.instance<EmployeeRepository>();

  Future<void> initialize() async {

  }

  void doEdit() {
    editMode = true;
    notifyListeners();
  }

  void cancelEdit() {
    editMode = false;
    notifyListeners();
  }

  Future<void> doSave(Employee updatedEmployee) async {

    await runBusyFuture(saveEmployeeDataToApi(updatedEmployee));
    editMode = false;
  }

  Future<void> saveEmployeeDataToApi(Employee updatedEmployee) async {
    if (employee == null) {
      await _employeeRepository.createEmployee(updatedEmployee);
    } else {
      await _employeeRepository.updateEmployee(updatedEmployee);
    }
    await onReload();
  }

}