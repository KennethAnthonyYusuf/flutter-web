class AppLinkLocationKeys {
  static const String employeeView = '/employee';
  static const String employeeGeneralView = '/employee/general';
  static const String employeeEmploymentView = '/employee/employment';
  static const String employeeAssignmentView = '/employee/assignment';
  static const String employeeAssetsView = '/employee/assets';
  static const String employeeEmergencyView = '/employee/emergency';
  static const String employeeDependentView = '/employee/dependent';
  static const String homeView = '/home';
  static const String productView = '/product';
  static const String productCreateView = '/product/create';
  static const String settingsView = '/settings';

  static bool isProductEditPath(String? path) =>
      path != null &&
      path.startsWith('/product/') &&
      path.endsWith('/edit') &&
      path.split('/').length == 4;
}