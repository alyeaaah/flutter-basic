import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class FirebaseRequest {
  final int baseUrlIndex;
  final Dio dio = Dio();

  List<String> baseUrlList = const [
    "https://superagent.firebaseio.com",
    "https://firebasestorage.googleapis.com"
  ];

  FirebaseRequest({
    this.baseUrlIndex = 0,
  }) {
    dioInterceptors();
  }

  void dioInterceptors() {
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 33),
      baseUrl: baseUrlList[baseUrlIndex],
    );
    dio.interceptors.add(
      LogInterceptor(
          requestHeader: kDebugMode,
          requestBody: kDebugMode,
          responseBody: kDebugMode,
          logPrint: (object) {
            log(object.toString());
          }),
    );
  }
}
