import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/ccproducts_page/ccproducts_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/paniers_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/services.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/widgets/service_card.dart';
import 'package:chemin_du_local/features/user/user.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({
    Key? key,
    required this.onPageChanged,
  }) : super(key: key);

  final Function(int) onPageChanged;

  QueryOptions _commerceServicesQueryOption() {
    return QueryOptions<dynamic>(
      document: gql(qGetServicesForStoreKeeper)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query<dynamic>(
        options: _commerceServicesQueryOption(),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }

          if (result.hasException) {
            return const Align(
              alignment: Alignment.topCenter,
              child: ClStatusMessage(
                message: "Nous n'arrivons pas à charger la liste de vos services...",
              ),
            );
          }

          final User user = User.fromJson(result.data!["user"] as Map<String, dynamic>);

          if (user.commerce == null) {
            return const Align(
              alignment: Alignment.topCenter,
              child: ClStatusMessage(
                message: "Vous n'avez pas de commerce a qui attacher des services...",
              ),
            );
          }

          return _buildContent(context, user.commerce!.services, commerceID: user.commerce!.id!);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<String> services, {
    required String commerceID,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: ScreenHelper.horizontalPadding,
        right: ScreenHelper.horizontalPadding
      ),
      child: CustomScrollView(
        slivers: [
          _buildActiveServices(context, services, commerceID: commerceID)
        ],
      ),
    );
  }

  Widget _buildActiveServices(BuildContext context, List<String> services, {
    required String commerceID,
  }) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisExtent: 228,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16
      ),
      delegate: SliverChildListDelegate([
        // Click & Collect
        if (services.contains(Services.clickAndCollect))
          ServiceCard(
            onClick: () => _openClickAndCollectProductsPage(context, commerceID: commerceID), 
            backgroundName: "illustration_click_and_collect.png", 
            title: "Click and collect"
          ),

        // Paniers
        if (services.contains(Services.paniers))
          ServiceCard(
            onClick: () => _openPanierService(context),
            backgroundName: "illustration_1.png",
            title: "Paniers",
          ),
      ]),
    );
  }

  Future _openClickAndCollectProductsPage(BuildContext context, {
    required String commerceID,
  }) async {
    await Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (context) => CCProductsPage(commerceID: commerceID,)
      )
    );
  }

  Future _openPanierService(BuildContext context) async {
    await Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (context) => const PaniersPage()
      )
    );
  }
}