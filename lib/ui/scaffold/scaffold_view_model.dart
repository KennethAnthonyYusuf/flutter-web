import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import '../../providers/app_state_manager.dart';

class ScaffoldViewModel extends BaseViewModel {
  final AppStateManager _appStateManager =
      GetIt.instance.get<AppStateManager>();

  int _currentNavigationIndex = 0;
  int get currentNavIndex => _currentNavigationIndex;

  int _setSettingsIndex = 0;
  int get setSettingsIndex => _setSettingsIndex;

  void initialize() async {
    _appStateManager.addListener(_appStateUpdated);
    _appStateUpdated();
  }

  void _appStateUpdated() {
    if (_appStateManager.homeView) {
      _currentNavigationIndex = 0;
      _setSettingsIndex = 0;
    } else if (_appStateManager.employeeView) {
      _currentNavigationIndex = 1;
      _setSettingsIndex = 0;
    } else if (_appStateManager.productView) {
      _currentNavigationIndex = 2;
      _setSettingsIndex = 0;
    }
    if (_appStateManager.settingsView) {
      _setSettingsIndex = 1;
    }
    notifyListeners();
  }
 
  @override
  void dispose() {
    _appStateManager.removeListener(_appStateUpdated);
    super.dispose();
  }

  Future onNavigationItemClicked(int index) async {
    _currentNavigationIndex = index;
    switch (index) {
      case 0:
        _appStateManager.setHome();
        break;
      case 1:
        _appStateManager.setEmployee();
        break;
      case 2:
        _appStateManager.setProduct();
        break;
    }
  }

  void onSettingsTabChanged() {
    _appStateManager.setSettings();
  }
}
