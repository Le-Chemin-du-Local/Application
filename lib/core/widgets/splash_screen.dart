import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenHelper.instance.horizontalPadding),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 294),
            child: Image.asset("assets/images/logo_white.png")
          ),
        ),
      ),
    );
  }
}