import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ClTheme {
  static ThemeData theme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: Palette.colorPrimary, // #FF5858 (RED)
        onPrimary: Palette.colorWhite,
        primaryContainer: Palette.colorSecondaryLight, // #FFC9C9 (RED LIGHT)
        onPrimaryContainer: Palette.colorWhite,

        secondary: Palette.colorSecondary, // #FF8C60 (ORANGE)
        onSecondary: Palette.colorWhite,
        secondaryContainer: Palette.colorSecondaryLight, // #FFC9B2 (ORANGE LIGHT)
        onSecondaryContainer: Palette.colorWhite,

        error: Palette.colorError, // #E01C1C
        onError: Palette.colorWhite,
        errorContainer: Palette.colorBackgroundError, // #F8D7DA
        onErrorContainer: Palette.colorTextError, // #721C24

        surface: Palette.colorWhite,
        onSurface: Palette.colorDark,
        background: Palette.colorScaffold,
        onBackground: Palette.colorDark,

        outline: Palette.colorLightGrey,
      ),

      brightness: Brightness.light,

      appBarTheme: const AppBarTheme(
        centerTitle: false,
        backgroundColor: Palette.colorScaffold,
        elevation: 0,
        foregroundColor: Palette.colorDark,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(fontSize: 24, color: Palette.colorDark), 
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          primary: Palette.colorPrimary,
          onPrimary: Palette.colorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          )
        )
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          primary: Palette.colorPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: const BorderSide(
            color: Palette.colorPrimary,
          )
        )
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        extendedPadding: EdgeInsets.zero,
        backgroundColor: Palette.colorSecondary,
        shape: CircleBorder()
      ),

      textTheme: GoogleFonts.rubikTextTheme().copyWith(
        // Body
        bodyLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Palette.colorDark),
        bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Palette.colorDark),
        bodySmall: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Palette.colorDark),

        // Heading
        headlineLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: Palette.colorDark),
        headlineMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Palette.colorDark),
        headlineSmall: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Palette.colorDark),

        // Titiel
        titleMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Palette.colorDark)
      ),

      visualDensity: VisualDensity.standard
    );
  }

  static AppBarTheme themeSecondAppBar(BuildContext context) {
    return const AppBarTheme(
      centerTitle: false,
      backgroundColor: Palette.colorScaffold,
      elevation: 0,
      foregroundColor: Palette.colorDark,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(fontSize: 24, color: Palette.colorDark), 
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