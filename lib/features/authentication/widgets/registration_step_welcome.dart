import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class RegistrationStepWelcome extends StatelessWidget {
  const RegistrationStepWelcome({
    Key? key,
    required this.onStartNavigation,
  }) : super(key: key);

  final Function() onStartNavigation;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Le titre
          Row(
            children: [
              const Icon(
                Icons.check_circle_outline_outlined,
                color: Palette.colorSuccess,
                size: 50,
              ),
              const SizedBox(width: 18,),

              Expanded(child: Text("Inscription terminée, bienvenue !", style: Theme.of(context).textTheme.headlineSmall,))
            ],
          ),
          const SizedBox(height: 22,),

          // Le text de bienvenue
          const Text("Votre compte est maintenant créé, après avoir validé votre adresse mail, vous allez pouvoir accéder à plein de délicieux produits locaux tout en soutenant les commerçants locaux, merci 😉 !"),
          const SizedBox(height: 22,),

          // Le bouton
          ElevatedButton(
            onPressed: onStartNavigation, 
            child: const Text("Commencer à naviguer")
          )
        ],
      ),
    );
  }
}