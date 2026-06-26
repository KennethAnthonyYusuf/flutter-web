import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable(explicitToJson: true)
class Employee {
  final String? companyDescription;

  final String? fullName;

  final String? employeeId;

  final String? employeeStatus;

  final String? hireDate;

  final String? terminationDate;

  final String? departmentDescription;

  final String? jobTitleDescription;

  final String? employeeType;

  final String? gender;

  final String? maritalStatus;

  final String? birthInfo;

  final String? homeAddress;

  final String? homePhoneNumber;

  final String? cellPhoneNumber;

  final String? emailAddress;

  final String? bankDetails;

  final String? userName;

  @JsonKey(defaultValue: <String>[])
  final List<String>? supportedDocuments;

  final String? lastUpdated;

  const Employee({
    this.companyDescription,
    this.fullName,
    this.employeeId,
    this.employeeStatus,
    this.hireDate,
    this.terminationDate,
    this.departmentDescription,
    this.jobTitleDescription,
    this.employeeType,
    this.gender,
    this.maritalStatus,
    this.birthInfo,
    this.homeAddress,
    this.homePhoneNumber,
    this.cellPhoneNumber,
    this.emailAddress,
    this.bankDetails,
    this.userName,
    this.supportedDocuments,
    this.lastUpdated,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
