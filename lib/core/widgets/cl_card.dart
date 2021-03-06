import 'package:flutter/material.dart';

class ClCard extends StatelessWidget {
  const ClCard({
    Key? key, 
    this.height, 
    this.width, 
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),  
    required this.child,
    this.borderColor,
    this.backgroundColor,
    this.backgroundGradient,
  }) : super(key: key);

  final Widget child;

  final double? height;
  final double? width;

  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  final Color? borderColor;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        gradient: backgroundGradient,
        border: borderColor != null ? Border.all(
          color: borderColor!,
        ) : null,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0c000000),
            offset: Offset(0.0, 2.0),
            blurRadius: 12.0,
            // spreadRadius: 1.0
          )
        ],
      ),
      child: child,
    );
  }
}