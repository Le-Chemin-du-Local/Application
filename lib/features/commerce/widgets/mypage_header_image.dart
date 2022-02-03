import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class MyPageHeaderImage extends StatelessWidget {
  const MyPageHeaderImage({
    Key? key,
    required this.imageSrc
  }) : super(key: key);

  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    const double height = 242.0;

    return Stack(
      children: [
        SizedBox(
          height: height,
          width: double.infinity,
          child: Image.asset(imageSrc, fit: BoxFit.cover,
        )),
        Container(
          height: height,
          decoration: const BoxDecoration(
            gradient: Palette.gradientBlackCover
          ),
        )
      ],
    );   
  }
}