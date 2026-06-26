import 'app_link_location_keys.dart';

class AppLink {
  String? location;
  Map<String, String>? parameters;

  AppLink({this.location, this.parameters});

  static AppLink fromLocation(String? location) {
    location = Uri.decodeFull(location ?? '');
    location = location.replaceFirst('/#/', '/');

    final uri = Uri.parse(location);

    final appLink =
        AppLink(location: uri.path, parameters: uri.queryParameters);

    return appLink;
  }

    String toLocation() {
    final loc = location ?? AppLinkLocationKeys.homeView;
    
    if (AppLinkLocationKeys.isProductEditPath(loc)) {
      return loc;
    }

    switch (location) {
      case AppLinkLocationKeys.employeeView:
        return AppLinkLocationKeys.employeeView;      
      case AppLinkLocationKeys.employeeGeneralView:
        return AppLinkLocationKeys.employeeGeneralView;
      case AppLinkLocationKeys.employeeEmploymentView:
        return AppLinkLocationKeys.employeeEmploymentView;
      case AppLinkLocationKeys.employeeAssignmentView:
        return AppLinkLocationKeys.employeeAssignmentView;
      case AppLinkLocationKeys.employeeAssetsView:
        return AppLinkLocationKeys.employeeAssetsView;
      case AppLinkLocationKeys.employeeEmergencyView:
        return AppLinkLocationKeys.employeeEmergencyView;
      case AppLinkLocationKeys.employeeDependentView:
        return AppLinkLocationKeys.employeeDependentView;
      case AppLinkLocationKeys.homeView:
        return AppLinkLocationKeys.homeView;
      case AppLinkLocationKeys.productView:
        return AppLinkLocationKeys.productView;
      case AppLinkLocationKeys.productCreateView:
        return AppLinkLocationKeys.productCreateView;
      case AppLinkLocationKeys.settingsView:
        return AppLinkLocationKeys.settingsView;
      default:
        return AppLinkLocationKeys.homeView;
    }
  }
}