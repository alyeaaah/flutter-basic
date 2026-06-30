import 'dart:io';

import 'package:zau_layer_first/app/config/config.dart';
import 'package:zau_layer_first/app/environments/app_environments.dart';
import 'package:zau_layer_first/app/main_app.dart';
import 'package:zau_layer_first/core/client_request.dart';
import 'package:zau_layer_first/core/service_locator.dart';
import 'package:zau_layer_first/shared/utils/constants.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  try {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await initializeDateFormatting('id_ID', 'id');
    HttpOverrides.global = MyHttpOverrides();

    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox(Constants.appname),
      Hive.openBox(Constants.authStorageKey),
    ]);
    await setUpServiceLocator(
      AppConfig(
        flavor: Flavor.dev,
        baseUrl: "https://petstore3.swagger.io/api/v3/",
        isCovered: false,
      ),
    );

    bootstrap(() => const MainApp());
  } catch (error, stackTrace) {
    // This will catch the exact error and print it to your debug console
    print("CRITICAL STARTUP ERROR: $error");
    print(stackTrace);
  }
}
