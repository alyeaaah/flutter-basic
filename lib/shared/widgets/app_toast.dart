import 'package:flutter/material.dart';
import 'package:zau_layer_first/app/theme/colors.dart';
import 'package:zau_layer_first/core/context_extension.dart';

class AppToast extends StatelessWidget {
  final String message;
  final bool isSuccess;

  const AppToast({required this.message, this.isSuccess = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSuccess ? AppColor.colorSuccess : AppColor.colorDangerShade,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                message,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
