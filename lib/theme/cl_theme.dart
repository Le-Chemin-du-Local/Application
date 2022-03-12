import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClTheme {
  static ThemeData theme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: colorSwatch(Palette.colorPrimary.value),
        accentColor: Palette.colorPrimary,
        backgroundColor: Palette.colorScaffold,
        cardColor: Palette.colorScaffold
      ),

      scaffoldBackgroundColor: Palette.colorScaffold,
      primaryColor: Palette.colorPrimary,

      appBarTheme: const AppBarTheme(
        backgroundColor: Palette.colorScaffold,
        elevation: 0,
        foregroundColor: Palette.colorDark,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      textTheme: const TextTheme(
        headline2: TextStyle(fontSize: 24, color: Palette.colorDark),
        bodyText1: TextStyle(fontSize: 12, color: Palette.colorDark),
        bodyText2: TextStyle(fontSize: 18, color: Palette.colorDark)
      ),

      visualDensity: VisualDensity.standard
    );
  }

  static MaterialColor colorSwatch(int value) {
    final color50 = Color(value).withOpacity(0.1);
    final color100 = Color(value).withOpacity(0.2);
    final color200 = Color(value).withOpacity(0.3);
    final color300 = Color(value).withOpacity(0.4);
    final color400 = Color(value).withOpacity(0.5);
    final color500 = Color(value).withOpacity(0.6);
    final color600 = Color(value).withOpacity(0.7);
    final color700 = Color(value).withOpacity(0.8);
    final color800 = Color(value).withOpacity(0.8);
    final color900 = Color(value).withOpacity(1);

    return MaterialColor(value, <int, Color>{
      50:color50,
      100:color100,
      200:color200,
      300:color300,
      400:color400,
      500:color500,
      600:color600,
      700:color700,
      800:color800,
      900:color900,
    });
  }
}