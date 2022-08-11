import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_basket_controller.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/service_details_page/service_details_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/services_basket_page/services_basket_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/widgets/service_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SubscribePage extends ConsumerWidget {
  const SubscribePage({
    Key? key,
    required this.commerce,
    required this.onCancel,
    required this.onSuccess
  }) : super(key: key);

  final Commerce commerce;

  final Function() onCancel;
  final Function() onSuccess;

  QueryOptions _allServicesInfoQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qAllServicesInfo)
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final List<String> alreadySubscribedServices = commerce.services;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Le titre 
        Row(
          children: [
            Expanded(
              child: Text(
                "Séléctionnez le ou les services à souscrire",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            const SizedBox(width: 12,),

            ElevatedButton.icon(
              onPressed: () => _onSubscribe(context),
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Souscrire aux services sélectionnés"),
            ),
            const SizedBox(width: 8,),
            OutlinedButton(
              onPressed: onCancel, 
              child: const Text("Annuler")
            )
          ],
        ),
        const SizedBox(height: 16,),

        // La liste des services
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
        
              return _buildContent(context, ref, servicesInfo);
            }
          )
        )
      ],
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, List<ServiceInfo> services) {
    return GridView(
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
            serviceType: ref.watch(servicesBasketControllerProvider).typeForService(serviceInfo),
            onButtonClick: () async {
              await Navigator.of(context).push<dynamic>(
                MaterialPageRoute<dynamic>(
                  builder: (context) => ServiceDetailsPage(
                    serviceInfo: serviceInfo,
                    commerceID: commerce.id!,
                  )
                )
              );
            },
            isSelected: ref.watch(servicesBasketControllerProvider).containsService(serviceInfo),
            onSelect: (isSelected) {
              if (isSelected) {
                ref.read(servicesBasketControllerProvider.notifier).addServiceInfo(serviceInfo, ServiceType.monthly);
              }
              else {
                ref.read(servicesBasketControllerProvider.notifier).removeServiceInfo(serviceInfo);
              }
            },
            onTypeChanged: (type) {
              ref.read(servicesBasketControllerProvider.notifier).replaceServiceInfoType(serviceInfo, type);
            },
          )
      ],
    );
  }

  Future _onSubscribe(BuildContext context) async {
    bool success = await Navigator.of(context).push<bool?>(
      MaterialPageRoute<bool?>(
        builder: (context) => ServicesBasketPage(
          commerceID: commerce.id!,
        )
      )
    ) ?? false;

    if (success) onSuccess();
  }
}