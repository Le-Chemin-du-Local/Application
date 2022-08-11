import 'package:chemin_du_local/core/widgets/buttons_tabbar.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/all_services_page/widgets/available_services.dart';
import 'package:flutter/material.dart';

class AllServicesPage extends StatelessWidget {
  const AllServicesPage({
    Key? key,
    required this.commerce,
    required this.onCancel,
    required this.onSubscribe
  }) : super(key: key);
  
  final Commerce commerce;

  final Function() onSubscribe;
  final Function() onCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: ButtonsTabBar(
                currentIndex: 0, 
                titles: const [
                  Text("Tous les services"),
                  Text("Souscrits"),
                  Text("Non souscrits"),
                  Text("Bientôt disponibles")
                ], 
                onIndexChanged: (index) {}
              ),
            ),
            const SizedBox(width: 12,),

            OutlinedButton.icon(
              onPressed: onCancel,
              icon: const Icon(Icons.close),
              label: const Text("Résilier un service"),
            ),
            const SizedBox(width: 8,),
            ElevatedButton.icon(
              onPressed: onSubscribe,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text("Souscrire à un service"),
            )

          ],
        ),
        const SizedBox(height: 16,),

        // Les services pouvant être souscrits
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: AvailableServices(
                    commerceID: commerce.id!,
                    alreadySubscribedServices: commerce.services
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}