import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    Key? key,
    required this.onClick,
    required this.backgroundName,
    required this.title
  }) : super(key: key);

  final Function() onClick;

  final String backgroundName;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            height: 228,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/$backgroundName"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            height: 228,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: const LinearGradient(
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
                colors: [
                  Color(0x41000000),
                  Color(0x00c4c4c4)
                ],
                stops: [
                  0.0,
                  1.0
                ]
              ),
            ),
            
            // The button
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ClElevatedButton(
                onPressed: onClick,
                child: Row(
                  children: [
                    Expanded(child: Text(title,)),
                    const Icon(Icons.arrow_right_alt_rounded, size: 24,)
                  ],
                ),
              )
            )
          ),
        ],
      ),
    );
  }
}