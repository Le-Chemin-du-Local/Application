import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/dialog/closable_dialog.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/models/panier/panier.dart';
import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class PanierTypeDialog extends StatelessWidget {
  const PanierTypeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClosableDialog(
      title: "Quel est le type de panier ?",
      child: DefaultTextStyle(
        style: const TextStyle(color: Palette.colorWhite),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final List<Widget> children = [
              // Panier flash
              Flexible(
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(PanierType.temporary),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    padding: const EdgeInsets.all(40),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            CLIcons.clickAndCollect,
                            size: 92,
                            color: Palette.colorWhite,
                          ),
                          SizedBox(height: 10,),
                          Text("Créer un panier flash")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12, height: 12,),
    
              // Panier permanant
              Flexible(
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(PanierType.permanent),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    padding: const EdgeInsets.all(40),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            CLIcons.clickAndCollect,
                            size: 92,
                            color: Palette.colorWhite,
                          ),
                          SizedBox(height: 10,),
                          Text("Créer un panier permanant")
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ];

            if (constraints.maxWidth >= ScreenHelper.breakpointTablet) {
              return Row(
                children: children,
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            );
          }
        ),
      )
    );
  }
}