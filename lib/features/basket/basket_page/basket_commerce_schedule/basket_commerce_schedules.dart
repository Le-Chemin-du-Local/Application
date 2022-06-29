import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/basket/basket_graphql.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_commerce_schedule/widgets/basket_commerce_schedules_content.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BasketCommerceSchedules extends StatelessWidget {
  const BasketCommerceSchedules({
    Key? key,
    required this.commerceID,
    required this.onDateChoosed,
  }) : super(key: key);

  final String commerceID;

  final Function(DateTime) onDateChoosed;

  QueryOptions _getCCSchedulesOptions() {
    return QueryOptions<dynamic>(
      document: gql(qGetCommerceClickandcollectSchedule),
      variables: <String, dynamic>{
        "id":commerceID
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Query<dynamic>(
      options: _getCCSchedulesOptions(), 
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator(),);
        }

        if (result.hasException) {
          return const Align(
            alignment: Alignment.topCenter,
            child: ClStatusMessage(
              message: "Nous n'arrivons pas à récupérer les informations du commerce...",
            ),
          );
        }
        
        final Commerce commerce = Commerce.fromJson(result.data!["commerce"] as Map<String, dynamic>);

        return BasketCommerceSchedulesContent(
          commerce: commerce,
          onDateChoosed: onDateChoosed
        );
      }
    );
  }
}