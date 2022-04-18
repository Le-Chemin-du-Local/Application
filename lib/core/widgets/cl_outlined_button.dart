import 'package:flutter/material.dart';

class ClOutlinedButton extends StatelessWidget {
  const ClOutlinedButton({
    Key? key,
    this.borderRadius,
    required this.child,
    required this.onPressed,
    required this.gradient,
  }) : super(key: key);

  final BorderRadiusGeometry? borderRadius;
  final Widget child;
  final Function()? onPressed;

  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(64);
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 38),
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
      )
    );
  }
}