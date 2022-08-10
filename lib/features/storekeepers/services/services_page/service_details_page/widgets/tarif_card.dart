import 'dart:developer';

import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info.dart';
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
      ? "${serviceInfo.monthPrice}€*"
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
                  text: serviceType == ServiceType.monthly ? " /mois" : " /transactions"
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

          // Les avantages
          Text("Avantage", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
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

          if (serviceType == ServiceType.monthly) ...{
            const SizedBox(height: 8,),
            Text(
              "* Augmente de ${serviceInfo.monthAugmentationPerRangePercentage.toStringAsFixed(2)}% par tranche de ${serviceInfo.monthRangePercentage.toStringAsFixed(2)}% de CA à partir de ${serviceInfo.monthMinimumAllowedCA.toStringAsFixed(2)}€ de CA généré (cf simulateur)",
              style: Theme.of(context).textTheme.titleMedium,
            )
          }
        ],
      ),
    );
  }
}