import 'package:flutter/material.dart';

class AppState extends InheritedWidget {
  const AppState({required this.setMessage, required super.child, super.key});

  final ValueSetter<String> setMessage;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>()!;
  }
}
