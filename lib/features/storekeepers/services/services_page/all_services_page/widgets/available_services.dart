import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/service_details_page/service_details_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/widgets/service_info_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tuple/tuple.dart';

class AvailableServices extends StatelessWidget {
  const AvailableServices({
    Key? key,
    required this.commerceID,
    required this.alreadySubscribedServices,
    required this.shouldRefetch,
  }) : super(key: key);

  final String commerceID; 
  final List<String> alreadySubscribedServices;

  final Function() shouldRefetch;

  QueryOptions _allServicesInfoQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qAllServicesInfo)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Le titre
        Text("Services non souscrit", style: Theme.of(context).textTheme.headlineMedium,),
        const SizedBox(height: 12,),

        // Le contenue
        Flexible(
          child: Query<dynamic>(
            options: _allServicesInfoQueryOptions(), 
            builder: (result, {fetchMore, refetch}) {
              if (result.isLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }

              if (result.hasException) {
                return const Center(
                  child: ClStatusMessage(
                    message: "Nous ne parvenons pas à charger la liste des services disponibles",
                  ),
                );
              }

              final List mapServices = result.data!["allServicesInfo"] as List;
              final List<Tuple2<ServiceInfo, ServiceType>> servicesInfo = [];

              for (final map in mapServices) {
                final ServiceInfo serviceInfo = ServiceInfo.fromJson(map as Map<String, dynamic>);

                if (
                  !alreadySubscribedServices.contains("${serviceInfo.id}_M") &&
                  !alreadySubscribedServices.contains("${serviceInfo.id}_T") && 
                  !alreadySubscribedServices.contains("${serviceInfo.id}_M_UPDATE")) {
                    servicesInfo.add(Tuple2(serviceInfo, ServiceType.monthly));
                  }
              }

              if (servicesInfo.isEmpty) {
                return const Center(
                  child: ClStatusMessage(
                    type: ClStatusMessageType.success,
                    message: "Vous avez souscrit à tous les services ! 🎉",
                  ),
                );
              }

              return _buildContent(context, servicesInfo);
            }
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, List<Tuple2<ServiceInfo, ServiceType>> services) {
    return StatefulBuilder(
      builder: (context, setState) {
        return GridView(
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: 1.8,
            maxCrossAxisExtent: 423,
            mainAxisExtent: 236,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          children: [
            for (int i = 0; i < services.length; ++i) 
              ServiceInfoCard(
                serviceInfo: services[i].item1,
                serviceType: services[i].item2,
                onTypeChanged: (type) {
                  setState(() {
                    services = [
                      for (int j = 0; j < services.length; ++j) 
                        if (j == i)
                          Tuple2(services[i].item1, type)
                        else 
                          services[i]
                    ];
                  });
                },
                onButtonClick: () async {
                  bool success = await Navigator.of(context).push<bool?>(
                    MaterialPageRoute<bool?>(
                      builder: (context) => ServiceDetailsPage(
                        serviceInfo: services[i].item1,
                        commerceID: commerceID,
                      )
                    )
                  ) ?? false;

                  if (success) shouldRefetch();
                },
              )
          ],
        );
      }
    );
  }
}