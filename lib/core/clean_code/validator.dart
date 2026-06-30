import 'package:flutter/services.dart';

class ValidatorHelper {
  static bool hasMatch(String value, String pattern) {
    return (value == "") ? false : RegExp(pattern).hasMatch(value);
  }

  static bool isEmail(String value) => hasMatch(value,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  // min 10 digits
  static bool isPhoneNumber(String value) => hasMatch(value, r'[0-9]{10}$');
}

class ValidatorRange extends TextInputFormatter {
  final num minVal;
  final num maxVal;
  ValidatorRange({required this.maxVal, this.minVal = 1});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) < minVal) {
      return oldValue;
    }

    return num.parse(newValue.text) > maxVal ? oldValue : newValue;
  }
}
