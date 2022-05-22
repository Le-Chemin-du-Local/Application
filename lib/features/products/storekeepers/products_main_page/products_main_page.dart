import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_floating_button.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/products/storekeepers/empty_products_page/empty_products_page.dart';
import 'package:chemin_du_local/features/products/products_graphql.dart';
import 'package:chemin_du_local/features/products/storekeepers/product_categories_page/product_categories_page.dart';
import 'package:chemin_du_local/features/products/storekeepers/product_edit_page/product_edit_page.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_page/products_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductsMainPage extends StatefulWidget {
  const ProductsMainPage({Key? key}) : super(key: key);

  @override
  State<ProductsMainPage> createState() => _ProductsMainPageState();
}

class _ProductsMainPageState extends State<ProductsMainPage> {
  String _currentCategory = "";

  QueryOptions<dynamic> _categoriesQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qCategories),
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Query<dynamic>(
      options: _categoriesQueryOptions(),
      builder: (categoriesQueryResult, {fetchMore, refetch}) {
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

        return _buildContent(commerce: commerce, refetch: refetch);        
      }
    );
  }
  
  Widget _buildContent({
    required Commerce commerce,
    required Refetch? refetch,
  }) {
    if (commerce.categories.isEmpty) {
       return EmptyProductsPage(
          onProductsAdded: () => _onProductAdded(refetch), 
          onAddProduct: () => _openProductCreationPage(refetch)
        );
    }
    if (commerce.categories.length == 1) {
      return ProductsPage(
        category: commerce.categories.first, 
        showAppBar: false,
        onProductAdded: () => _onProductAdded(refetch)
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isBigLayout = constraints.maxWidth >= ScreenHelper.breakpointPC;

         return SizedBox(
           width: constraints.maxWidth,
           child: Row(
            // mainAxisSize: MainAxisSize.min,
            children: [
              // The categories pannel
              Flexible(
                flex: isBigLayout ? 30 : 100,
                child: ProductCategoriesPage(
                  commerce: commerce,
                  currentCategory: _currentCategory,
                  onCategorySelected: (category) => _onCategorySelected(category, isBigLayout: isBigLayout, refetch: refetch),
                  onProductUpdated: () => _onProductUpdated(refetch),
                  showAddButton: !isBigLayout,
                ),
              ),
                  
              // If we have enough space it's better to show the products
              // on the side rather than on a new page
              if (isBigLayout)
                if (_currentCategory.isNotEmpty) 
                  Expanded(
                    flex: 70,
                    child: ProductsPage(
                      category: _currentCategory, 
                      showAppBar: false,
                      onProductAdded: () => _onProductAdded(refetch)
                    )
                  )
                else 
                  Expanded(
                    flex: 70,
                    child: Scaffold(
                      body: const Center(
                        child: Text("Veuillez selectionner une catégorie"),
                      ),
                      floatingActionButton: ClFloatingButton(
                        onPressed: () => _openProductCreationPage(refetch),
                        icon: Icons.add,
                      ),
                    )
                  )
            ],
          ),
        );
      } 
    );
  }

  Future _onCategorySelected(String category, {
    required bool isBigLayout,
    required Refetch? refetch,
  }) async {
    if (isBigLayout) {
      setState(() {
        _currentCategory = category;
      });
    }
    else {
      setState(() {
        _currentCategory = "";
      });

      await Navigator.of(context).push<dynamic>(
        MaterialPageRoute<dynamic>(
          builder: (context) => ProductsPage(
            category: category,
            onProductAdded: () => _onProductAdded(refetch),
          )
        )
      );
    }
  }

  void _onProductAdded(Refetch? refetch) {
    setState(() {
      _currentCategory = "";
    });
    
    if (refetch != null) refetch();
  }

  void _onProductUpdated(Refetch? refetch) {
    if (refetch != null) refetch();
  }

  Future _openProductCreationPage(Refetch? refetch) async {
    bool hasProductUpdate = await Navigator.of(context).push<bool?>(
      MaterialPageRoute<bool?>(
        builder: (context) => const ProductPage(
          productID: null,
        )
      )
    ) ?? false;

    if (hasProductUpdate && refetch != null) refetch();
  }
}