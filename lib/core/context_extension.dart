import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ContextExt on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension NumExt on num {
  String get cur {
    final currencyFormatter = NumberFormat('#,##0', 'ID');
    return currencyFormatter.format(this);
  }
}

extension StringExtension on String {
  String toTitleCase() {
    if (isEmpty) {
      return this;
    }
    var result = '';
    var words = split(' ');
    for (var word in words) {
      if (word.isEmpty) {
        continue;
      }
      var firstChar = word[0].toUpperCase();
      var restOfWord = word.substring(1);
      result += '$firstChar$restOfWord ';
    }
    return result.trim();
  }

  String toCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String maskPhone() {
    String text = "";
    for (var i = 0; i < length; i++) {
      if (i < 3 || (i > length - 3)) {
        text = "$text${this[i]}";
      } else {
        text = "$text*";
      }
    }
    return text;
  }
}
