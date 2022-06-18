import 'package:flutter/material.dart';

class ScreenHelper {
  ScreenHelper._();

  static final ScreenHelper instance = ScreenHelper._();

  double horizontalPadding = 18;

  static const double breakpointPC = 768;
  static const double breakpointTablet = 481;
  static const double maxContainerWidth = 900;
  
  void setValues(double width) {
    if (width > breakpointPC) {
      horizontalPadding = 32;
    }
    else if (width > breakpointTablet) {
      horizontalPadding = 24;
    }
  }
}