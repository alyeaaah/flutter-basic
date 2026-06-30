import 'package:get_it/get_it.dart';

import '../app/config/config.dart';

final serviceLocator = GetIt.instance;
Future<void> setUpServiceLocator(AppConfig appConfig) async {
  serviceLocator.registerSingleton(appConfig);
}
