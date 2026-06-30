import 'package:flutter/material.dart';
import 'package:zau_layer_first/app/theme/colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    required this.buttonTitle,
    required this.onPressed,
    this.isLoading = false,
    this.bgColor = Colors.white,
    this.textColor = AppColor.colorPrimary,
    this.borderColor = AppColor.colorPrimary,
    this.fontSize = 14,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    this.minimumWidth = 0,
    this.minimumHeight = 0,
    this.borderRadius = 6,
    this.isBlock = false,
    this.fontWeight = FontWeight.bold,
    super.key,
  });
  final bool isLoading;
  final String buttonTitle;
  final Function onPressed;
  final Color bgColor;
  final Color textColor;
  final Color borderColor;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final double minimumWidth;
  final double minimumHeight;
  final double borderRadius;
  final bool isBlock;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (!isLoading) {
          onPressed();
        }
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: bgColor,
        side: BorderSide(
          color: borderColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
        minimumSize: Size(
          !isBlock ? minimumWidth : double.infinity,
          minimumHeight,
        ),
      ),
      child: !isLoading
          ? Text(
              buttonTitle.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: fontWeight,
                fontSize: fontSize,
                fontFamily: "poppins",
              ),
            )
          : SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(color: textColor),
            ),
    );
  }
}
