import 'package:flutter/material.dart';
import 'package:zau_layer_first/app/theme/colors.dart';

final ThemeData appTheme = _appTheme();

ThemeData _appTheme() {
  final ThemeData base = ThemeData(fontFamily: "Barlow");

  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: AppColor.colorPrimary,
      onPrimary: Colors.white,
      error: AppColor.colorDangerShade,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    textTheme: _appTextTheme(base.textTheme),
    textButtonTheme: _textButtonTheme(base.textButtonTheme),
    elevatedButtonTheme: _elevatedButtonTheme(base.elevatedButtonTheme),
    outlinedButtonTheme: _outlinedButtonTheme(base.outlinedButtonTheme),
  );
}

TextTheme _appTextTheme(TextTheme base) => base.copyWith(
  displayLarge: base.displayLarge?.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w500,
    color: AppColor.textColor,
  ),
  displayMedium: base.displayMedium?.copyWith(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColor.textColor,
  ),
  displaySmall: base.displaySmall?.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColor.textColor,
  ),
  bodyLarge: base.bodyLarge?.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColor.textColor,
  ),
  bodyMedium: base.bodyMedium?.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColor.textColor,
  ),
  bodySmall: base.bodySmall?.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.textColor,
  ),
  titleLarge: base.titleLarge?.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColor.textColor,
  ),
  titleMedium: base.titleMedium?.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColor.textColor,
  ),
  titleSmall: base.titleSmall?.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColor.textColor,
  ),
);

TextButtonThemeData _textButtonTheme(TextButtonThemeData base) =>
    TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: AppColor.colorPrimary,
        foregroundColor: AppColor.colorWhite,
        padding: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );

ElevatedButtonThemeData _elevatedButtonTheme(ElevatedButtonThemeData base) =>
    ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.colorPrimary,
        foregroundColor: AppColor.colorWhite,
        padding: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );

OutlinedButtonThemeData _outlinedButtonTheme(OutlinedButtonThemeData base) =>
    OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColor.colorPrimary,
        padding: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        side: const BorderSide(color: AppColor.colorPrimary),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );

ButtonStyle outlinedButtonTheme = const ButtonStyle(
  foregroundColor: WidgetStatePropertyAll(AppColor.colorPrimary),
  padding: WidgetStatePropertyAll(
    EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
  ),
  shape: WidgetStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
  ),
  side: WidgetStatePropertyAll(BorderSide(color: AppColor.colorPrimary)),
  textStyle: WidgetStatePropertyAll(
    TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
  ),
);

ButtonStyle outOfStockButton = const ButtonStyle(
  backgroundColor: WidgetStatePropertyAll(Color(0xffFFC300)),
  foregroundColor: WidgetStatePropertyAll(Colors.white),
  padding: WidgetStatePropertyAll(
    EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
  ),
  shape: WidgetStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
  ),
  side: WidgetStatePropertyAll(BorderSide(color: Color(0xffFFC300))),
  textStyle: WidgetStatePropertyAll(
    TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
  ),
);

ButtonStyle outlinedButtonDarkTheme = const ButtonStyle(
  foregroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 75, 75, 75)),
  padding: WidgetStatePropertyAll(
    EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
  ),
  shape: WidgetStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
  ),
  side: WidgetStatePropertyAll(
    BorderSide(color: Color.fromARGB(79, 141, 141, 141)),
  ),
  textStyle: WidgetStatePropertyAll(
    TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
  ),
);

const BoxDecoration bottomSheetDecoration = BoxDecoration(
  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.16),
      blurRadius: 6,
      spreadRadius: 0,
      offset: Offset.zero,
    ),
  ],
  color: Colors.white,
);

ButtonStyle outlinedButtonSelectedTheme = const ButtonStyle(
  foregroundColor: WidgetStatePropertyAll(AppColor.colorPrimary),
  padding: WidgetStatePropertyAll(
    EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
  ),
  shape: WidgetStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
  ),
  side: WidgetStatePropertyAll(BorderSide(color: AppColor.colorPrimary)),
  textStyle: WidgetStatePropertyAll(
    TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
  ),
  backgroundColor: WidgetStatePropertyAll(AppColor.colorTertiaryTint),
);
