import 'package:chemin_du_local/core/widgets/cl_floating_button.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:chemin_du_local/features/products/products_graphql.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/product_edit_page.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/widgets/product_categorie_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductCategoriesPage extends StatefulWidget {
  const ProductCategoriesPage({
    Key? key,
    required this.onCategorySelected,
    required this.currentCategory,
    this.showAddButton = false,
    this.commerceID,
  }) : super(key: key);

  final String currentCategory;
  final String? commerceID;

  final bool showAddButton;

  final Function(String) onCategorySelected;

  @override
  State<ProductCategoriesPage> createState() => ProductCategoriesPageState();
}

class ProductCategoriesPageState extends State<ProductCategoriesPage> {
  Refetch? _refetch;

  void refetchData() {
    if (_refetch != null) {
      _refetch!();
    }
  }

  QueryOptions<dynamic> _categoriesQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qCategories),
      variables: <String, dynamic>{
        "commerceID": widget.commerceID
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Query<dynamic>(
      options: _categoriesQueryOptions(),
      builder: (categoriesQueryResult, {fetchMore, refetch}) {
        _refetch = refetch;

        // We show the loading progress if needed
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

        return _buildContent(commerce: commerce);        
      }
    );
  }

  Widget _buildContent({
    required Commerce commerce,
  }) {
    return Scaffold(
      body: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisExtent: 148,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16
        ),
        padding: const EdgeInsets.all(18.0),
        children: [
          for (final category in commerce.categories) 
            ProductCategoryCard(
              onClick: () => widget.onCategorySelected(category),
              categoryName: category,
            )
        ],
      ),
      floatingActionButton: !widget.showAddButton ? null : ClFloatingButton(
        onPressed: () => _openProductCreationPage(),
        icon: Icons.add,
      ),
    );
  }

  Future _openProductCreationPage() async {
    bool hasProductUpdate = await Navigator.of(context).push<bool?>(
      MaterialPageRoute<bool?>(
        builder: (context) => const ProductPage(
          productID: null,
        )
      )
    ) ?? false;

    if (hasProductUpdate && _refetch != null) _refetch!();
  }
}