import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

extension MyStringExtension on String? {
  /// Used for number formatting.
  /// Adding comma, every 3 digits.
  String get withNumberSeparator {
    if (this == null) {
      return '';
    }
    final formattedString = this!.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match.group(1)},',
    );
    return formattedString;
  }
}

extension MyMapExtension on dynamic {
  /// Used to print json map to be more readable in logs.
  String get prettyPrint {
    if (this == null) return '';
    try {
      var encoder = const JsonEncoder.withIndent('     ');
      return encoder.convert(this);
    } catch (e) {
      Get.log(e.toString());
      return '';
    }
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final String symbol;

  ThousandsSeparatorInputFormatter({this.symbol = ','});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final formatted = digitsOnly.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m.group(1)}$symbol',
    );
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
