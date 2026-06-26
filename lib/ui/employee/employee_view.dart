import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../localizations/localizations.dart';
import '../ui.dart';
import '../../routing/routing.dart';
import '../../constants/constants.dart';

class EmployeeView extends StatelessWidget {
  const EmployeeView({super.key});

  static MaterialPage page() {
    return MaterialPage(
      name: AppLinkLocationKeys.employeeView,
      key: const ValueKey(AppLinkLocationKeys.employeeView),
      child: const EmployeeView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      body: ViewModelBuilder<EmployeeViewModel>.reactive(
        viewModelBuilder: () => EmployeeViewModel(),
        onViewModelReady: (viewModel) => viewModel.initialize(),
        builder: (context, viewModel, child) {
          final children = [
            EmployeeGeneralView(
              employee: viewModel.employee,
              onReload: viewModel.reLoadEmployeeData,
            ),
            const EmployeeEmploymentView(),
            const EmployeeAssignmentView(),
            const EmployeeAssetView(),
            const EmployeeEmergencyView(),
            const EmployeeDependentView(),
          ];

          return Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: EmployeeSpacing.boxConstraintsWidthMax,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: EmployeeSpacing.pageHorizontal,
                          vertical: EmployeeSpacing.pageVertical,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (viewModel.employee?.fullName ?? '').toUpperCase(),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: EmployeeTextSize.headerName,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: EmployeeViewSpacing.headerToContentGap),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: EmployeeSpacing.leftBoxSidebarWidth,
                                  child: _EmployeeSidebar(
                                    selectedIndex: viewModel.currentNavIndex,
                                    onSelect: viewModel.onNavigationItemClicked,
                                    viewModel: viewModel,
                                  ),
                                ),
                                const SizedBox(width: EmployeeViewSpacing.sidebarToContentGap),
                                Expanded(
                                  child: children[viewModel.currentNavIndex],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (viewModel.isBusy) const Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }
}

class _EmployeeSidebar extends StatelessWidget {
  const _EmployeeSidebar({
    required this.selectedIndex,
    required this.onSelect,
    required this.viewModel,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final EmployeeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: EmployeeViewSpacing.avatarRadius,
          backgroundImage: const AssetImage(EmployeeAssets.profileImage),
        ),
        const SizedBox(height: EmployeeViewSpacing.avatarToStatusGap),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: EmployeeViewSpacing.statusPillPaddingHorizontal,
            vertical: EmployeeViewSpacing.statusPillPaddingVertical,
          ),
          decoration: BoxDecoration(
            color: AppColors.backgroundQuinary,
            borderRadius: BorderRadius.circular(EmployeeRadius.sidebarStatusPill),
          ),
          child: Text(
            LocaleKeys.employeeGeneralInfo_Active.tr(),
            style: const TextStyle(
              color: AppColors.textQuaternary,
              fontSize: EmployeeTextSize.statusPill,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: EmployeeViewSpacing.statusToNavGap),
        SizedBox(
          width: EmployeeViewSpacing.navListWidth,
          child: Column(
            children: [
              _NavRow(
                selected: selectedIndex == 0,
                icon: Icons.person_outline,
                label: LocaleKeys.navbar_general.tr(),
                onTap: () => onSelect(0),
              ),
              const Divider(height: EmployeeViewSpacing.dividerHeight, color: AppColors.backgroundSecondary),
              _NavRow(
                selected: selectedIndex == 1,
                icon: Icons.task_outlined,
                label: LocaleKeys.navbar_employment.tr(),
                onTap: () => onSelect(1),
              ),
              const Divider(height: EmployeeViewSpacing.dividerHeight, color: AppColors.backgroundSecondary),
              _NavRow(
                selected: selectedIndex == 2,
                icon: Icons.assignment_outlined,
                label: LocaleKeys.navbar_assignment.tr(),
                onTap: () => onSelect(2),
              ),
              const Divider(height: EmployeeViewSpacing.dividerHeight, color: AppColors.backgroundSecondary),
              _NavRow(
                selected: selectedIndex == 3,
                icon: Icons.inventory_2_outlined,
                label: LocaleKeys.navbar_asset.tr(),
                onTap: () => onSelect(3),
              ),
              const Divider(height: EmployeeViewSpacing.dividerHeight, color: AppColors.backgroundSecondary),
              _NavRow(
                selected: selectedIndex == 4,
                icon: Icons.warning_amber_outlined,
                label: LocaleKeys.navbar_emergency.tr(),
                onTap: () => onSelect(4),
              ),
              const Divider(height: EmployeeViewSpacing.dividerHeight, color: AppColors.backgroundSecondary),
              _NavRow(
                selected: selectedIndex == 5,
                icon: Icons.group_outlined,
                label: LocaleKeys.navbar_dependent.tr(),
                onTap: () => onSelect(5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NavRow extends StatelessWidget {
  const _NavRow({
    required this.selected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final bool selected;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(EmployeeRadius.navRow),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(EmployeeRadius.navRow),
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppDurations.navAnimation,
          padding: const EdgeInsets.symmetric(
            horizontal: EmployeeViewSpacing.navRowPaddingHorizontal,
            vertical: EmployeeViewSpacing.navRowPaddingVertical,
          ),
          decoration: BoxDecoration(
            color: selected ? AppColors.backgroundTertiary : AppColors.transparent,
            borderRadius: BorderRadius.circular(EmployeeRadius.navRow),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: selected ? AppColors.textQuaternary : AppColors.black87,
              ),
              const SizedBox(width: EmployeeViewSpacing.navRowIconTextGap),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: selected ? AppColors.textQuaternary : AppColors.black87,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
