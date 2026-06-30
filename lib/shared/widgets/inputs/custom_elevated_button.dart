import 'package:flutter/material.dart';
import 'package:zau_layer_first/app/theme/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.buttonTitle,
    required this.onPressed,
    this.isLoading = false,
    this.btnColor = AppColor.colorPrimary,
    this.textColor = AppColor.colorDark,
    this.fontSize = 14,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    this.minimumWidth = 0,
    this.minimumHeight = 0,
    this.borderRadius = 6,
    this.isBlock = false,
    super.key,
  });
  final bool isLoading;
  final String buttonTitle;
  final dynamic onPressed;
  final Color btnColor;
  final Color textColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final double minimumWidth;
  final double minimumHeight;
  final double borderRadius;
  final bool isBlock;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (!isLoading) {
          onPressed();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
        minimumSize: Size(
          !isBlock ? minimumWidth : double.infinity,
          minimumHeight,
        ),
        elevation: 0,
      ),
      child: (isLoading)
          ? Center(
              child: SizedBox(
                height: fontSize,
                width: fontSize,
                child: CircularProgressIndicator(color: textColor),
              ),
            )
          : Text(
              buttonTitle.toString(),
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
    );
  }
}
