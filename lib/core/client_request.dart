import 'dart:developer';
import 'dart:io';

import 'package:zau_layer_first/modules/feature/account/login/login_screen.dart';
import 'package:zau_layer_first/shared/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:zau_layer_first/app/config/config.dart';
import 'package:zau_layer_first/app/theme/colors.dart';
import 'package:zau_layer_first/app/routes/app_router.dart';

class ClientRequest {
  final Dio dio = Dio();
  String? authToken;
  ClientRequest({this.authToken}) {
    dioInterceptors(authToken ?? "");
  }

  void dioInterceptors(String authToken) {
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 33),
      baseUrl: Config.app.baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'authorization': "Bearer $authToken",
      },
    );
    dio
      ..interceptors.add(
        LogInterceptor(
          requestHeader: kDebugMode,
          requestBody: kDebugMode,
          responseBody: kDebugMode,
          logPrint: (object) {
            log(object.toString());
          },
        ),
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onError: (DioException e, handler) {
            if (e.response?.statusCode == 403) {
              BuildContext? currentContext =
                  AppRouter.router.routerDelegate.navigatorKey.currentContext;
              if (currentContext != null) {
                final box = Hive.box(Constants.authStorageKey);
                String token = box.get('token', defaultValue: "") ?? "";
                if (token.isNotEmpty) {
                  showSimpleNotification(
                    const Text(
                      "Session expired, please relogin.",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    context: currentContext,
                    elevation: 10,
                    autoDismiss: true,
                    slideDismissDirection: DismissDirection.up,
                    background: AppColor.colorDangerShade,
                    duration: const Duration(seconds: 3),
                  );
                  //logout user and go to login page
                  final box = Hive.box(Constants.authStorageKey);
                  box.clear().then(
                    (value) => AppRouter.router.go(LoginScreen.routeName),
                  );
                }
              }
            }
            return handler.next(e);
          },
        ),
      );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
