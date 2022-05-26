import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class DashboardServicesCard extends StatelessWidget {
  final Function() onClick;

  const DashboardServicesCard({
    Key? key,
    required this.onClick
  }) : super(key: key);

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
              borderRadius: BorderRadius.circular(8.0),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Center(
                    child: Icon(
                      CLIcons.messervices, 
                      size: 121,
                      color: Palette.colorWhite,
                    )
                  ),
                ),
                TextButton(
                  onPressed: onClick,
                  style: TextButton.styleFrom(
                    primary: Palette.colorWhite,
                  ),
                  child: Row(
                    children: const [
                      Expanded(child: Text("Voir plus de services",)),
                      Icon(Icons.arrow_right_alt_rounded, size: 24,)
                    ],
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}