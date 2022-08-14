import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/ccproducts_page/ccproducts_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/paniers_page/paniers_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/all_services_page/widgets/update_type_dialog.dart';
import 'package:chemin_du_local/features/storekeepers/services/widgets/service_info_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SubscribedServices extends StatelessWidget {
  const SubscribedServices({
    Key? key,
    required this.commerce,
    required this.subscribedServices,
    required this.shouldRefetch,
  }) : super(key: key);

  final Commerce commerce;
  final List<String> subscribedServices;

  final Function() shouldRefetch;

  QueryOptions _serviceInfoQueryOption(String serviceID) {
    return QueryOptions(
      document: gql(qServiceInfo),
      variables: <String, dynamic>{
        "serviceID": serviceID
      }
    );
  } 

  MutationOptions _updateServiceOption() {
    return MutationOptions<dynamic>(
      document: gql(mutUpdateServices),
      onCompleted: (dynamic data) {
        if (data == null) return;

        shouldRefetch();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Le titre
        Text("Services souscrits", style: Theme.of(context).textTheme.headlineMedium,),
        const SizedBox(height: 12,),

        // Les cartes
        Flexible(
          child: Mutation<dynamic>(
            options: _updateServiceOption(),
            builder: (runMutation, result) {
              if (result?.isLoading ?? false) {
                return const Center(child: CircularProgressIndicator(),);
              }


              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (result?.hasException ?? false) ...{
                    const ClStatusMessage(
                      message: "Nous n'avons pas put mettre à jour votre service.",
                    ),
                    const SizedBox(height: 12,)
                  },

                  Flexible(
                    child: GridView(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: 1.8,
                        maxCrossAxisExtent: 423,
                        mainAxisExtent: 248,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12
                      ),
                      children: [
                        for (final serviceString in subscribedServices) 
                          Builder(
                            builder: (context) {
                              final List<String> splittedServiceString = serviceString.split("_");
                              final String serviceID = splittedServiceString[0];
                              final ServiceType serviceType = (splittedServiceString.length > 2 && splittedServiceString[2] == "UPDATE") ? ServiceType.transactions : splittedServiceString[1] == "T" ? ServiceType.transactions : ServiceType.monthly; 
                  
                              return Query<dynamic>(
                                options: _serviceInfoQueryOption(serviceID),
                                builder: (result, {fetchMore, refetch}) {
                                  if (result.isLoading) {
                                    return const ClCard(
                                      child: Center(child: CircularProgressIndicator(),),
                                    );
                                  } 
                  
                                  if (result.hasException) {
                                    return const ClCard(
                                      child: Center(
                                        child: ClStatusMessage(
                                          message: "Impossible de charger les infos du servie",
                                        ),
                                      ),
                                    );
                                  }
                  
                                  final ServiceInfo serviceInfo = ServiceInfo.fromJson(result.data!["serviceInfo"] as Map<String, dynamic>);
                  
                                  return ServiceInfoCard(
                                    serviceInfo: serviceInfo, 
                                    serviceType: serviceType, 
                                    isMonthlyTransitioning: splittedServiceString.length > 2 && splittedServiceString[2] == "UPDATE",
                                    isSelected: true,
                                    onSelect: (value) {},
                                    buttonText: "Accéder",
                                    onButtonClick: () => _onAccessService(context, serviceInfo),
                                    onTypeChanged: (type) => _onUpdateServiceType(
                                      context, 
                                      serviceInfo, 
                                      type, 
                                      alreadyContainsUpdate: serviceString.split("_").length > 2 && serviceString.split("_")[2] == "UPDATE",
                                      runMutation: runMutation
                                    )
                                  );
                                },
                              );
                            },
                          )
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        )
      ],
    );
  }

  Future _onAccessService(BuildContext context, ServiceInfo info) async {
    switch (info.id) {
      case "CLICKANDCOLLECT":
        await Navigator.of(context).push<dynamic>(
          MaterialPageRoute<dynamic>(
            builder: (context) => CCProductsPage(commerceID: commerce.id!)
          )
        );
        break;
      case "PANIERS":
        await Navigator.of(context).push<dynamic>(
          MaterialPageRoute<dynamic>(
            builder: (context) => const PaniersPage()
          )
        );
        break;
      default:
    }
  }

  Future _onUpdateServiceType(BuildContext context, ServiceInfo info, ServiceType newType, {
    required bool alreadyContainsUpdate,
    RunMutation? runMutation
  }) async {
    final nextBillingDate = commerce.lastBilledDate!.add(const Duration(days: 30));

    final bool applyUpdate = await showDialog<bool?>(
      context: context, 
      barrierDismissible: false,
      builder: (context) => UpdateTypeDialog(
        info: info, 
        newType: newType, 
        alreadyContainsUpdate: alreadyContainsUpdate, 
        nextBillingDate: nextBillingDate
      )
    ) ?? false;

    if (applyUpdate && runMutation != null) {
      runMutation(<String, dynamic>{
        "commerceID": commerce.id,
        "services": <Map<String, dynamic>>[
          <String, dynamic>{
            "serviceID": "${info.id}_${newType == ServiceType.transactions ? "T" : "M"}",
            "updateType": "UPDATE",
          }
        ]
      });
    }
  }
}