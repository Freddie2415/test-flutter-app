import 'package:flutter/material.dart';

class AppColor {
  static Color bg = const Color(0xFFF0F0F5);
  static Color mainBlue = const Color(0xFF388FF3);
  static Color grey1 = const Color(0xFF8E9297);
  static Color grey2 = const Color(0xFFB8BBBD);
  static Color grey4 = const Color(0xFFEAEDF0);
  static Color greyText = const Color(0xFF676A7D);
}

class ButtonStyles {
  static ButtonStyle primary() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColor.mainBlue,
      foregroundColor: Colors.white,
    );
  }
}
