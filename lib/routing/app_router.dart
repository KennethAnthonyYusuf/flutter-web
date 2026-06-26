
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../providers/app_state_manager.dart';

import '../ui/ui.dart';
import 'app_link.dart';
import 'app_link_location_keys.dart';

class AppRouter extends RouterDelegate<AppLink>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager = GetIt.instance<AppStateManager>();
 
  AppRouter() : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Page>[

      if (appStateManager.productCreateView || appStateManager.productEditView)
        ProductDetailView.page(
          id: appStateManager.productDetailId,
        )
      else 
        ScaffoldView.page(),
      
    ];

    return Navigator(
      key: navigatorKey,
      onDidRemovePage: (Page<dynamic> page) {

        if (appStateManager.productCreateView || appStateManager.productEditView) {
          appStateManager.setProduct(); 
        }

      },
      pages: pages,
    );
  }

  @override
  AppLink get currentConfiguration => getCurrentPath();

  AppLink getCurrentPath() {
    if (appStateManager.employeeView) {
      return AppLink(location: AppLinkLocationKeys.employeeView);
    } else if (appStateManager.employeeGeneralView) {
      return AppLink(location: AppLinkLocationKeys.employeeGeneralView);
    } else if (appStateManager.employeeEmploymentView) {
      return AppLink(location: AppLinkLocationKeys.employeeEmploymentView);
    } else if (appStateManager.employeeAssignmentView) {
      return AppLink(location: AppLinkLocationKeys.employeeAssignmentView);
    } else if (appStateManager.employeeAssetsView) {
      return AppLink(location: AppLinkLocationKeys.employeeAssetsView);
    } else if (appStateManager.employeeEmergencyView) {
      return AppLink(location: AppLinkLocationKeys.employeeEmergencyView);
    } else if (appStateManager.employeeDependentView) {
      return AppLink(location: AppLinkLocationKeys.employeeDependentView);
    } else if (appStateManager.homeView) {
      return AppLink(location: AppLinkLocationKeys.homeView);
    } else if (appStateManager.productView) {
      return AppLink(location: AppLinkLocationKeys.productView);
    } else if (appStateManager.productCreateView) {
      return AppLink(location: AppLinkLocationKeys.productCreateView);
    } else if (appStateManager.productEditView) {
      return AppLink(location: appStateManager.currentScreen);
    } else if (appStateManager.settingsView) {
      return AppLink(location: AppLinkLocationKeys.settingsView);
    } else {
      return AppLink(location: AppLinkLocationKeys.homeView);
    }
  }

  @override
  Future<void> setNewRoutePath(AppLink newLink) async {
    if (newLink.parameters != null) {
      appStateManager.setQueryParameters(newLink.parameters!);
    }

    final loc = newLink.location?.toLowerCase() ?? '';

    if (loc == AppLinkLocationKeys.productCreateView) {
      appStateManager.setProductCreate();
      return;
    }

    if (AppLinkLocationKeys.isProductEditPath(loc)) {
      final parts = loc.split('/');
      final id = parts[2];
      appStateManager.setProductEdit(id);
      return;
    }

    switch (newLink.location?.toLowerCase()) {
      case AppLinkLocationKeys.employeeView:
        appStateManager.setEmployee();
        break;
      case AppLinkLocationKeys.employeeGeneralView:
        appStateManager.setEmployee();   
        appStateManager.setEmployeeGeneral();
        break;
      case AppLinkLocationKeys.employeeEmploymentView:
        appStateManager.setEmployee();   
        appStateManager.setEmployeeEmployment();
        break;
      case AppLinkLocationKeys.employeeAssignmentView:
        appStateManager.setEmployee();
        appStateManager.setEmployeeAssignment();
        break;
      case AppLinkLocationKeys.employeeAssetsView:
        appStateManager.setEmployee();
        appStateManager.setEmployeeAssets();
        break;
      case AppLinkLocationKeys.employeeEmergencyView:
        appStateManager.setEmployee();
        appStateManager.setEmployeeEmergency();
        break;
      case AppLinkLocationKeys.employeeDependentView:
        appStateManager.setEmployee();
        appStateManager.setEmployeeDependent();
        break;
      case AppLinkLocationKeys.homeView:
        appStateManager.setHome();
        break;
      case AppLinkLocationKeys.productView:
        appStateManager.setProduct();
        break;
      case AppLinkLocationKeys.settingsView:
        appStateManager.setPrevScreen();
        appStateManager.setSettings();
      default:
        appStateManager.setHome();
        break;
    }
  }

}