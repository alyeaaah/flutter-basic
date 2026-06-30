import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log("onError -> ${details.exceptionAsString()}", stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      runApp(await builder());
    },
    (error, stackTrace) {
      debugPrint("Guarded Info -> $error");
    },
  );
}

enum Flavor { dev, staging, hotfix, prod }
