import 'package:flutter/material.dart';

import 'app_link.dart';

class AppRouteParser extends RouteInformationParser<AppLink> {
  @override
  Future<AppLink> parseRouteInformation(RouteInformation routeInformation) async {
    final link = AppLink.fromLocation(routeInformation.uri.toString());
    return link;
  }

  @override
  RouteInformation restoreRouteInformation(AppLink configuration) {
    final location = configuration.toLocation();
    return RouteInformation(uri: Uri.parse(location));
  }
}