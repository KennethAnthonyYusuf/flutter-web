import '../../enums/environment.dart';
import 'app_settings.dart';

class AppSettingsDev extends AppSettings {
  @override
  Environment get environment => Environment.dev;

  @override
  String get appName => "Team - Dev";

  @override
  String get apiBaseEndpoint => "https://kamoro-team-dev-c3c3a5fwdxebg3ge.eastasia-01.azurewebsites.net/api";

  @override
  String get productApiEndpoint => "https://kamoro-team-dev-c3c3a5fwdxebg3ge.eastasia-01.azurewebsites.net/api";
}
