import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../repositories.dart';
import '../../models/models.dart';

class EmployeeRepositoryImpl extends RestApiRepositoryBase
    implements EmployeeRepository {
  EmployeeRepositoryImpl({super.base});

  @override
  Future<Employee> getEmployee() async {
    final map = await get('/employees');
    debugPrint('GET response: $map');
    return Employee.fromJson(map);
  }

  @override
  Future<Employee> createEmployee(Employee employee) async {
    final map = await post(
      '/employees',
      jsonEncode(employee.toJson()),
    );
    debugPrint('POST response: $map');
    return Employee.fromJson(map);
  }

  @override
  Future<Employee> updateEmployee(Employee employee) async {
    final map = await put(
      '/employees',
      jsonEncode(employee.toJson()),
    );
    debugPrint('PUT response: $map');
    return Employee.fromJson(map);
  }

  @override
  Future<void> deleteEmployee() async {
    await deleteContent('/employees');
  }
}
