import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;
    blockSizeHorizontal = (screenWidth! / 100);
    blockSizeVertical = (screenHeight! / 100);

    _safeAreaHorizontal = _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical = _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;
  }
}

Color blue = Color.fromARGB(255, 0, 17, 72);
Map<int, Color> color = {
  50: blue.withOpacity(0.1),
  100: blue.withOpacity(0.2),
  200: blue.withOpacity(0.3),
  300: blue.withOpacity(0.4),
  400: blue.withOpacity(0.5),
  500: blue.withOpacity(0.6),
  600: blue.withOpacity(0.7),
  700: blue.withOpacity(0.8),
  800: blue.withOpacity(0.9),
  900: blue,
};

MaterialColor colorCustom = MaterialColor(0xff000c36, color);

BoxShadow containerShadow = BoxShadow(
  color: Color.fromARGB(255, 156, 156, 156).withOpacity(0.5),
  spreadRadius: 1,
  blurRadius: 3,
  offset: const Offset(0, 3),
);
