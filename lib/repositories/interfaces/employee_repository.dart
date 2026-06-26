import '../../models/models.dart';

abstract class EmployeeRepository {
  Future<Employee> getEmployee();
  Future<Employee> createEmployee(Employee employee);
  Future<Employee> updateEmployee(Employee employee);
  Future<void> deleteEmployee();
}
