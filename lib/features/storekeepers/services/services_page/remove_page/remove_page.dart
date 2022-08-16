import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/remove_page/widgets/remove_confirmation_dialog.dart';
import 'package:chemin_du_local/features/storekeepers/services/widgets/service_info_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tuple/tuple.dart';

class RemovePage extends StatefulWidget {
  const RemovePage({
    Key? key,
    required this.commerce,
    required this.subscribedServices,
    required this.onCancel,
    required this.onSuccess,
  }) : super(key: key);

  final Commerce commerce;
  final List<String> subscribedServices;

  final Function() onCancel;
  final Function() onSuccess;

  @override
  State<RemovePage> createState() => _RemovePageState();
}

class _RemovePageState extends State<RemovePage> {
  final Map<String, Tuple2<ServiceInfo, ServiceType>> _selectedServices = {};

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

        widget.onSuccess();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Mutation<dynamic>(
      options: _updateServiceOption(),
      builder: (runMutation, result) {
        if (result?.isLoading ?? false) {
          return const Center(child: CircularProgressIndicator(),);
        }

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenHelper.instance.horizontalPadding
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isBig = constraints.maxWidth + ScreenHelper.instance.horizontalPadding * 2 >= ScreenHelper.breakpointTablet;

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Le titre
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Séléctionnez le ou les services à résilier",
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      const SizedBox(width: 12,),

                      if (isBig) ...{
                        OutlinedButton.icon(
                          onPressed: _selectedServices.isEmpty ? null : () => _onRemoveServices(runMutation: runMutation), 
                          icon: const Icon(Icons.close), 
                          label: const Text("Résilier")
                        ),
                        const SizedBox(width: 8,),
                        ElevatedButton(
                          onPressed: widget.onCancel, 
                          child: const Text("Annuler")
                        )
                      }
                    ],
                  ),
                  if (!isBig) 
                    const SizedBox(height: 16,),

                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (result?.hasException ?? false) ...{
                          const ClStatusMessage(
                            message: "Nous n'avons pas réussi à résilier vos servies...",
                          ),
                          const SizedBox(height: 12,)
                        },

                        Expanded(
                          child: GridView(
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1.8,
                              crossAxisCount: constraints.maxWidth < 435 ? 1 : constraints.maxWidth ~/ 435,
                              mainAxisExtent: 236,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                            ),
                            children: [
                              for (final serviceString in widget.subscribedServices) 
                                if (!serviceString.contains("_REMOVE"))
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
                                            isSelected: _selectedServices.keys.contains(serviceString),
                                            forceHideBorder: false,
                                            onSelect: (isSelected) {
                                              if (isSelected) {
                                                setState(() {
                                                  _selectedServices[serviceString] = Tuple2(serviceInfo, serviceType);
                                                });
                                              } 
                                              else {
                                                setState(() {
                                                  _selectedServices.remove(serviceString);
                                                });
                                              }
                                            },
                                            buttonText: "Accéder",
                                            onButtonClick: () {},
                                            onTypeChanged: (type) {}
                                          );
                                        },
                                      );
                                    },
                                  )
                            ],
                          ),
                        ),

                        if (!isBig) ...{
                          const SizedBox(height: 12,),
                          OutlinedButton.icon(
                            onPressed: _selectedServices.isEmpty ? null : () => _onRemoveServices(runMutation: runMutation), 
                            icon: const Icon(Icons.close), 
                            label: const Text("Résilier")
                          ),
                          const SizedBox(width: 8,),
                          ElevatedButton(
                            onPressed: widget.onCancel, 
                            child: const Text("Annuler")
                          ),
                          const SizedBox(height: 8,)
                        }
                      ],
                    )
                  )
                ],
              );
            }
          ),
        );
      }
    );
  }

  Future _onRemoveServices({
    RunMutation? runMutation,
  }) async {
    final bool applyRemoval = await showDialog<bool?>(
      context: context,
      builder: (context) => RemoveConfirmationDialog(
        serivces: _selectedServices.values.toList(),
        nextBillingDate: widget.commerce.lastBilledDate!.add(const Duration(days: 30))
      )
    ) ?? false;

    if (applyRemoval && runMutation != null) {
      runMutation(<String, dynamic>{
        "commerceID": widget.commerce.id!,
        "services": <Map<String, dynamic>>[
          for (final service in _selectedServices.values) 
            <String, dynamic>{
              "serviceID": "${service.item1.id}_${service.item2 == ServiceType.transactions ? "T" : "M"}",
              "updateType": "REMOVE"
            }
        ]
      });
    }
  }
}