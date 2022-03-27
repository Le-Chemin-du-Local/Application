import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class Palette {
  static const Color colorScaffold = Color(0xfffafafe);

  static const Color colorRed = Color(0xffff6767);
  static const Color colorRedPale = Color(0xffffa7a7);

  static const Color colorOrange = Color(0xffff8c60);
  static const Color colorOrangePale = Color(0xffffc084);
  static const Color colorYellow = Color(0xffffd9a0);

  static const Color colorWhite = Color(0xffffffff);
  static const Color colorDark = Color(0xff292929);

  static const Color colorPrimary = colorOrange;

  static const Color colorDarkGrey = Color(0xff454545);
  
  static const Color colorInfo = Color(0xff36a2b1);
  static const Color colorWarning = Color(0xffffc21f);
  static const Color colorSuccess = Color(0xff17ba63);
  static const Color colorError = Color(0xffe01c1c);

  static const Color colorBackgroundSuccess = Color(0xffd4edda);
  static const Color colorBorderSuccess = Color(0xffc2e5ca);
  static const Color colorTextSuccess = Color(0xff155724);

  static const Color colorBackgroundError = Color(0xfff8d7da);
  static const Color colorBorderError = Color(0xfff4c2c7);
  static const Color colorTextError = Color(0xff721c24);

  static const Color colorBackgroundInfo = Color(0xffd1ecf1);
  static const Color colorBorderInfo = Color(0xffbde4eb);
  static const Color colorTextInfo = Color(0xff0c5460);

  static const Color colorCommandReady = Color(0xffd9f8d9);

  static const LinearGradient gradientPrimary = LinearGradient(
    colors: [
      Color(0xffe60669),
      Color(0xffff8c60)
    ],
    stops: [
      0.0,
      0.61,
    ],
    begin: Alignment(-1.0, 0.0),
    end: Alignment(1.0, 0.0),
    transform: GradientRotation(math.pi / 3.7)
  );

  static const LinearGradient gradientBlackCover = LinearGradient(
    colors: [
      Color(0xffffffff),
      Color(0x00ffffff),
      Color(0x99000000)
    ],
    stops: [
      0,
      0.01,
      0.59
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter
  );

  static LinearGradient colorToGradient(Color color) {
    return LinearGradient(
      colors: [
        color,
        color
      ],
      stops: const [
        0,
        1
      ]
    );
  }
}