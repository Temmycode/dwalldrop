import 'package:flutter/cupertino.dart';

extension ToColor on String {
  Color toColor() {
    String hexColor = this;
    if (startsWith('#')) {
      hexColor = substring(1);
    }

    int hexValue = int.tryParse(hexColor, radix: 16)!;

    if (hexColor.length == 6) {
      hexValue |= 0xFF000000;
    }

    return Color(hexValue);
  }
}
