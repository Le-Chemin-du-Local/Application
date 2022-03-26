import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_graphql.dart';
import 'package:chemin_du_local/features/user/user.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({Key? key}) : super(key: key);

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

          return _buildContent(user.commerce!.services);
        },
      ),
    );
  }

  Widget _buildContent(List<String> services) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(services.join(","))
      ],
    );
  }
}