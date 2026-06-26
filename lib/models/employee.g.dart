// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
  companyDescription: json['companyDescription'] as String?,
  fullName: json['fullName'] as String?,
  employeeId: json['employeeId'] as String?,
  employeeStatus: json['employeeStatus'] as String?,
  hireDate: json['hireDate'] as String?,
  terminationDate: json['terminationDate'] as String?,
  departmentDescription: json['departmentDescription'] as String?,
  jobTitleDescription: json['jobTitleDescription'] as String?,
  employeeType: json['employeeType'] as String?,
  gender: json['gender'] as String?,
  maritalStatus: json['maritalStatus'] as String?,
  birthInfo: json['birthInfo'] as String?,
  homeAddress: json['homeAddress'] as String?,
  homePhoneNumber: json['homePhoneNumber'] as String?,
  cellPhoneNumber: json['cellPhoneNumber'] as String?,
  emailAddress: json['emailAddress'] as String?,
  bankDetails: json['bankDetails'] as String?,
  userName: json['userName'] as String?,
  supportedDocuments:
      (json['supportedDocuments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  lastUpdated: json['lastUpdated'] as String?,
);

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
  'companyDescription': instance.companyDescription,
  'fullName': instance.fullName,
  'employeeId': instance.employeeId,
  'employeeStatus': instance.employeeStatus,
  'hireDate': instance.hireDate,
  'terminationDate': instance.terminationDate,
  'departmentDescription': instance.departmentDescription,
  'jobTitleDescription': instance.jobTitleDescription,
  'employeeType': instance.employeeType,
  'gender': instance.gender,
  'maritalStatus': instance.maritalStatus,
  'birthInfo': instance.birthInfo,
  'homeAddress': instance.homeAddress,
  'homePhoneNumber': instance.homePhoneNumber,
  'cellPhoneNumber': instance.cellPhoneNumber,
  'emailAddress': instance.emailAddress,
  'bankDetails': instance.bankDetails,
  'userName': instance.userName,
  'supportedDocuments': instance.supportedDocuments,
  'lastUpdated': instance.lastUpdated,
};
