import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/products/product.dart';
import 'package:chemin_du_local/features/products/products_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/widgets/panier_product_picker_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PanierProductPickerRow extends StatelessWidget {
  const PanierProductPickerRow({
    Key? key, 
    required this.initialProductsID, 
    required this.onProductTapped,
    required this.category,
    this.commerceID,
  }) : super(key: key);

  final List<String> initialProductsID;
  final Function(String) onProductTapped;

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

        return _buildContent(context, products: products);
      }
    );
  }

   Widget _buildContent(BuildContext context, {
    required List<Product> products,
   }) {
     return Column(
       mainAxisSize: MainAxisSize.min,
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: [
         // The header
         Flexible(
           child: Text(category),
         ),

         // The products list
         Flexible(
          child: GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 270,
              mainAxisExtent: 273,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16
            ),
            padding: const EdgeInsets.all(18),
            children: [
              for (final product in products) 
                InkWell(
                  onTap: () => onProductTapped(product.id!),
                  child: PanierProductCard(
                    product: product,
                    isSelected: initialProductsID.contains(product.id),
                  )
                )
            ]
                 ),
         ),
       ],
     );
   }
}