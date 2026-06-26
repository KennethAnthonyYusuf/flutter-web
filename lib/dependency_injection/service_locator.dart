import 'package:get_it/get_it.dart';
import 'package:sembast/utils/database_utils.dart';
import '../models/settings/settings.dart';
import '../providers/provider.dart';
import '../repositories/repositories.dart';
import '../localizations/localizations.dart';

final GetIt serviceLocator = GetIt.instance;

Future setupServiceLocator(AppSettings settings, Database sembastDatabase) async {
  serviceLocator.registerSingleton<AppSettings>(settings);

  final appStateManager = AppStateManager();
  await appStateManager.initializeApp();

  serviceLocator.registerSingleton<AppStateManager>(appStateManager);
  
  serviceLocator.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(base: settings.apiBaseEndpoint),
  );
  serviceLocator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(base: settings.productApiEndpoint), 
  );
  GetIt.I.registerLazySingleton<ProductStateManager>(() => ProductStateManager());

  final localizationService = LocalizationServiceImpl();
  await localizationService.initialize();

  serviceLocator.registerSingleton<LocalizationService>(
    localizationService,
  );

  serviceLocator.registerSingleton<ProductLocalStorageRepository>(
    ProductLocalStorageRepositoryImpl(db: sembastDatabase),
  );


}
