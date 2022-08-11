import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/buttons_tabbar.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/service_details_page/widgets/simultation_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/service_details_page/widgets/tarif_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/widgets/why_us.dart';
import 'package:flutter/material.dart';

class SmallLayout extends StatefulWidget {
  const SmallLayout({
    Key? key,
    required this.serviceInfo,
    required this.onSubscribe,
  }) : super(key: key);

  final ServiceInfo serviceInfo;

  final Function(ServiceInfo, ServiceType) onSubscribe;

  @override
  State<SmallLayout> createState() => _SmallLayoutState();
}

class _SmallLayoutState extends State<SmallLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenHelper.instance.horizontalPadding
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // La description courte
            Text(widget.serviceInfo.shortDescription, style: Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: 12,),

            // La description longue
            Text(widget.serviceInfo.longDescription),
            const SizedBox(height: 12,),

            // Pourquoi nous choisir
            const WhyUs(),
            const SizedBox(height: 12,),

            // Les tarifs
            Text("Nos tarifs", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w500
            ),),
            const SizedBox(height: 12,),
            ButtonsTabBar(
              currentIndex: _currentIndex, 
              titles: const [
                Text("Mensuel"),
                Text("A la consommation")
              ], 
              onIndexChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              }
            ),
            const SizedBox(height: 12,),
            <Widget>[
              TarifCard(
                serviceInfo: widget.serviceInfo, 
                serviceType: ServiceType.monthly, 
                onSubscribe: () => widget.onSubscribe(widget.serviceInfo, ServiceType.monthly)
              ),
              TarifCard(
                serviceInfo: widget.serviceInfo, 
                serviceType: ServiceType.transactions, 
                onSubscribe: () => widget.onSubscribe(widget.serviceInfo, ServiceType.transactions)
              )
            ][_currentIndex],
            const SizedBox(height: 12,),

            // Le simulateur
            SimulationCard(serviceInfo: widget.serviceInfo),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}