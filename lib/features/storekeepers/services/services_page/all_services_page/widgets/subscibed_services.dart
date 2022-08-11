import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/widgets/service_info_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SubscribedServices extends StatelessWidget {
  const SubscribedServices({Key? key, required this.commerceID, required this.subscribedServices}) : super(key: key);

  final String commerceID;
  final List<String> subscribedServices;

  QueryOptions _serviceInfoQueryOption(String serviceID) {
    return QueryOptions(
      document: gql(qServiceInfo),
      variables: <String, dynamic>{
        "serviceID": serviceID
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
          child: GridView(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              childAspectRatio: 1.8,
              maxCrossAxisExtent: 423,
              mainAxisExtent: 236,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12
            ),
            children: [
              for (final serviceString in subscribedServices) 
                Builder(
                  builder: (context) {
                    final String serviceID = serviceString.split("_")[0];
                    final ServiceType serviceType = serviceString.split("_")[1] == "T" ? ServiceType.transactions : ServiceType.monthly; 

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
                          isSelected: true,
                          onSelect: (value) {},
                          onTypeChanged: (type) {}
                        );
                      },
                    );
                  },
                )
            ],
          ),
        )
      ],
    );
  }
}