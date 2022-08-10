import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/dates_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/ccproducts_page/ccproducts_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/paniers_page/paniers_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/services.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/widgets/available_services.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/service_details_page/widgets/due_balance.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/widgets/service_card.dart';
import 'package:chemin_du_local/features/user/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({
    Key? key,
    required this.onPageChanged,
    required this.onShowDrawer,
  }) : super(key: key);

  final Function(int) onPageChanged;
  final Function() onShowDrawer;

  QueryOptions _commerceServicesQueryOption() {
    return QueryOptions<dynamic>(
      document: gql(qGetServicesForStoreKeeper)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppBar(
        onShowDrawer: onShowDrawer,
        canPop: false,
        title: const Text("Mes services"),
      ),
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

          return _buildContent(context, commerce: user.commerce!);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, {
    required Commerce commerce,
  }) {
    

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // La balance en cours
          if (commerce.services.isNotEmpty && commerce.firstBillingDate != null) ...{
            DueBalance(commerce: commerce,),
            const SizedBox(height: 12,),
          },

          // Les services pouvant être souscrits
          Flexible(
            child: AvailableServices(
              alreadySubscribedServices: commerce.services
            ),
          )
        ],
      ),
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