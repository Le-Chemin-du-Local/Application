import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:flutter/material.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClCard(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: ScreenHelper.instance.horizontalPadding
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Le texte d'informations
            Flexible(
              child: Text(
                "Vous avez des modifications non sauvegardées, souhaitez-vous vraiment quitter la page ?",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 20,),

            // Les boutons (true veut dire sauvegarder)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              }, 
              child: const Text("Quitter et sauvegarder le contenue")
            ),
            const SizedBox(height: 12,),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              }, 
              child: const Text("Quitter sans sauvegarder"),
            )
          ],
        ),
      ),
    );
  }
}