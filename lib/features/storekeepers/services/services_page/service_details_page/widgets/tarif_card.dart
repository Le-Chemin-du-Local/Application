import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class TarifCard extends StatelessWidget {
  const TarifCard({
    Key? key, 
    required this.serviceInfo, 
    required this.serviceType,
    required this.onSubscribe,
  }) : super(key: key);

  final ServiceInfo serviceInfo;
  final ServiceType serviceType;

  final Function() onSubscribe;

  @override
  Widget build(BuildContext context) {
    final String priceString = serviceType == ServiceType.monthly
      ? "${serviceInfo.monthPrice}€"
      : "${serviceInfo.transactionPercentage}%";

    final List<String> advantages = serviceType == ServiceType.monthly 
      ? serviceInfo.monthAdvantages
      : serviceInfo.transactionAdvantages;

    return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // L'illustration
          Image.asset(
            "assets/images/epi.png",
            height: 150,
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(height: 4,),

          // Le type
          Text(
            serviceType == ServiceType.monthly ? "Mensuel" : "A la consommation",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 10,),

          // L'info d'à partir
          if (serviceType == ServiceType.monthly) 
            Text("A partir de", textAlign: TextAlign.center, style: TextStyle(
              fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary
            ),)
          else 
            const SizedBox(height: 14,),

          // Le prix
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
              ),
              text: priceString,
              children: [
                TextSpan(
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.secondary
                  ),
                  text: serviceType == ServiceType.monthly ? " /mois" : " /commande"
                )
              ]
            ),
          ),
          const SizedBox(height: 10,),

          // Le bouton de soubscription
          Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
              onPressed: onSubscribe,
              icon: const Icon(Icons.arrow_back),
              label: const Text("Souscrire"),
            ),
          ),
          const SizedBox(height: 10,),

          // Le bouton d'information
          Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
              onPressed: onSubscribe,
              icon: const Icon(Icons.info_outline),
              label: const Text("Tout connaitre sur nos tarifs"),
            ),
          ),
          const SizedBox(height: 10,),

          // Le comment ça marche (2 cas : pour le mensuelle et pour le conso)
          Text("Comment ça marche", style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w500
          ),),
          const SizedBox(height: 8,),
          if (serviceType == ServiceType.monthly)
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    text: "En dessous de ${serviceInfo.monthMinimumAllowedCA.toInt()}€ de CA avec le Chemin du local",
                  ),
                  TextSpan(
                    text: ", le tarif est de ${serviceInfo.monthPrice.toInt()}€ HT/mois. "
                  ),
                  TextSpan(
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    text: "Tous les ${serviceInfo.monthCARange.toInt()}€ de CA en plus"
                  ),
                  TextSpan(
                    text: ", le tarif augmente de ${serviceInfo.monthCAPriceAugmentation.toInt()}€ HT/mois."
                  )
                ]
              ),
            )
          else ...{
            Text(
              "Vous ne payez que si vous avez des commandes",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            Text("Pour chaque commande passée dans votre boutique, nous prélevons ${serviceInfo.transactionPercentage.toInt()}%"),
            const SizedBox(height: 6,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 24,
                ),
                const SizedBox(width: 4,),

                Expanded(
                  child: Text(
                  "A partir de ${((serviceInfo.monthPrice + 1) / (serviceInfo.transactionPercentage / 100)).toStringAsFixed(2)}€ de CA,"
                  " vous paierez ${serviceInfo.monthPrice + 1}€ HT. Le tarif mensuel vous permet d'alleger votre facuture."
                  )
                )
              ],
            )
          },
          const SizedBox(height: 8,),

          // Les avantages
          Text("Avantage", style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w500
          ),),
          const SizedBox(height: 8,),

          for (final advantage in advantages)
            Row(
              children: [
                const Icon(Icons.check_circle_outline_outlined, size: 30, color: Palette.colorSuccess,),
                const SizedBox(width: 4,),
                Text(advantage, style: Theme.of(context).textTheme.headlineSmall,)
              ],
            ),

        ],
      ),
    );
  }
}