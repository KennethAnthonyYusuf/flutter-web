import '../../enums/environment.dart';

abstract class AppSettings {
  Environment get environment => Environment.prod;
  String get appName => "Team";
  String get apiBaseEndpoint => "https://kamoro-team-dev-c3c3a5fwdxebg3ge.eastasia-01.azurewebsites.net/api";
  String get productApiEndpoint => "https://kamoro-team-dev-c3c3a5fwdxebg3ge.eastasia-01.azurewebsites.net/api";
}