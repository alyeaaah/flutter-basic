import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MainWidget extends StatelessWidget {
  final Widget child;
  const MainWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return child;
        },
      ),
    );
  }
}
