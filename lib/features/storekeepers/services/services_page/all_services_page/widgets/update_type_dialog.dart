import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/badge.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateTypeDialog extends StatelessWidget {
  const UpdateTypeDialog({
    Key? key,
    required this.info,
    required this.newType,
    required this.alreadyContainsUpdate,
    required this.nextBillingDate,
  }) : super(key: key);

  final ServiceInfo info;
  final ServiceType newType;

  final bool alreadyContainsUpdate;

  final DateTime nextBillingDate;

  @override
  Widget build(BuildContext context) {
    final newTypeString = newType == ServiceType.monthly ? "Mensuel" : "Consommation";
    final oldTypeString = newType == ServiceType.monthly ? "Consommation" : "Mensuel";

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 462),
        child: Padding(
          padding: EdgeInsets.all(ScreenHelper.instance.horizontalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // L'icon de warning
              Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.primary,
                size: 55,
              ),
              const SizedBox(height: 12,),
      
              // Le message de description
              Flexible(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headlineSmall,
                    text: "Etes-vous sûr de vouloir changer votre mode de ",
                    children: [
                      TextSpan(
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        text: oldTypeString
                      ),
                      const TextSpan(text: " à "),
                      TextSpan(
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        text: newTypeString
                      ),
                      const TextSpan(text: " ?")
                    ]
                  ),
                ),
              ),
              const SizedBox(height: 12,),
      
              // Le service modifié
              Text("Le service suivant sera modifié :", style: Theme.of(context).textTheme.headlineSmall,),
              const SizedBox(height: 10,),
              Badge(child: Text(info.name)),
              const SizedBox(height: 12,),
      
              // L'information de prix
              if (alreadyContainsUpdate) 
                const Text("Vous reviendrez donc à l'état d'origine", textAlign: TextAlign.center,)
              else if (newType == ServiceType.transactions) 
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headlineSmall,
                    children: [
                      const TextSpan(text: "A partir du "),
                      TextSpan(
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        text: DateFormat("dd/MM/yyyy").format(nextBillingDate)
                      ),
                      const TextSpan(text: " vous paierez "),
                      TextSpan(
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        text: "${info.transactionPercentage}%"
                      ),
                      const TextSpan(text: " par transaction au lieu de "),
                      TextSpan(
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        text: "${info.monthPrice}€*/mois"
                      )
                    ]
                  ),
                )
              else if (newType == ServiceType.monthly)
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headlineSmall,
                    children: [
                      const TextSpan(text: "A partir de "),
                      const TextSpan(
                        style: TextStyle(fontWeight: FontWeight.w500),
                        text: "aujourd'hui"
                      ),
                      const TextSpan(text: " vous paierez "),
                      TextSpan(
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        text: "${info.monthPrice}€*/mois"
                      ),
                      const TextSpan(text: " au lieu de "),
                      TextSpan(
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        text: "${info.transactionPercentage}%"
                      ),
                      const TextSpan(text: " par transaction. Le reste des jours jusqu'à votre prochain paiemment sera ajouté à votre balance."),
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
    );
  }
}