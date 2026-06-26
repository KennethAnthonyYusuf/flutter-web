import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../routing/app_link_location_keys.dart';

enum ProductDetailMode { create, edit }

class AppStateManager extends ChangeNotifier {
  // bool _loggedIn = false;
  Map<String, String>? _queryParameters;

  // bool get isLoggedIn => _loggedIn;
  Map<String, String>? get queryParameters => _queryParameters;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  late dynamic _currentScreen;
  String get currentScreen => _currentScreen;

  Future<void> initializeApp() async {
    _currentScreen = await _storage.read(key: 'screen_preference') ?? AppLinkLocationKeys.homeView;
  }

  ProductDetailMode? _productDetailMode;
  String? _productDetailId;

  ProductDetailMode? get productDetailMode => _productDetailMode;
  String? get productDetailId => _productDetailId;

  bool get employeeView => currentScreen == AppLinkLocationKeys.employeeView;
  bool get employeeGeneralView => currentScreen == AppLinkLocationKeys.employeeGeneralView;
  bool get employeeEmploymentView => currentScreen == AppLinkLocationKeys.employeeEmploymentView;
  bool get employeeAssignmentView => currentScreen == AppLinkLocationKeys.employeeAssignmentView;
  bool get employeeAssetsView => currentScreen == AppLinkLocationKeys.employeeAssetsView;
  bool get employeeEmergencyView => currentScreen == AppLinkLocationKeys.employeeEmergencyView;
  bool get employeeDependentView => currentScreen == AppLinkLocationKeys.employeeDependentView;
  bool get homeView => currentScreen == AppLinkLocationKeys.homeView;
  bool get productView => currentScreen == AppLinkLocationKeys.productView;
  bool get productCreateView => currentScreen == AppLinkLocationKeys.productCreateView;
  bool get productEditView => AppLinkLocationKeys.isProductEditPath(currentScreen);
  bool get settingsView => currentScreen == AppLinkLocationKeys.settingsView;

  void setQueryParameters(Map<String, String> queryParameters) {
    _queryParameters = queryParameters;
  }

  void setProduct() {
    _currentScreen = AppLinkLocationKeys.productView;
    _productDetailMode = null;
    _productDetailId = null;
    notifyListeners();
  }

  Future<void> setSettings() async{
    await _storage.write(key: 'screen_preference', value: _currentScreen);
    _currentScreen = AppLinkLocationKeys.settingsView;
    notifyListeners();
  }

  void setPrevScreen() {
    notifyListeners();
  }

  Future<void> setCancelSettings() async {
    _currentScreen = await _storage.read(key: 'screen_preference') ?? AppLinkLocationKeys.homeView;
    notifyListeners();
  }

  void setProductCreate() {
    _currentScreen = AppLinkLocationKeys.productCreateView;
    _productDetailMode = ProductDetailMode.create;
    _productDetailId = null;
    notifyListeners();
  }

  void setProductEdit(String id) {
    _currentScreen = '/product/$id/edit';
    _productDetailMode = ProductDetailMode.edit;
    _productDetailId = id;
    notifyListeners();
  }

  void setHome() {
    _currentScreen = AppLinkLocationKeys.homeView;
    notifyListeners();
  }

  void setEmployee() {
    _currentScreen = AppLinkLocationKeys.employeeView;
    notifyListeners();
  }

  void setEmployeeGeneral() {
    _currentScreen = AppLinkLocationKeys.employeeGeneralView;
    notifyListeners();
  }

  void setEmployeeEmployment() {
    _currentScreen = AppLinkLocationKeys.employeeEmploymentView;
    notifyListeners();
  }

  void setEmployeeAssignment() {
    _currentScreen = AppLinkLocationKeys.employeeAssignmentView;
    notifyListeners();
  }

  void setEmployeeAssets() {
    _currentScreen = AppLinkLocationKeys.employeeAssetsView;
    notifyListeners();
  }

  void setEmployeeEmergency() {
    _currentScreen = AppLinkLocationKeys.employeeEmergencyView;
    notifyListeners();
  }

  void setEmployeeDependent() {
    _currentScreen = AppLinkLocationKeys.employeeDependentView;
    notifyListeners();
  }

}