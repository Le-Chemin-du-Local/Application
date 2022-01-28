import 'package:flutter/cupertino.dart';

class Palette {
  static const Color colorScaffold = Color(0xfffafafe);

  static const Color colorRed = Color(0xffff6767);
  static const Color colorRedPale = Color(0xffffa7a7);

  static const Color colorOrange = Color(0xffff8c60);
  static const Color colorOrangePale = Color(0xffffc084);

  static const Color colorWhite = Color(0xffffffff);
  static const Color colorDark = Color(0xff292929);

  static const Color colorPrimary = colorOrange;

  static const Color colorDarkGrey = Color(0xff454545);

  static const LinearGradient gradientPrimary = LinearGradient(
    colors: [
      Color(0xffe60669),
      Color(0xffff8c60)
    ],
    begin: Alignment(-1.0, -1.0),
    end: Alignment(1, 1)
  );
}