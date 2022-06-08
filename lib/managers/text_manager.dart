import 'package:flutter/material.dart';
import 'package:techhub/managers/color_manager.dart';

TextStyle _getTextTheme(
  Color? color,
  double? size,
  FontWeight? fontWeight, {
  double letterSpacing = 1,
}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontFamily: 'OpenSans',
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
  );
}

TextStyle homeCardTextStyle() {
  return _getTextTheme(ColorManager.white, 18, FontWeight.w700);
}

TextStyle frontInfoTextStyle() {
  return _getTextTheme(ColorManager.white, 40, FontWeight.bold,
      letterSpacing: 3.0);
}

TextStyle accountScreenTextStyle() {
  return _getTextTheme(ColorManager.white.withGreen(230), 13, FontWeight.w800);
}
