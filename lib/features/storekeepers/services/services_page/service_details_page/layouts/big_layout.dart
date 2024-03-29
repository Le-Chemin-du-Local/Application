import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/service_details_page/widgets/simultation_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/service_details_page/widgets/tarif_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/widgets/why_us.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BigLayout extends StatelessWidget {
  const BigLayout({
    Key? key,
    required this.serviceInfo,
    required this.onSubscribe,
  }) : super(key: key);

  final ServiceInfo serviceInfo;

  final Function(ServiceInfo, ServiceType) onSubscribe;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Première colonne
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenHelper.instance.horizontalPadding
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // La description courte
                  Text(serviceInfo.shortDescription, style: Theme.of(context).textTheme.headlineMedium,),
                  const SizedBox(height: 16,),

                  // La description longue
                  Text(serviceInfo.longDescription),
                  const SizedBox(height: 16,),

                  ElevatedButton(
                    onPressed: () => launchUrlString(
                      "https://chemin-du-local.bzh/le-monde-de-breizhine-l-hermine",
                      mode: LaunchMode.externalApplication
                    ), 
                    child: const Text("En savoir plus sur nos convictions")
                  ),
                  const SizedBox(height: 16,),

                  // Les tarifs
                  Text("Nos tarifs", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w500
                  ),),
                  const SizedBox(height: 12,),

                  // Les tarifs
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 423),
                            child: TarifCard(
                              serviceInfo: serviceInfo, 
                              serviceType: ServiceType.monthly,
                              onSubscribe: () => onSubscribe(serviceInfo, ServiceType.monthly)
                            ),
                          ),
                        ),
                        const SizedBox(width: 12,),
                        Flexible(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 423),
                            child: TarifCard(
                              serviceInfo: serviceInfo, 
                              serviceType: ServiceType.transactions, 
                              onSubscribe: () => onSubscribe(serviceInfo, ServiceType.transactions)
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

        // Seconde colonne
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenHelper.instance.horizontalPadding
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // La carte de simulation des tarifs
                SimulationCard(serviceInfo: serviceInfo),
                const SizedBox(height: 30,),

                // Le pourquoi nous
                const WhyUs(),
              ],
            ),
          ),
        )
      ],
    );
  }
}