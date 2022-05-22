import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/features/products/products_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/widgets/services_products_picker_row.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ServicesProductPickerCategory extends StatelessWidget {
  const ServicesProductPickerCategory({
    Key? key, 
    required this.initialProductsIDs, 
    required this.onProductTapped,
    required this.category,
    this.initialQuantities,
    this.onQuantityChanged,
    this.commerceID,
  }) : super(key: key);

  final List<String> initialProductsIDs;
  final Function(Product) onProductTapped;
  final Map<String, int>? initialQuantities;
  final Function(Product,int)? onQuantityChanged;

  final String category;
  final String? commerceID;

  QueryOptions _productsQueryOption() {
    return QueryOptions<dynamic>(
      document: gql(qMiniProductsForCategory),
      variables: <String, dynamic>{
        "commerceID": commerceID,
        "category": category
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Query<dynamic>(
      options: _productsQueryOption(),
      builder: (productsResult, {fetchMore, refetch}) {
          // We show the loading progress if needed
        if (productsResult.isLoading) {
          return const Center(child: CircularProgressIndicator(),);
        }

        // We show error if any
        if (productsResult.hasException) {
          return const Align(
            alignment: Alignment.topCenter,
            child: ClStatusMessage(
              message: "Nous n'arrivons pas à charger les produits du commerces...",
            ),
          );
        }

        // We show a message if there is no commerce
        if (productsResult.data == null) {
          return const Align(
            alignment: Alignment.topCenter,
            child: ClStatusMessage(
              type: ClStatusMessageType.info,
              message: "Le commerce n'existe pas encore. Vérifiez que vous l'avez bien créé",
            ),
          );
        }

        final List mapProducts = productsResult.data!["commerce"]["products"]["edges"] as List;
        final List<Product> products = [];

        for (final mapProduct in mapProducts) {
          products.add(Product.fromJson(mapProduct["node"] as Map<String, dynamic>));
        }

        return ServicesProductsPickerRow(
          category: category, 
          initialProductsIDs: initialProductsIDs, 
          products: products, 
          onProductTapped: onProductTapped,
          onQuantityChanged: onQuantityChanged,
          initialQuantities: initialQuantities,
        );
      }
    );
  }
}