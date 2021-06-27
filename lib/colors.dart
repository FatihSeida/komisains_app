import 'package:flutter/material.dart';

class AppColorsTheme {
  Color primarySwatch;
  Color titleBarGradientStartColor;
  Color titleBarGradientEndColor;
  Color textColor;
  Color secondaryGradientColor;

  AppColorsTheme(
      {required this.primarySwatch,
      required this.titleBarGradientStartColor,
      required this.titleBarGradientEndColor,
      required this.textColor,
      required this.secondaryGradientColor});

  static final AppColorsTheme myTheme = new AppColorsTheme(
      primarySwatch: const Color(0xff3BBC86),
      titleBarGradientStartColor: const Color(0xff3BBC86),
      titleBarGradientEndColor: const Color(0xff3BBC86),
      textColor: Colors.black,
      secondaryGradientColor: const Color(0xffB5EFD7));
}
