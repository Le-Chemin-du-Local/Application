import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/edit_dialog/edit_dialog.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/layout_big.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/layout_small.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/header_image.dart';
import 'package:chemin_du_local/features/storekeepers/storekeepers_graphql.dart';
import 'package:chemin_du_local/features/user/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:sliver_tools/sliver_tools.dart';

class StoreKeeperPage extends StatelessWidget {
  const StoreKeeperPage({
    Key? key,
    this.storekeeperID,
    this.canEdit = false,
    this.onShowProducts,
    this.onShowDrawer
  }) : super(key: key);

  final String? storekeeperID;
  final bool canEdit;

  final Function()? onShowProducts; 

  final Function()? onShowDrawer;

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
    return Query<dynamic>(
      options: _commerceQueryOptions(),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator(),)
          );
        }    

        if (result.hasException) {
          return Scaffold(
            appBar: AppBar(),
            body: const Align(
              alignment: Alignment.topCenter,
              child: ClStatusMessage(
                message: "Nous ne parvenons pas à charger les informations du commerce...",
              )
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
          context,
          commerce: commerce,
          products: products,
          productsAvailableForClickAndCollect: commerce?.productsAvailableForClickAndCollect ?? [],
          refetch: refetch,
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, {
    required Commerce? commerce,
    required List<Product> products,
    required List<Product> productsAvailableForClickAndCollect,
    required Refetch? refetch,
  }) {
    return SafeArea(
      child: Scaffold(
        appBar: !canEdit ? null : ClAppBar(
          canPop: false,
          onShowDrawer: onShowDrawer,
          height: 90,
          backgroundColor: Colors.transparent,
          actions: [
            if (canEdit)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton.icon(
                  onPressed: () => _editPage(context, refetch, commerce), 
                  icon: const Icon(Icons.edit),
                  label: const Text("Modifier la page"),
                ),
              )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
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
      
                // Le contenu de la page
                SliverToBoxAdapter(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth >= ScreenHelper.breakpointPC) {
                        return LayoutBig(
                          commerce: commerce, 
                          products: products,
                          productsAvailableForClickAndCollect: productsAvailableForClickAndCollect,
                          enableAllProductsButton: !canEdit,
                          onShowProducts: onShowProducts ?? () {},
                          onShowMap: () => _openMaps(commerce: commerce),
                        );
                      }
        
                      return LayoutSmall(
                        commerce: commerce,
                        products: products,
                        productsAvailableForClickAndCollect: productsAvailableForClickAndCollect,
                        enableAllProductsButton: !canEdit,
                        onShowProducts: onShowProducts ?? () {},
                        onShowMap: () => _openMaps(commerce: commerce),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future _openMaps({
    required Commerce? commerce
  }) async {
    if (commerce == null) return;

    (await MapLauncher.installedMaps).first.showDirections(
      destination: Coords(
        commerce.latitude!,
        commerce.longitude!
      ),
      destinationTitle: commerce.name
    );
  }

  Future _editPage(BuildContext context, Refetch? refetch, Commerce? commerce) async {
    bool isSuccessfull = await showDialog<bool?>(
      context: context, 
      builder: (context) => EditDialog(commerce: commerce,)
    ) ?? false;

    if (isSuccessfull && refetch != null) {
      refetch();
    }
  }
}