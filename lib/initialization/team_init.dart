import 'package:flutter_application_2/dependency_injection/service_locator.dart';
import 'package:flutter_application_2/repositories/localStorage/sembast_database.dart';
import 'package:flutter_application_2/models/settings/settings.dart';
import 'package:sembast/sembast.dart';


class TeamInit {
  static Future launchInit() async {
    const String environment = String.fromEnvironment(
      "ENVIRONMENT",
      defaultValue: "DEV",
    );

    late AppSettings settings;
    switch (environment) {
      case "DEV":
        settings = AppSettingsDev();
        break;
      case "TEST":
        settings = AppSettingsTest();
        break;
      default:
        settings = AppSettingsProd();
    }

    Database sembaseDatabase =
        await SembastDatabase("workspace.db").initialize();

    await setupServiceLocator(settings, sembaseDatabase);

  }
}