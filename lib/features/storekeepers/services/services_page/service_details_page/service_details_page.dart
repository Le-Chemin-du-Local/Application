import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_basket_controller.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/service_details_page/layouts/big_layout.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/service_details_page/layouts/small_layout.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/services_basket_page/services_basket_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceDetailsPage extends ConsumerWidget {
  const ServiceDetailsPage({
    Key? key,
    required this.commerceID,
    required this.serviceInfo,
  }) : super(key: key);

  final String commerceID;
  final ServiceInfo serviceInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: ClAppBar(
        canPop: Navigator.of(context).canPop(),
        title: Text(serviceInfo.name),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= ScreenHelper.breakpointTablet) {
            return BigLayout(
              serviceInfo: serviceInfo,
              onSubscribe: (info, type) => _onSubscribe(
                context, 
                ref,
                info: info,
                type: type
              ),
            );
          }

          return SmallLayout(
            serviceInfo: serviceInfo,
            onSubscribe: (info, type) => _onSubscribe(
              context, 
              ref, 
              info: info, 
              type: type
            ),
          );
        },
      ),
    );
  }

  Future _onSubscribe(BuildContext context, WidgetRef ref, {
    required ServiceInfo info,
    required ServiceType type
  }) async {
    if (ref.read(servicesBasketControllerProvider).containsService(info)) {
      ref.read(servicesBasketControllerProvider.notifier).replaceServiceInfoType(info, type);
    }
    else {
      ref.read(servicesBasketControllerProvider.notifier).addServiceInfo(info, type);
    }

    bool success = await Navigator.of(context).push<bool?>(
      MaterialPageRoute<bool?>(
        builder: (context) => ServicesBasketPage(commerceID: commerceID,)
      )
    ) ?? false;

    if (success) {
      Navigator.of(context).pop(true);
    }
  }
}