import 'dart:async';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'initialization/team_init.dart';
import 'providers/provider.dart';
import 'routing/routing.dart';
import 'localizations/localizations.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();
      await TeamInit.launchInit();

      var localizationService = GetIt.instance<LocalizationService>();

      runApp(
        EasyLocalization(
          supportedLocales: localizationService.supportedLocales,
          path: 'assets/localization',
          startLocale: localizationService.locale,
          fallbackLocale: localizationService.defaultLocale,
          assetLoader: const CodegenLoader(),
          saveLocale: false,
          child: const MyTeam()
        ),
      );
    },
    (Object error, StackTrace stack) {
      debugPrint("ERROR: ${error.toString()}");
      debugPrint("STACK: ${stack.toString()}");
    },
  );
}

class MyTeam extends StatefulWidget {
  const MyTeam({super.key});

  @override
  State<MyTeam> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {
  final key = UniqueKey();
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final routeParser = AppRouteParser();
  final appRouter = AppRouter();
  final appStateManager = GetIt.instance<AppStateManager>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      key: key,
      providers: [ChangeNotifierProvider(create: (context) => appStateManager)],
      child: MaterialApp.router(
        scaffoldMessengerKey: scaffoldMessengerKey,
        title: 'My Team',
        backButtonDispatcher: RootBackButtonDispatcher(),
        routeInformationParser: routeParser,
        routerDelegate: appRouter,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}