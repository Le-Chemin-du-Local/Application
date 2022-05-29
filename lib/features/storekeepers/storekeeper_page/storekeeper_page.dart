import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/layout_big.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/layout_small.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/header_image.dart';
import 'package:chemin_du_local/features/storekeepers/storekeepers_graphql.dart';
import 'package:chemin_du_local/features/user/user.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sliver_tools/sliver_tools.dart';

class StoreKeeperPage extends StatelessWidget {
  const StoreKeeperPage({
    Key? key,
    this.storekeeperID,
    this.canEdit = false
  }) : super(key: key);

  final String? storekeeperID;
  final bool canEdit;

  QueryOptions _commerceQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qGetStoreKeeperCommercePage),
      variables: <String, dynamic>{
        "id": storekeeperID,
      },
      fetchPolicy: FetchPolicy.noCache
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Query<dynamic>(
        options: _commerceQueryOptions(),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }    

          if (result.hasException) {
            return const Align(
              alignment: Alignment.topCenter,
              child: ClStatusMessage(
                message: "Nous ne parvenons pas à charger les informations du commerce...",
              )
            );
          }

          final User storeKeeper = User.fromJson(result.data!["user"] as Map<String, dynamic>);
          final Commerce? commerce = storeKeeper.commerce;

          final List mapProducts = result.data!["user"]["commerce"]["products"]["edges"] as List;
          final List<Product> products = [];

          for (final mapProduct in mapProducts) {
            products.add(Product.fromJson(mapProduct["node"] as Map<String, dynamic>));
          }

          return _buildContent(
            commerce: commerce,
            products: products,
            productsAvailableForClickAndCollect: commerce?.productsAvailableForClickAndCollect ?? [],
          );
        },
      ),
    );
  }

  Widget _buildContent({
    required Commerce? commerce,
    required List<Product> products,
    required List<Product> productsAvailableForClickAndCollect,
  }) {
    return CustomScrollView(
      controller: ScrollController(),
      slivers: [
        SliverStack(
          children: [
            // Le header de la page
            HeaderImage(
              storekeeperWord: commerce?.storekeeperWord ?? "Un petit mot", 
              commerceID: commerce?.id,
              canEdit: canEdit,
            ),

            // Le contenue de la page
            SliverToBoxAdapter(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth >= ScreenHelper.breakpointPC) {
                    return LayoutBig(
                      commerce: commerce, 
                      products: products,
                      productsAvailableForClickAndCollect: productsAvailableForClickAndCollect,
                    );
                  }
    
                  return LayoutSmall(
                    commerce: commerce,
                    products: products,
                    productsAvailableForClickAndCollect: productsAvailableForClickAndCollect,
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}