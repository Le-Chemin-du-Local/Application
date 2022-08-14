import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/badge.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class RemoveConfirmationDialog extends StatelessWidget {
  const RemoveConfirmationDialog({
    Key? key,
    required this.serivces,
    required this.nextBillingDate
  }) : super(key: key);

  final List<Tuple2<ServiceInfo, ServiceType>> serivces;
  final DateTime nextBillingDate;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.headlineSmall!,
        textAlign: TextAlign.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 426),
          child: Padding(
            padding: EdgeInsets.all(ScreenHelper.instance.horizontalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // L'icone de warning
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                  size: 55,
                ),
                const SizedBox(height: 12,),
      
                // Le message de description
                const Text("Êtes vous sûr de vouloir résilier ?"),
                const SizedBox(height: 12,),

                // Le service modifié
                const Text("Les services suivants seront résilés"),
                const SizedBox(height: 10,),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final service in serivces) 
                      Badge(child: Text(service.item1.name))
                  ],
                ),
                const SizedBox(height: 12,),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headlineSmall,
                    text: "Vos services ne seront plus disponible ",
                    children: [
                      const TextSpan(
                        text: "immédiatement",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const TextSpan(
                        text: " pour vos services à la consomation et le ",
                      ),
                      TextSpan(
                        text: DateFormat("dd/MM/yyyy").format(nextBillingDate),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const TextSpan(
                        text: " pour les services au mois"
                      )
                    ]
                  ),
                ),
                const SizedBox(height: 12,),

                // Les bouton
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text("Oui"),
                    ),
                    const SizedBox(width: 4,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      }, 
                      child: const Text("Non"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}