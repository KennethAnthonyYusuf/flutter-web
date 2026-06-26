import 'app_settings.dart';
import '../../enums/environment.dart';

class AppSettingsTest extends AppSettings {
  @override
  Environment get environment => Environment.test;

  @override
  String get appName => "Team - Test";

  @override
  String get apiBaseEndpoint => "https://kamoro-team-dev-c3c3a5fwdxebg3ge.eastasia-01.azurewebsites.net/api";

  @override
  String get productApiEndpoint => "https://kamoro-team-dev-c3c3a5fwdxebg3ge.eastasia-01.azurewebsites.net/api";
}