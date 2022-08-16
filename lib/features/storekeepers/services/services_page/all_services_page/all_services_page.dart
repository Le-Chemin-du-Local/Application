import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/buttons_tabbar.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/all_services_page/widgets/available_services.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/all_services_page/widgets/subscibed_services.dart';
import 'package:flutter/material.dart';

enum Filter { allServices, subscribedServices, availableServices, comingSoonServices }

final Map<Filter, int> _indexForFilter = {
  Filter.allServices: 0,
  Filter.subscribedServices: 1,
  Filter.availableServices: 2,
  Filter.comingSoonServices: 3
};

class AllServicesPage extends StatefulWidget {
  const AllServicesPage({
    Key? key,
    required this.commerce,
    required this.onCancel,
    required this.onSubscribe,
    required this.shouldRefetch,
  }) : super(key: key);
  
  final Commerce commerce;

  final Function() onSubscribe;
  final Function() onCancel;

  final Function() shouldRefetch;

  @override
  State<AllServicesPage> createState() => _AllServicesPageState();
}

class _AllServicesPageState extends State<AllServicesPage> {
  Filter _currentFilter = Filter.allServices;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isBig = constraints.maxWidth >= ScreenHelper.breakpointTablet;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: ScreenHelper.instance.horizontalPadding,
                    ),
                    child: ButtonsTabBar(
                      currentIndex: _indexForFilter[_currentFilter] ?? 0, 
                      titles: const [
                        Text("Tous les services"),
                        Text("Souscrits"),
                        Text("Non souscrits"),
                        Text("Bientôt disponibles")
                      ], 
                      onIndexChanged: (index) {
                        setState(() {
                          switch (index) {
                            case 0:
                              _currentFilter = Filter.allServices;
                              break;
                            case 1:
                              _currentFilter = Filter.subscribedServices;
                              break;
                            case 2:
                              _currentFilter = Filter.availableServices;
                              break;
                            case 3: _currentFilter = Filter.comingSoonServices;
                              break;
                            default:
                              _currentFilter = Filter.allServices;
                          }
                        });
                      }
                    ),
                  ),
                ),
                if (isBig)
                  const SizedBox(width: 12,),

                if (isBig) ...{
                  OutlinedButton.icon(
                    onPressed: widget.onCancel,
                    icon: const Icon(Icons.close),
                    label: const Text("Résilier un service"),
                  ),
                  const SizedBox(width: 8,),
                  ElevatedButton.icon(
                    onPressed: widget.onSubscribe,
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text("Souscrire à un service"),
                  ),
                  SizedBox(width: ScreenHelper.instance.horizontalPadding,)
                }
              ],
            ),
            const SizedBox(height: 16,),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenHelper.instance.horizontalPadding
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Les services déjà souscrits
                      if (widget.commerce.services.isNotEmpty && (_currentFilter == Filter.allServices || _currentFilter == Filter.subscribedServices)) ...{
                        Flexible(
                          child: SubscribedServices(
                            commerce: widget.commerce,
                            subscribedServices: widget.commerce.services,
                            shouldRefetch: widget.shouldRefetch,
                          ),
                        ),
                        const SizedBox(height: 16,),
                      },

                      // Les services pouvant être souscrits
                      if (_currentFilter == Filter.allServices || _currentFilter == Filter.availableServices) ...{
                        Flexible(
                          child: AvailableServices(
                            commerce: widget.commerce,
                            alreadySubscribedServices: widget.commerce.services,
                            shouldRefetch: widget.shouldRefetch,
                          ),
                        ),
                        const SizedBox(height: 16,),
                      }
                    ],
                  ),
                ),
              ),
            ),

            if (!isBig) 
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenHelper.instance.horizontalPadding
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8,),
                    OutlinedButton.icon(
                      onPressed: widget.onCancel,
                      icon: const Icon(Icons.close),
                      label: const Text("Résilier un service"),
                    ),
                    const SizedBox(height: 4,),
                    ElevatedButton.icon(
                      onPressed: widget.onSubscribe,
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text("Souscrire à un service"),
                    ),
                    // ignore: equal_elements_in_set
                    const SizedBox(height: 8,)
                ]
            ),
              )
          ],
        );
      }
    );
  }
}