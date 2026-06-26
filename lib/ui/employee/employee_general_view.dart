import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../localizations/localizations.dart';
import '../../models/models.dart';
import '../ui.dart';
import '../../constants/constants.dart';

class EmployeeGeneralView extends StatelessWidget {
  const EmployeeGeneralView({
    super.key,
    required this.employee,
    required this.onReload,
  });

  final Employee? employee;
  final Future<void> Function() onReload;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EmployeeGeneralViewModel>.reactive(
      viewModelBuilder: () => EmployeeGeneralViewModel(employee, onReload),
      onViewModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            viewModel.editMode
                ? EmployeeGeneralEditView(
                    viewModel: viewModel,
                    onCancel: viewModel.cancelEdit,
                    onSave: viewModel.doSave,
                    employee: employee,
                  )
                : EmployeeGeneralReadView(
                    viewModel: viewModel,
                    onEdit: viewModel.doEdit,
                    employee: employee,
                  ),
            if (viewModel.isBusy) const Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }
}

class EmployeeGeneralReadView extends StatelessWidget {
  const EmployeeGeneralReadView({
    super.key,
    required this.viewModel,
    required this.onEdit,
    required this.employee,
  });

  final EmployeeGeneralViewModel viewModel;
  final VoidCallback onEdit;
  final Employee? employee;

  @override
  Widget build(BuildContext context) {
    final items = <MapEntry<String, Widget>>[
      MapEntry(LocaleKeys.employeeGeneralInfo_company.tr(), Text(employee?.companyDescription ?? '')),
      MapEntry(LocaleKeys.employeeGeneralInfo_fullName.tr(), Text(employee?.fullName ?? '')),
      MapEntry(LocaleKeys.employeeGeneralInfo_employeeId.tr(), Text(employee?.employeeId ?? '')),
      MapEntry(LocaleKeys.employeeGeneralInfo_employeeStatus.tr(), Text(employee?.employeeStatus ?? '')),
      MapEntry(LocaleKeys.employeeGeneralInfo_hireDate.tr(), Text(employee?.hireDate ?? '')),
      MapEntry(LocaleKeys.employeeGeneralInfo_terminationDate.tr(), Text(employee?.terminationDate ?? '')),
      MapEntry(LocaleKeys.employeeGeneralInfo_department.tr(), Text(employee?.departmentDescription ?? '')),
      MapEntry(LocaleKeys.employeeGeneralInfo_jobTitle.tr(), Text(employee?.jobTitleDescription ?? '')),
      MapEntry(LocaleKeys.employeeGeneralInfo_employeeType.tr(), Text(employee?.employeeType ?? '')),
      MapEntry(LocaleKeys.employeeGeneralInfo_gender.tr(), Text(employee?.gender ?? '')),
      MapEntry(LocaleKeys.employeeGeneralInfo_maritalStatus.tr(), Text(employee?.maritalStatus ?? '')),
      MapEntry(LocaleKeys.employeeGeneralInfo_birthInfo.tr(), Text(employee?.birthInfo ?? '')),
      MapEntry(LocaleKeys.employeeGeneralInfo_homeAddress.tr(), Text(employee?.homeAddress ?? '')),
      MapEntry(LocaleKeys.employeeGeneralInfo_homePhone.tr(), Text(employee?.homePhoneNumber ?? '')),
      MapEntry(
        LocaleKeys.employeeGeneralInfo_cellPhone.tr(),
        Text(
          employee?.cellPhoneNumber ?? '',
          style: const TextStyle(color: AppColors.textTertiary),
        ),
      ),
      MapEntry(
        LocaleKeys.employeeGeneralInfo_email.tr(),
        Text(
          employee?.emailAddress ?? '',
          style: const TextStyle(color: AppColors.textTertiary),
        ),
      ),
      MapEntry(LocaleKeys.employeeGeneralInfo_bankDetails.tr(), Text(employee?.bankDetails ?? '')),
      MapEntry(LocaleKeys.employeeGeneralInfo_userName.tr(), Text(employee?.userName ?? '')),
      MapEntry(
        LocaleKeys.employeeGeneralInfo_supportedDocument.tr(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: (employee?.supportedDocuments ?? const <String>[])
              .map(
                (doc) => Text(
                  doc,
                  style: const TextStyle(color: AppColors.textTertiary),
                ),
              )
              .toList(),
        ),
      ),
      MapEntry(LocaleKeys.employeeGeneralInfo_lastUpdate.tr(), Text(employee?.lastUpdated ?? '')),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: EmployeeGeneralSpacing.scrollPaddingHorizontal,
        vertical: EmployeeGeneralSpacing.scrollPaddingVertical,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: EmployeeGeneralSpacing.constrainedBoxMaxWidth,
          ),
          child: Card(
            elevation: AppElevation.none,
            color: AppColors.backgroundPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(EmployeeRadius.generalCard),
              side: BorderSide(color: EmployeeColors.cardBorder),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: EmployeeGeneralSpacing.cardPaddingHorizontal,
                vertical: EmployeeGeneralSpacing.cardPaddingVertical,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        for (final entry in items) _KeyValueRow(label: entry.key, value: entry.value),
                        const SizedBox(height: EmployeeGeneralSpacing.listBottomGap),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: onEdit,
                    style: TextButton.styleFrom(
                      minimumSize: const Size(
                        EmployeeGeneralSpacing.editButtonMinWidth,
                        EmployeeGeneralSpacing.editButtonHeight,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(EmployeeRadius.button),
                      ),
                      backgroundColor: AppColors.backgroundQuinary,
                      foregroundColor: AppColors.backgroundPrimary,
                    ),
                    child: Text(LocaleKeys.buttons_edit.tr()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmployeeGeneralEditView extends StatefulWidget {
  const EmployeeGeneralEditView({
    super.key,
    required this.viewModel,
    required this.onCancel,
    required this.onSave,
    required this.employee,
  });

  final EmployeeGeneralViewModel viewModel;
  final VoidCallback onCancel;
  final Employee? employee;
  final Future<void> Function(Employee updated) onSave;

  @override
  State<EmployeeGeneralEditView> createState() => _EmployeeGeneralEditViewState();
}

class _EmployeeGeneralEditViewState extends State<EmployeeGeneralEditView> {
  late final TextEditingController _companyController;
  late final TextEditingController _fullNameController;
  late final TextEditingController _employeeIDController;
  late final TextEditingController _employeeStatusController;
  late final TextEditingController _hireDateController;
  late final TextEditingController _terminationDateController;
  late final TextEditingController _departmentController;
  late final TextEditingController _jobTitleController;
  late final TextEditingController _employeeTypeController;
  late final TextEditingController _genderController;
  late final TextEditingController _maritalStatusController;
  late final TextEditingController _birthInfoController;
  late final TextEditingController _homeAddressController;
  late final TextEditingController _homePhoneNumberController;
  late final TextEditingController _cellPhoneNumberController;
  late final TextEditingController _emailAddressController;
  late final TextEditingController _bankDetailsController;
  late final TextEditingController _userNameController;
  late final TextEditingController _supportedDocumentsController;
  late final TextEditingController _lastUpdatedController;

  @override
  void initState() {
    super.initState();
    _companyController = TextEditingController(text: widget.employee?.companyDescription ?? '');
    _fullNameController = TextEditingController(text: widget.employee?.fullName ?? '');
    _employeeIDController = TextEditingController(text: widget.employee?.employeeId ?? '');
    _employeeStatusController = TextEditingController(text: widget.employee?.employeeStatus ?? '');
    _hireDateController = TextEditingController(text: widget.employee?.hireDate ?? '');
    _terminationDateController = TextEditingController(text: widget.employee?.terminationDate ?? '');
    _departmentController = TextEditingController(text: widget.employee?.departmentDescription ?? '');
    _jobTitleController = TextEditingController(text: widget.employee?.jobTitleDescription ?? '');
    _employeeTypeController = TextEditingController(text: widget.employee?.employeeType ?? '');
    _genderController = TextEditingController(text: widget.employee?.gender ?? '');
    _maritalStatusController = TextEditingController(text: widget.employee?.maritalStatus ?? '');
    _birthInfoController = TextEditingController(text: widget.employee?.birthInfo ?? '');
    _homeAddressController = TextEditingController(text: widget.employee?.homeAddress ?? '');
    _homePhoneNumberController = TextEditingController(text: widget.employee?.homePhoneNumber ?? '');
    _cellPhoneNumberController = TextEditingController(text: widget.employee?.cellPhoneNumber ?? '');
    _emailAddressController = TextEditingController(text: widget.employee?.emailAddress ?? '');
    _bankDetailsController = TextEditingController(text: widget.employee?.bankDetails ?? '');
    _userNameController = TextEditingController(text: widget.employee?.userName ?? '');
    _supportedDocumentsController = TextEditingController(text: widget.employee?.supportedDocuments?.join(', ') ?? '');
    _lastUpdatedController = TextEditingController(text: widget.employee?.lastUpdated ?? '');
  }

  @override
  void dispose() {
    _companyController.dispose();
    _fullNameController.dispose();
    _employeeIDController.dispose();
    _employeeStatusController.dispose();
    _hireDateController.dispose();
    _terminationDateController.dispose();
    _departmentController.dispose();
    _jobTitleController.dispose();
    _employeeTypeController.dispose();
    _genderController.dispose();
    _maritalStatusController.dispose();
    _birthInfoController.dispose();
    _homeAddressController.dispose();
    _homePhoneNumberController.dispose();
    _cellPhoneNumberController.dispose();
    _emailAddressController.dispose();
    _bankDetailsController.dispose();
    _userNameController.dispose();
    _supportedDocumentsController.dispose();
    _lastUpdatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: EmployeeGeneralSpacing.editFormPaddingHorizontal,
        vertical: EmployeeGeneralSpacing.editFormPaddingVertical,
      ),
      child: Column(
        children: [
          TextField(controller: _companyController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_company.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _fullNameController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_fullName.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _employeeIDController, readOnly: true, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_employeeId.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _employeeStatusController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_employeeStatus.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _hireDateController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_hireDate.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _terminationDateController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_terminationDate.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _departmentController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_department.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _jobTitleController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_jobTitle.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _employeeTypeController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_employeeType.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _genderController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_gender.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _maritalStatusController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_maritalStatus.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _birthInfoController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_birthInfo.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _homeAddressController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_homeAddress.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _homePhoneNumberController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_homePhone.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _cellPhoneNumberController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_cellPhone.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _emailAddressController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_email.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _bankDetailsController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_bankDetails.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _userNameController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_userName.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _supportedDocumentsController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_supportedDocument.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          TextField(controller: _lastUpdatedController, decoration: InputDecoration(labelText: LocaleKeys.employeeGeneralInfo_lastUpdate.tr())),
          const SizedBox(height: EmployeeGeneralSpacing.fieldSpacing),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: widget.onCancel,
                child: Text(LocaleKeys.buttons_cancel.tr()),
              ),
              const SizedBox(width: EmployeeGeneralSpacing.buttonSpacing),
              ElevatedButton(
                onPressed: () async {
                  final updated = Employee(
                    companyDescription: _companyController.text.trim(),
                    fullName: _fullNameController.text.trim(),
                    employeeId: widget.employee?.employeeId,
                    employeeStatus: _employeeStatusController.text.trim(),
                    hireDate: _hireDateController.text.trim(),
                    terminationDate: _terminationDateController.text.trim(),
                    departmentDescription: _departmentController.text.trim(),
                    jobTitleDescription: _jobTitleController.text.trim(),
                    employeeType: _employeeTypeController.text.trim(),
                    gender: _genderController.text.trim(),
                    maritalStatus: _maritalStatusController.text.trim(),
                    birthInfo: _birthInfoController.text.trim(),
                    homeAddress: _homeAddressController.text.trim(),
                    homePhoneNumber: _homePhoneNumberController.text.trim(),
                    cellPhoneNumber: _cellPhoneNumberController.text.trim(),
                    emailAddress: _emailAddressController.text.trim(),
                    bankDetails: _bankDetailsController.text.trim(),
                    userName: _userNameController.text.trim(),
                    supportedDocuments: _supportedDocumentsController.text
                        .split(',')
                        .map((doc) => doc.trim())
                        .toList(),
                    lastUpdated: _lastUpdatedController.text.trim(),
                  );
                  await widget.onSave(updated);
                },
                child: Text(LocaleKeys.buttons_save.tr()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow({
    required this.label,
    required this.value,
  });

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: EmployeeGeneralSpacing.keyValueRowVerticalPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: EmployeeGeneralSpacing.keyLabelWidth,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: EmployeeTextSize.normal,
              ),
            ),
          ),
          const SizedBox(width: EmployeeGeneralSpacing.keyValueGap),
          Expanded(
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: EmployeeTextSize.normal,
                color: AppColors.textPrimary,
              ),
              child: value,
            ),
          ),
        ],
      ),
    );
  }
}
