import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/features/products/product_details_page/product_details_page.dart';
import 'package:chemin_du_local/features/products/products_graphql.dart';
import 'package:chemin_du_local/features/products/storekeepers/product_edit_page/product_edit_page.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_page/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({
    Key? key,
    required this.category,
    required this.onProductAdded(),
    required this.commerce,
    this.isStoreKeeper = false,
    this.showAppBar = true,
  }) : super(key: key);

  final Commerce? commerce;
  final String category;

  final bool isStoreKeeper;

  final Function() onProductAdded;

  final bool showAppBar;

  QueryOptions<dynamic> _procutsQueryOption() {
    return QueryOptions<dynamic>(
      document: gql(qMiniProductsForCategory),
      variables: <String, dynamic>{
        "commerceID": commerce?.id,
        "category": category
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? ClAppBar(
        canPop: Navigator.of(context).canPop(),
        title: Text(category),
      ) : null,
      body: Query<dynamic>(
        options: _procutsQueryOption(),
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

          return _buildContent(context, products: products, refetch: refetch);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, {
    required List<Product> products,
    Refetch? refetch,
  }) {
    return  Scaffold(
      body: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 182,
          mainAxisExtent: 273,
          crossAxisSpacing: 7,
          mainAxisSpacing: 24
        ),
        padding: const EdgeInsets.all(18),
        children: [
          for (final product in products) 
            InkWell(
              onTap: () => _openProductPage(context, product: product, refetch: refetch),
              child: ProductCard(
                product: product
              )
            )
        ]
      ),
      floatingActionButton: !isStoreKeeper ? null : FloatingActionButton(
        onPressed: () => _openProductPage(context, refetch: refetch),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future _openProductPage(BuildContext context, {
    Refetch? refetch,
    Product? product
  }) async {
    if (!isStoreKeeper) {
      await Navigator.of(context).push<dynamic>(
        MaterialPageRoute<dynamic>(
          builder: (context) => ProductDetailsPage(
            commerce: commerce!,
            productID: product?.id ?? ""
          )
        )
      );
    }
    else {
      final bool haveProductUpdate = await Navigator.of(context).push<bool?>(
        MaterialPageRoute<bool?>(
          builder: (context) => ProductPage(
            productID: product?.id,
          )
        )
      ) ?? false;

      if (haveProductUpdate) {
        if (refetch != null) {
          refetch();
        }

        onProductAdded();
      }
    }
  } 
}