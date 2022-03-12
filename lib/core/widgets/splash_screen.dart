import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: Palette.gradientPrimary
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 150),
          child: Image.asset("assets/images/logo_white.png")
        ),
      ),
    );
  }
}