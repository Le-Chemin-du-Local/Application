import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/service_details_page/service_details_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/widgets/service_info_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AvailableServices extends StatelessWidget {
  const AvailableServices({
    Key? key,
    required this.alreadySubscribedServices,
  }) : super(key: key);

  final List<String> alreadySubscribedServices;

  QueryOptions _allServicesInfoQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qAllServicesInfo)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenHelper.instance.horizontalPadding
      ),
      child: Column(
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
                final List<ServiceInfo> servicesInfo = [];

                for (final map in mapServices) {
                  final ServiceInfo serviceInfo = ServiceInfo.fromJson(map as Map<String, dynamic>);

                  if (
                    !alreadySubscribedServices.contains("${serviceInfo.id}_M") &&
                    !alreadySubscribedServices.contains("${serviceInfo.id}_T")) {
                      servicesInfo.add(serviceInfo);
                    }
                }

                if (servicesInfo.isEmpty) {
                  return const Center(
                    child: ClStatusMessage(
                      type: ClStatusMessageType.success,
                      message: "Vous avez souscrit à tous les services !",
                    ),
                  );
                }

                return _buildContent(context, servicesInfo);
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<ServiceInfo> services) {
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
        for (final serviceInfo in services)
          ServiceInfoCard(
            serviceInfo: serviceInfo,
            onButtonClick: () async {
              await Navigator.of(context).push<dynamic>(
                MaterialPageRoute<dynamic>(
                  builder: (context) => ServiceDetailsPage(serviceInfo: serviceInfo,)
                )
              );
            },
          )
      ],
    );
  }
}