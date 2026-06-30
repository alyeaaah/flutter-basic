import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:zau_layer_first/app/environments/app_environments.dart';

class Config {
  static AppConfig get app => GetIt.instance.get<AppConfig>();
  static DateFormat get deliveryDateFormat => DateFormat("yyyy-MM-dd", 'id_ID');
  static DateFormat get dateFormat => DateFormat("dd MMMM yyyy", 'id_ID');
}

class AppConfig {
  final Flavor flavor;
  String baseUrl = "";
  bool isCovered = false;

  AppConfig({
    required this.flavor,
    required this.baseUrl,
    required this.isCovered,
  });
}
