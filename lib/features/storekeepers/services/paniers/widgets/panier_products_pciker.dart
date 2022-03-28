import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:chemin_du_local/features/products/products_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/widgets/panier_product_picker_row.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PanierProductsPicker extends StatelessWidget {
  const PanierProductsPicker({
    Key? key,
    required this.initialProductsID,
    required this.onProductTapped,
    this.commerceID
  }) : super(key: key);

  final List<String> initialProductsID;
  final Function(String) onProductTapped;

  final String? commerceID;

  QueryOptions<dynamic> _categoriesQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qCategories),
      variables: <String, dynamic>{
        "commerceID": commerceID
      }
    );
  }
  Widget build(BuildContext context) {
    return Query<dynamic>(
      options: _categoriesQueryOptions(),
      builder: (categoriesQueryResult, {fetchMore, refetch}) {
        if (categoriesQueryResult.isLoading) {
          return const Center(child: CircularProgressIndicator(),);
        }

        // We show error if any
        if (categoriesQueryResult.hasException) {
          return const Align(
            alignment: Alignment.topCenter,
            child: ClStatusMessage(
              message: "Nous n'arrivons pas à charger les produits du commerces...",
            ),
          );
        }

        // We show a message if there is no commerce
        if (categoriesQueryResult.data == null) {
          return const Align(
            alignment: Alignment.topCenter,
            child: ClStatusMessage(
              type: ClStatusMessageType.info,
              message: "Le commerce n'existe pas encore. Vérifiez que vous l'avez bien créé",
            ),
          );
        }

        final Commerce commerce = Commerce.fromJson(categoriesQueryResult.data!["commerce"] as Map<String, dynamic>);

        return _buildContent(commerce);
      }
    );
  }

  Widget _buildContent(Commerce commerce) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final category in commerce.categories) 
          Flexible(
            child: PanierProductPickerRow(
              category: category,
              initialProductsID: initialProductsID,
              commerceID: commerceID,
              onProductTapped: onProductTapped,
            ),
          )
      ],
    );
  }
}