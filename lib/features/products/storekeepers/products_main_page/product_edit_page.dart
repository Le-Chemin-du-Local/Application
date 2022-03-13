import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/products/product.dart';
import 'package:chemin_du_local/features/products/products_graphql.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/widgets/product_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({
    Key? key, 
    required this.productID
  }) : super(key: key);

  final String? productID;

  QueryOptions<dynamic> _detailledProductQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qDetailledProduct),
      variables: <String, dynamic>{
        "productID": productID
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    // First case, it's a new product
    if (productID == null) {
      return _buildContent(null);
    }

    return Query<dynamic>(
      options: _detailledProductQueryOptions(),
      builder: (detailledProductResult, {fetchMore, refetch}) {
        // Show loading
        if (detailledProductResult.isLoading) {
          return const Center(child: CircularProgressIndicator(),);
        }

        // Show error if any
        if (detailledProductResult.hasException) {
          return const Align(
            alignment: Alignment.topCenter,
            child: ClStatusMessage(
              message: "Le produit n'a pas pu être chargé...",
            ),
          );
        }

        final Product product = Product.fromJson(detailledProductResult.data!["product"] as Map<String, dynamic>);

        return _buildContent(product);        
      },
    );
  }

  Widget _buildContent(Product? product) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          productID != null ? "Modifier un produit" : "Ajouter un produit"
        ),
      ),
      body: ProductEditForm(product: product),
    );
  }
}