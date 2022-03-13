import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class ClFloatingButton extends StatelessWidget {
  const ClFloatingButton({
    Key? key,
    required this.onPressed,
    required this.icon
  }) : super(key: key);

  final Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FloatingActionButton(
      onPressed: onPressed,
      child: Container(
        width: size.width * 0.17,
        height: size.width * 0.17,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: Palette.gradientPrimary
        ),
        child: Icon(
          icon,
          color: Palette.colorWhite,
          size: 32,
        ),
      ),
    );
  }
}