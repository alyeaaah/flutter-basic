import 'package:flutter/foundation.dart';
import 'dart:developer';
import 'package:flutter/services.dart';

void appLog(
  String msg, {
  String tag = "",
  Object? error,
  StackTrace? stackTrace,
}) {
  if (kDebugMode) {
    if (stackTrace == null) {
      log("$tag $msg", name: "appLog");
    } else {
      log("appLog ==> $tag $msg", error: error, stackTrace: stackTrace);
    }
  } else {
    /// log release don't push uncomment to git
    // print("$tag $msg");
  }
}

FilteringTextInputFormatter filterEmoji = FilteringTextInputFormatter.deny(
  RegExp(
    r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
  ),
);
