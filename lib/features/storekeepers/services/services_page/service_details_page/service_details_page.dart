import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/service_details_page/layouts/big_layout.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/service_details_page/layouts/small_layout.dart';
import 'package:flutter/material.dart';

class ServiceDetailsPage extends StatelessWidget {
  const ServiceDetailsPage({
    Key? key,
    required this.serviceInfo,
  }) : super(key: key);

  final ServiceInfo serviceInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppBar(
        canPop: Navigator.of(context).canPop(),
        title: Text(serviceInfo.name),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= ScreenHelper.breakpointTablet) {
            return BigLayout(serviceInfo: serviceInfo);
          }

          return SmallLayout(serviceInfo: serviceInfo);
        },
      ),
    );
  }
}